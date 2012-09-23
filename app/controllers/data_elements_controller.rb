# This Controller may not be required!
class DataElementsController < ApplicationController
  include DataElementsHelper
  
  def index
    @globe = Globe.find(params[:globe_id])
    @shadowglobes = @globe.children
    @data_collections = DataElement.seek_collections_by_globe(@globe.id)
    respond_to do |format|
      format.html # index.html.erb
      format.xml # index.xml.erb
    end
  end
  
  def new
    @globe = Globe.find(params[:globe_id])
#    @data_element_type = params["data_element_type"]
    @data_element_type = params["new_data_element"]
    puts @data_element_type
    puts "-"
    if (!@data_element_type.blank?) then   # Javascript will be activated.
      @data_element_type = @data_element_type.singularize
      @data_element = @data_element_type.constantize.new
    else
      # SHOULD BE A BETTER WAY THAN THIS TO FIND ALL DATA_ELEMENT MODELS!!
      @derived_classes = DataElementCollection.all.uniq {|x| x.data_element_type }
    end

    respond_to do |format|
      if (@data_element_type) then   # Javascript will be activated.
        format.html { render('form', :submit_message => "Create", :url_path => globe_data_elements_url) }
      else
        format.html # new.html.erb
      end
      format.js
      format.xml  { render :xml => @data_element_collections }
    end
  end
  
  def edit
    @globe = Globe.find(params[:globe_id])
    @data_element = DataElement.find(params[:id])
    @data_element_type = @data_element.type
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @data_element }
    end
  end
  
  def update
    @globe = Globe.find(params[:globe_id])
    @data_element = DataElement.find(params[:id])
    @data_element_type = params[:data_element_type]
    
    respond_to do |format|
      if @data_element.update_attributes(params[@data_element_type.underscore])
#        format.html { redirect_to([@globe, @data_element], :controller => "data_element", :url => globe_data_element_url, :notice => 'Data Element was successfully updated.') }
        format.html { redirect_to globe_data_element_path(@globe, @data_element, :notice => 'Data Element was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @data_element.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def create
    @globe = Globe.find(params[:globe_id])
    @data_element_type = params[:data_element_type]
    name = params[@data_element_type.underscore]['name']
    
    dec = DataElementCollection.new(:name => name, :data_element_type => @data_element_type, :globe_id => @globe.id, :variable_name => @data_element_type.constantize::DEFAULT_VARIABLE_NAME)
    dec.save
    
    @data_element = @data_element_type.constantize.new(:name => name, :user_id => current_user.id, :globe_id => @globe.id, :data_element_collection_id => dec.id)
    
    # We're only interested in updating the columns from the derived table.
    columns = @data_element_type.constantize.column_names - DataElement.column_names
    
    # And only interested in updating parameters passed.
    columns = columns & params[@data_element_type.underscore].keys
    columns.each { |column|
      @data_element[column] = params[@data_element_type.underscore][column]
    }
    
    respond_to do |format|
      if @data_element.save
        @base_data_element = DataElement.find(@data_element.id)
#        format.html { redirect_to(@globe, :url => globe_data_elements_path, :notice => 'Globe was successfully created.') }
        format.html { redirect_to globe_data_element_path(@globe, @data_element, :notice => 'Data Element was successfully created.') }
        format.xml  { render :xml => @data_element, :status => :created, :location => @base_data_element }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @data_element.errors, :status => :unprocessable_entity }
      end
    end    
  end
  
  def destroy
    @globe = Globe.find(params[:globe_id])
    @data_element = @globe.data_elements.find(params[:id])
    @dec = @data_element.data_element_collection
    if @dec.data_elements.count == 1 then
      @dec.destroy
    end
    @data_element.destroy

    respond_to do |format|
      format.html { redirect_to(globe_data_elements_url) }
      format.xml  { head :ok }
    end

  end
  
  def show
    @globe = Globe.find(params[:globe_id])
    @data_element = DataElement.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @data_element }
      format.csv  { send_data @data_element.to_csv, :filename => @data_element.name + ".csv" }
    end
  end
  
  def change
    @data_element = DataElement.find(params[:id])
    @data_sheet = DataSheet.find(params[:data_sheet_id])
    @profile = Profile.find(params[:profile_id])
    @globe = Globe.find(params[:globe_id])

    respond_to do |format|
      if @data_element.update_attributes(params[:data_element])
        format.html { redirect_to(preview_globe_profile_data_sheet_path(@globe, @profile, @data_sheet), :notice => 'Data was successfully updated.') }
        #rescue render :partial => '/data_sheets/pages/missing_file.html.erb'
#        format.html { redirect_to(@data_element, :notice => 'Data was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @data_element.errors, :status => :unprocessable_entity }
      end
    end
  end

  # TODO: We want to be dynamic regarding the querying here so if a parameter is
  #       specified that exists as a column in the table we need to filter upon it.
  # TODO: We also need to be able to request all 'latest' data elements for a 
  #       particular type. e.g. all 'addresses', all 'phone numbers', all 'power
  #       stations'.
  # TODO: TACKLE THIS DIFFERENTLY. '/read/' for 'data_elememts'.
  #                                '/read_all/' for 'data_element_collections'
  def extract
    data_element_type = params[:data_element_type]
    data_element_name = params[:data_element_name]
    date = params[:date]
    
    if data_element_type["DataElement".length * -1, data_element_type.length] != "DataElement" then
      data_element_type += "DataElement"
    end 
    puts "#{data_element_type}"
    puts date
    if (date) then #.where("created_at >= :date", :date => @date) .where(:name => @data_element_name)
      @data_element = eval("#{data_element_type}").where("name = ? AND updated_at >= ?", data_element_name, date).order(:version).first
    else
      @data_element = eval("#{data_element_type}").find_last_by_name(data_element_name, :order => 'version')
    end
    
    puts @data_element.inspect
    # TODO
    # Loop through all the keys and change the value of anything ending in 'data-element-id'
    # since these will be foreign keys and need to be resolved/realised.

    respond_to do |format|
      format.xml { render :xml => @data_element }
      format.text { render :text => @data_element.to_csv }
      format.json { render :text => @data_element.to_json }
      format.yaml { render :text => @data_element.to_yaml }
#      format.xml { render :xml => @data_element }
    end
  end

  def extract_all
    globe = Globe.find_by_globe_reference!(request.subdomain)
    data_element_type = "#{params[:data_element_type].singularize}DataElement"
    des = Array.new
    
    des = globe.data_element_collections.find_top_level_data_elements(data_element_type)
    
#    data_element_collections = globe.data_element_collections
#    data_element_collections.each do |dec|
#      des.push(dec.current_data_element)
#    end
    
    respond_to do |format|
#      format.xml { render :xml => data_element_collections }
      format.json { render :json => des }
      format.yaml { render :text => des.to_yaml }
      format.text {
        output = data_element_type.constantize.column_names.join(',')
          output += '
'
        des.each { |o| 
          output += o.to_csv
          output += '
'
        }
        render :text => output
      } 
      format.xml { render :xml => des }
    end
  end
  
end

