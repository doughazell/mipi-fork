module DataSheetsHelper

  def Data_Element_Properties_Popup(collection_name, data_element, database_column, options = {})
    render :partial => 'data_element_properties_popup',
            :locals => {
                  :collection_name => collection_name,
                  :data_element => data_element,
                  :database_column => database_column,
                  :options => options}
  end

  # Render a Label containing the database value that will be replaced by a text box upon a mouse click that
  # will allow the underlying data model to be updated through Ajax.
  # @param collection_name The name of the variable used to access the data within the partial being handled.
  # @param data_element The specific reference to the base DataElement(-derived) instance that contains the data needed to be displayed.
  # @param database_column The string representing the database column we are trying to access within the data model.
  # @param options Currently not implemented. This will be used to set more specific options around the construction of the HTML text box.
  # @author Paul Long
  def Label_TextBox_Switch(collection_name, data_element, database_column, options = {})
#    options = options.merge{ :collection_name => collection_name }
    render :partial => 'editable',
            :locals => {
                  :collection_name => collection_name,
                  :data_element => data_element,
                  :database_column => database_column,
                  :options => options}
  end

  def ForeignKey_PickList(collection_name, data_element, data_column, viewable_column_name, options = {})
    
    # Define the id and name of the HTML object. The 'name' is critical in order
    # for the data to be correctly interpreted at the server end.
    @tag_id = "#{data_element.type}_#{data_column}_#{data_element.id}".downcase
    @tag_name = "#{collection_name}[#{data_element.id}][#{data_column}]"
    
    # What is our current value, ensure this is selected in the dropdown.
    @default_id = eval("data_element.#{data_column}")

    logger.debug { "#{data_element}" }
    logger.debug { "data_element.#{data_column}" }
    logger.debug { @default_id }
    
    # This give us the class of our FK table.
    @fk_class_name = data_column[0..data_column.length-4].camelcase

    # Call the partial to write the select dropdown.
    render :partial => 'picklist_foreign_key',
            :locals => {
                  :viewable_column_name => viewable_column_name
            }
  end

  def Subscription_Data_Element(data_element, database_column, options = {})
    subscriptions = Subscription.find_all_references(data_element, database_column)
    if (subscriptions.nil?)
      render :partial => 'label',
             :locals => {
                  :data_element => data_element,
                  :database_column => database_column}
    else
      render :partial => 'subscription_label',
             :locals => {
                  :data_element => data_element,
                  :database_column => database_column,
                  :subscriptions => subscriptions}
    end
  end

  # This method has been set up to provide further details information regarding the element that has
  # been rendered. Currently not fully implemented.
  # @param collection_name The name of the variable used to access the data within the partial being handled.
  # @param data_element The specific reference to the base DataElement(-derived) instance that contains the data needed to be displayed.
  def Expand_Data_Element(collection_name, data_element)
    render :partial => 'expansion_tag',
            :locals => {
                  :collection_name => collection_name,
                  :data_element => data_element}
  end

  # @deprecated Replaced by a combination of Helper method and partial.
  def Label2TextBox2(data_element, database_column, options = {})
    data_element_id = data_element.id.to_i
#    hidden_data_element = "#{data_element.type}_#{database_column}_id"
    combined_id = "#{data_element.type}_#{database_column}_#{data_element_id}".downcase
#    combined_id = "#{data_element.type}_#{database_column}".downcase
    combined_id_region = "#{combined_id}_region".downcase
    combined_id_edit = "#{combined_id}_edit"
    combined_id_edit_region = "#{combined_id}_edit_region"
    combined_id_busy = "#{combined_id}_busy"
    tick = raw("&#10004;")
    hidden_data_element = "#{combined_id}_id"

    if !options[:size].presence then
      options[:size] = eval("data_element.#{database_column}").length
    end
    html = "<span>\n"
    fields_for "data_elements[]", data_element do |field|
    html += hidden_field_tag "#{data_element.type}[#{data_element.id}][id]", data_element.id
    html += "\n"
    html += "<span class='editable_region' id='"
    html += combined_id_region
    html += "' onclick=\"javascript:switch_edits('#{combined_id}', '#{combined_id_edit}');\">"
    html += "\n"
    html += "<label id=\"#{combined_id}\">"
    html += "\n"
    html += eval("data_element.#{database_column}")
    html += "\n"
    html += "</label>"
    html += "\n"
    html += "</span>"
    html += "\n"
    
    html += "<span style=\"display:none;\" class=\"editing_region\" id=\"#{combined_id_edit_region}\" >"
    html += "\n"
    html += text_field data_element.type, database_column, :id => combined_id_edit, :value => eval("data_element.#{database_column}"), :onBlur => "javascript:write_edit('#{combined_id}', '#{combined_id_edit}', '#{data_element_id}');", :onKeyPress => "javascript:handle_enter('#{combined_id}', '#{combined_id_edit}', event, '#{data_element_id}');"
    html += "\n"
    html += "<span id=\"#{combined_id_busy}\" style=\"display:none\">"
    html += "\n"
    html += image_tag 'ajax-loader.gif'
    html += "\n"
    html += "</span>"
    html += "\n"
    html += "</span>"
    html += "\n"
    html += "<span id=\"error_message_#{combined_id}\"></span>"
    html += "\n"
end
    html += "</span>"
    html += "\n"
    raw(html)
  end
  
  def Create_Default_Files(path_extension)
    new_css_folder = Rails.root + "/public/stylesheets/custom_styles/" + path_extension
    css_file_db = "/stylesheets/custom_styles/" + path_extension + "main"
    css_file = Rails.root + "/public/stylesheets/custom_styles/" + path_extension + "main.css"
    
    new_page_folder = Rails.root + "/app/views/data_sheets/pages/" + path_extension
    page_file_db = "/data_sheets/pages/" + path_extension + "main.html.erb"
    page_file = Rails.root + "/views/data_sheets/pages/" + path_extension + "_main.html.erb"
    
    FileUtils.mkdir_p(new_page_folder)
    FileUtils.mkdir_p(new_css_folder)
    
    FileUtils.cp(Rails.root + '/app/views/data_sheets/pages/_place_holder.html.erb', page_file)
    FileUtils.cp(Rails.root + '/public/stylesheets/custom_styles/_default_style.css', css_file)
  end
  
  def LinkDataSheet(data_element, display_name_column = 'name', options = {})
    presentations = []
    if (options[:data_sheet])
      puts "Specific Data Sheet: #{options[:data_sheet]}"
      ds = DataSheet.find_by_name(options[:data_sheet])
      if (!ds.nil?)
        presentations = Presentation.find(:all, :conditions => {:data_element_collection_id => data_element.data_element_collection_id, :data_sheet_id => ds.id})
      end
    else
      presentations = Presentation.find_other_data_sheets(data_element.data_element_collection_id, @active_data_sheet)
    end
    
    output = ''
    
#    puts "Presenting... #{unit.data_element_collection_id}, #{@active_data_sheet.id}"
    if presentations.count == 0
      output = data_element.name
    elsif presentations.count == 1
      if (options[:override_label])
        label = options[:override_label]
      else
        label = data_element.read_attribute(display_name_column)
        if label.nil? then label = data_element.read_attribute('name') end
      end
      output = link_to(label, preview_globe_profile_data_sheet_url(@globe, presentations[0].data_sheet.profile, presentations[0].data_sheet))
    else
      presentations.each do |presentation|
        if !presentation.data_sheet.nil? && presentation.data_sheet.profile_id != 0 then
          if (output != '')
            output = output + '<br/>'
          end
          output = output + link_to("#{data_element.read_attribute(display_name_column)} [#{presentation.data_sheet.display_name}]", preview_globe_profile_data_sheet_url(@globe, presentation.data_sheet.profile, presentation.data_sheet))
        end
      end
    end
    raw(output)
  end
end
