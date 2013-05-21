namespace :import do
  desc "Manage Globes through the command line"
  
  task :tlaf => :environment do
    require "highline/import"
    
#    str_filename = ask("Enter CSV file of TLAFs to load:")
#    File.open(str_filename).each do |line|

    u = User.find_by_email('paul123@piguard.com')
    g = Globe.find_by_globe_reference('ftp')

    File.open("c:/development/mipi/test/data/tlafs_2012.csv").each do |line|
      values = line.split(',')
      ps = PowerStationDataElement.find_by_code(values[1])
      if (!ps.nil?) then
        label = "#{values[0]} #{values[1]} #{values[3]}".chop
        dec = DataElementCollection.find_by_name(label)

        if (dec.nil?) then
            dec = DataElementCollection.new :name => label, :data_element_type => 'TransmissionLossAdjustmentDataElement', :variable_name => '@tlaf', :page_limit => 0, :historic => 0, :globe => g
            dec.save
        end

        de = TransmissionLossAdjustmentDataElement.find_by_name(label)
        if (de.nil?) then
            de = TransmissionLossAdjustmentDataElement.new :name => label, :ready_to_archive => 0, :label => label, :globe => g, :creator => u, :updater => u, :month => values[0], :power_station_data_element => ps, :adjustment => values[2], :daytime_indicator => values[3], :user => u, :data_element_collection => dec, :mandatory => 0
        else
            de.adjustment = values[2]
            de.save
        end
      else
        puts "Unable to locate Power Station: #{values[1]}"
      end
      de.save
    end
  end

  # This routine attempts to make importing of DataElement-derived data into 
  # the data tool easier. It enforces a few conventions that need to be followed.
  #  - The file is comma-delimited.
  #  - There is a single header row.
  #  - There is no tail row.
  #  - The filename must the the 'lower_case_class_name' followed by '.csv'.
  #     e.g. my_data.csv will look for a class called MyDataDataElement
  #  - The must be a column called 'name' and this is the PK.
  # USAGE:
  #    C:\> rake import:import_data[paul@piguard.com,ftp,data_domains.csv]
  #
  # NOTE:
  #    Ensure that there is no space between 'import_data' and the first square
  #    bracket.
  #
  task :import_data, [:username, :globe, :datafile] => :environment do |t, args|
    require "highline/import"
    
    puts args
    
    meta_data = Hash.new
    name_column = 0
    fk_tail = '_data_element'
    fk_tail_length = fk_tail.length

    # Switching to parameter based task
#    u = User.find_by_email('paul123@piguard.com')
#    g = Globe.find_by_globe_reference('ftp')

    u = User.find_by_email(args[:username])
    g = Globe.find_by_globe_reference(args[:globe])

    # Doesn't appear required within this routine.       23-Apr-2013/PL
#    profile_id = g.profiles.find_by_name('Units').id

    # What is the file name?
#    data_to_import = ask("Which file would you like to import from the ROOT/test/data/ directory?")
#    data_to_import = "data_sub_domains.csv"
    data_to_import = args[:datafile]
    
    # Derive a class name. Clearly this means that using convention over
    # configuration we assume 'data_sub_domains.csv' relates to a claa
    # DataSubDomainDataElement
    file_name_stem = data_to_import[0..data_to_import.index('.')-1].singularize
    if (file_name_stem[file_name_stem.length - fk_tail_length..file_name_stem.length] != fk_tail) then
      data_element_name = file_name_stem + fk_tail
    end
    
    # Construct a class (this will check that the class is valid)
    data_element_name_camel = data_element_name.camelcase
    data_element_name_camel.constantize
    
    line_count = 0
    puts "Opening file...#{data_to_import}"
    # Replaced with join method. Should allow code to be more portable.
    #                                                          23-Apr-2013/PL
    File.open(Rails.root.join('test','data',data_to_import)).each do |line|
#    File.open("test/data/#{data_to_import}").each do |line|

      # Header Row
      if (line_count == 0) then
        # Place the columns into an Array
        columns = line.strip.split(',')
        
        # Seek out the 'name' column - it's compulsory.
        name_column = columns.index('name')
        raise "'name' column not specified." if name_column.nil?
        
        # Loop through each column
        columns.each do |column|
        
          # Our meta data (data about data) hash collects information
          # about our column.
          meta_data[column] = Hash.new
          
          # If the column name ends in '_data_element' we can be confident
          # that with convention over configuration that it is a Foreign Key.
          if column[fk_tail_length*-1,fk_tail_length] == fk_tail then
            meta_data[column]['primary_key'] = false
            meta_data[column]['foreign_key'] = true
          # 'Name' will always be our PK.
          elsif column == 'name'
            meta_data[column]['primary_key'] = true
            meta_data[column]['foreign_key'] = false
          # Otherwise, it's just a standard column.
          else
            meta_data[column]['primary_key'] = false
            meta_data[column]['foreign_key'] = false
          end
          # The position of the column is retained as well.
          meta_data[column]['index'] = columns.index(column)
        end # 'columns.each'

        puts meta_data.to_yaml
#        puts columns
#        puts name_column
#        puts meta_data
      else
        
        values = line.strip.split(',')

        # Retrieve the collection that this line will be added to.
        root_dec = DataElementCollection.find_or_initialize_by_name_and_data_element_type(values[name_column], data_element_name_camel)
        
#        if (root_dec.new_record?) then
          # Initialise some values if this is new.
          root_dec.update_attributes({
            :name => values[name_column],
            :page_limit => 1,
            :historic => 0,
            :variable_name => data_element_name_camel.constantize::DEFAULT_VARIABLE_NAME,
            :globe_id => g.id
          })
#        end
        
        # Find or create a new DataElement-derived object.
        root_object = data_element_name_camel.constantize.find_or_initialize_master_by_name(values[name_column])

        # A hash of values we want to update in the DataElement-derived object.
        to_update = Hash.new
        to_update['name'] = values[name_column]
        to_update['data_element_collection_id'] = root_dec.id
        to_update['user_id'] = u.id
        to_update['globe_id'] = g.id
        to_update['creator_id'] = u.id
        to_update['updater_id'] = u.id
        
        meta_data.each {|key, details|
          # Simple update. Just write the value to the root object.
          if (details['primary_key'] == false && details['foreign_key'] == false) then
#            puts key
#            puts details['index']
#            puts values[details['index']]
            to_update[key.to_sym] = values[details['index']].to_s if !values[details['index']].to_s.blank?
          elsif (details['primary_key'] == false && details['foreign_key'] == true) then
            fk_name = values[details['index']]
            puts fk_name
            
            # Find the FK. The latest version within the collection.
            fk = key.camelcase.singularize.constantize.find_or_initialize_master_by_name(fk_name)

            # Find the assocaiated collection.
            fk_dec = DataElementCollection.find_or_initialize_by_name_and_data_element_type(fk_name, key.camelcase)
            
            if (fk_dec.new_record?) then
              # Update the FK collection
              fk_dec.update_attributes({
                :name => fk_name,
                :page_limit => 1,
                :historic => 0,
                :variable_name => key.camelcase.constantize::DEFAULT_VARIABLE_NAME,
                :globe_id => g.id
              })
            end
            
            fk.update_attributes({
              :name => fk_name,
              :data_element_collection_id => fk_dec.id,
              :globe_id => g.id,
              :user_id => u.id,
              :creator_id => u.id,
              :updater_id => u.id
            })

            # Finally, simply update the root object with the FK ID.
#            root_object.update_attributes({"#{key}_id" => fk.id})
            to_update["#{key}_id"] = fk.id
          end # 'if (details['primary_key'] == false ...'
        } # 'meta_data.each'
		
        puts "-TRY-TO-WRITE-"
        puts to_update
        root_object.update_attributes(to_update)

        puts line
      end # 'if (line_count == 0)'
      line_count = line_count + 1
	  
    end # 'File.open()'
  end # 'task :import_data'

  task :data, [:username, :password] => :environment do |t, args|
    require "highline/import"
    
    meta_data = Hash.new
    name_column = 0
    fk_tail = '_data_element'
    fk_tail_length = fk_tail.length

    u = User.find_by_email('paul123@piguard.com')
    g = Globe.find_by_globe_reference('ftp')
    profile_id = g.profiles.find_by_name('Units').id

    # What is the file name?
    data_to_import = ask("Which file would you like to import?")
#    data_to_import = "data_sub_domains.csv"
    
    # Derive a class name
    file_name_stem = data_to_import[0..data_to_import.index('.')-1].singularize
    if (file_name_stem[file_name_stem.length - fk_tail_length..file_name_stem.length] != fk_tail) then
      data_element_name = file_name_stem + fk_tail
    end
    
    # Construct a class (this will check that the class is valid)
    data_element_name_camel = data_element_name.camelcase
    constant = Object
    check_object = constant.const_defined?(data_element_name_camel)
    if (!check_object) then
      if (!generate_new_model_from_file(data_to_import)) then
        raise "Unable to create a new model from #{data_to_import}"
      end
    end
    data_element_name_camel.constantize
    
    line_count = 0
    puts "Opening file..."
    File.open("test/data/#{data_to_import}").each do |line|
      if (line_count == 0) then
        columns = line.strip.split(',')
        name_column = columns.index('name')
        raise "'name' column not specified." if name_column.nil?
        columns.each do |column|
          meta_data[column] = Hash.new
          if column[fk_tail_length*-1,fk_tail_length] == fk_tail then
            meta_data[column]['primary_key'] = false
            meta_data[column]['foreign_key'] = true
          elsif column == 'name'
            meta_data[column]['primary_key'] = true
            meta_data[column]['foreign_key'] = false
          else
            meta_data[column]['primary_key'] = false
            meta_data[column]['foreign_key'] = false
          end
          meta_data[column]['index'] = columns.index(column)
        end
        
#        puts columns
#        puts name_column
#        puts meta_data
      else

        values = line.strip.split(',')

        # Retrieve the collection that this line will be added to.
        root_dec = DataElementCollection.find_or_initialize_by_name_and_data_element_type(values[name_column], data_element_name_camel)
        
#        if (root_dec.new_record?) then
          # Initialise some values if this is new.
          root_dec.update_attributes({
            :name => values[name_column],
            :page_limit => 1,
            :historic => 0,
            :variable_name => data_element_name_camel.constantize::DEFAULT_VARIABLE_NAME,
            :globe_id => g.id
          })
#        end
        
        root_object = data_element_name_camel.constantize.find_or_initialize_master_by_name(values[name_column])

        to_update = Hash.new
        to_update['name'] = values[name_column]
        to_update['data_element_collection_id'] = root_dec.id
        to_update['user_id'] = u.id
        to_update['globe_id'] = g.id
        to_update['creator_id'] = u.id
        to_update['updater_id'] = u.id
        
        meta_data.each {|key, details|
          # Simple update. Just write the value to the root object.
          if (details['primary_key'] == false && details['foreign_key'] == false) then
#            puts key
#            puts details['index']
#            puts values[details['index']]
            to_update[key.to_sym] = values[details['index']].to_s if !values[details['index']].to_s.blank?
          elsif (details['primary_key'] == false && details['foreign_key'] == true) then
            fk_name = values[details['index']]
            puts fk_name
            
            # Find the FK. The latest version within the collection.
            fk = key.camelcase.singularize.constantize.find_or_initialize_master_by_name(fk_name)

            # Find the assocaiated collection.
            fk_dec = DataElementCollection.find_or_initialize_by_name_and_data_element_type(fk_name, key.camelcase)
            
            if (fk_dec.new_record?) then
              # Update the FK collection
              fk_dec.update_attributes({
                :name => fk_name,
                :page_limit => 1,
                :historic => 0,
                :variable_name => key.camelcase.constantize::DEFAULT_VARIABLE_NAME,
                :globe_id => g.id
              })
            end
            
            fk.update_attributes({
              :name => fk_name,
              :data_element_collection_id => fk_dec.id,
              :globe_id => g.id,
              :user_id => u.id,
              :creator_id => u.id,
              :updater_id => u.id
            })

            # Finally, simply update the root object with the FK ID.
#            root_object.update_attributes({"#{key}_id" => fk.id})
            to_update["#{key}_id"] = fk.id
          end
        }
        puts "-TRY-TO-WRITE-"
        puts to_update
        root_object.update_attributes(to_update)

        puts line
      end
      line_count = line_count + 1
    end
  end
  
  def generate_new_model_from_file(data_to_import)
    false
  end

  # This will allow all generator units within the profile "units" to all have a data sheet
  # created and point to the same HTML.ERB file.
  task :create_data_sheet_for_all_data_element_type, [:username, :globe, :profile, :data_element_stem] => :environment do |t, args|
    require "highline/import"
    
#    puts args
#    puts args[:data_element_stem]
#    puts args[:data_element_stem].blank?
    
#    u = User.find_by_email('paul123@piguard.com')

#    globe_reference = ask('Globe Reference?')
    globe_reference = args[:globe]
#    g = Globe.find_by_globe_reference(globe_reference)

    u = User.find_by_email(args[:username])
    if (u.nil?) then
      # ABORT
    end
    
    g = Globe.find_by_globe_reference(globe_reference)
    if (g.nil?) then
      # ABORT
    end

    # Take the 'profile_name' from the argument list. If it does not exist
    # display all profiles for this globe and prompt the user for one of
    # them.
    profile_name = args[:profile]
    if profile_name.nil? then
      puts "Profile List:"
      g.profiles.each do |profile|
        puts profile.name
      end
      profile_name = ask("Which profile?")
    end
    
    # Retrieve the Profile object.
    p = Profile.find_by_globe_id_and_name(g.id, profile_name)

    # Take the 'data_element' name from the arguments. If it doesn't exist
    # prompt for the model that we wish to use.
    data_element_stem = args[:data_element_stem]
    if (data_element_stem.blank?) then
      data_element_stem = ask("Please enter the Model that you wish to create Data Sheets for each collection. Omit the '_data_element' section of the model.")
    end

#    data_element_type = "data_domain_data_element"
    data_element_type = data_element_stem + "_data_element"
    
    # Convention over configuration in action. These are the standard conventions
    # being used for the 'partial' and the CSS style sheet.
    html_file_name = "/data_sheets/pages/#{globe_reference}/#{data_element_stem}.html.erb"
    css_file_name = "/stylesheets/custom_styles/#{globe_reference}/#{globe_reference}.css"

    # Each collection of DataElements within this globe for this DataElement-derived type
    # will need to have a DataSheet reference created. This section will loop through
    # all of these collections and create (or find) 
    decs = DataElementCollection.find(:all, :conditions => { :globe_id => g.id, :data_element_type => data_element_type.camelcase })
    decs.each do |dec|
    
      # DataSheet manipulation
      ds = DataSheet.find_or_initialize_by_name_and_profile_id(dec.name, p.id)
      ds.style_sheets = css_file_name
      ds.file_location = html_file_name
      
      # Find the latest version of this DataElement-derived instance within
      # this collection. This only finds a DataElement object. We need the
      # inherited child.
      de = dec.data_elements.find(:last, :order => 'version')
      
      # If the DataElement exists...
      if (de) then
        # Find the inherited child.
        #    E.g. de.Class == AddressDataElement
        #         de.Class != DataElement
        de = de.type.constantize.find(de.id)
      end
      
      # The friendly_name method can be overriden in each inherited class.
      if (de)
        ds.display_name = de.friendly_name
      else
        ds.display_name = dec.name
      end
      
      # Basic user stuff.
      ds.creator_id = u.id
      ds.updater_id = u.id
      
      # Write the DataSheet to the database.
      ds.save

      # Create a 'presentation'. A link between a collection of DataElement-derived classes and
      # the DataSheet we just put together.
      pres = Presentation.find_or_initialize_by_data_sheet_id_and_data_element_collection_id(ds.id, dec.id)
      
      # Persist the 'presentation'.
      pres.save
    end

  end
  
  task :link_data_sheet_to_data_element_type, [:username, :globe, :profile, :data_sheet, :data_element_type] => :environment do |t, args|
    require "highline/import"
    
#    u = User.find_by_email('paul123@piguard.com')
#    g = Globe.find_by_globe_reference('ftp')
    
    globe_reference = args[:globe]
#    g = Globe.find_by_globe_reference(globe_reference)

    u = User.find_by_email(args[:username])
    if (u.nil?) then
      # ABORT
    end
    
    g = Globe.find_by_globe_reference(globe_reference)
    if (g.nil?) then
      # ABORT
    end

    profile_name = args[:profile]
    if profile_name.nil? then
      puts "Profile List:"
      g.profiles.each do |profile|
        puts profile.name
      end
      profile_name = ask("Which profile?")
    end
    p = Profile.find_by_globe_id_and_name(g.id, profile_name)

    data_sheet_name = args[:data_sheet]
    if data_sheet_name.nil? then
      puts "Data Sheets:"
      p.data_sheets.each do |data_sheet|
        puts data_sheet.name
      end
      data_sheet_name = ask("Please enter the 'Name' of the data sheet.")
    end

    data_element_type = args[:data_element_type]
    if data_element_type.nil? then
      data_element_type = ask("Please enter the Model that you wish to connect to this Data Sheet.")
    end
    
    ds = DataSheet.find_by_profile_id_and_name(p.id, data_sheet_name)
    decs = DataElementCollection.find(:all, :conditions => { :globe_id => g.id, :data_element_type => data_element_type.camelcase })
    
    puts decs.count
    decs.each do |dec|
      pres = Presentation.find_or_initialize_by_data_sheet_id_and_data_element_collection_id(ds.id, dec.id)
      pres.save
    end
  end

  
  task :import_units => :environment do
    require "highline/import"
    
    u = User.find_by_email('paul123@piguard.com')
    g = Globe.find_by_globe_reference('ftp')
    profile_id = g.profiles.find_by_name('Units').id

    line_count = 0
    puts "Opening file..."
#    File.open("c:/development/70 - Data/ftp/generator_units.csv").each do |line|
    # 31/3/13 DH: Generating relative rails paths.
	File.open(Rails.root.join('test','data','generator_units.csv')).each do |line|
      if (line_count == 0) then
        columns = line.split(',')
      else
  #      puts line
        values = line.split(',')
        
        # Create or find the data element collections in order to retain
        # history.
        
        gu_de = DataElementCollection.find_or_initialize_by_name_and_data_element_type("GU_#{values[0]}",'GeneratorUnitDataElement')
        ps_de = DataElementCollection.find_or_initialize_by_name_and_data_element_type("ST_#{values[2]}",'PowerStationDataElement')
        
        gu_de.update_attributes({
          :name => "GU_#{values[0]}",
          :page_limit => 1,
          :historic => 0,
          :variable_name => '@unit',
          :globe_id => g.id
        })
        
        ps_de.update_attributes({
          :page_limit => 1,
          :historic => 0,
          :variable_name => '@station',
          :globe_id => g.id
        })
        
        # Create all the database objects we'll need.
        gu = GeneratorUnitDataElement.find_or_initialize_master_by_name("GU_#{values[0]}")
        ps = PowerStationDataElement.find_or_initialize_master_by_name("ST_#{values[2]}")
        
        ps.update_attributes({
          :name => "ST_#{values[2]}",
          :code => values[2],
          :data_element_collection_id => ps_de.id,
          :globe_id => g.id,
          :user_id => u.id,
          :creator_id => u.id,
          :updater_id => u.id
        })
  
        gu.update_attributes({
          :name => "GU_#{values[0]}",
          :fixed_heat_constant => values[3],
          :installed_capacity => values[1],
          :start_hours_hot => values[4],
          :start_hours_cold => values[5],
          :power_station_data_element_id => ps.id,
          :code => values[0],
          :data_element_collection_id => gu_de.id,
          :user_id => u.id,
          :creator_id => u.id,
          :updater_id => u.id,
          :globe_id => g.id
        })
        
        # Locate the Data Sheet: "All Units" and link the new generator
        # unit into this if it isn't already.
        ds_gunits = DataSheet.find_by_name('All Units')
        p = Presentation.find_or_initialize_by_data_sheet_id_and_data_element_collection_id(ds_gunits.id, gu_de.id)
        p.save

        ds_pstations = DataSheet.find_by_name('All Stations')
        p = Presentation.find_or_initialize_by_data_sheet_id_and_data_element_collection_id(ds_pstations.id, ps_de.id)
        p.save

        # Locate the Data Sheet: "Generator: XXX" and link the new generator
        # unit into this if it isn't already.
        ds_new = DataSheet.find_or_initialize_by_name(:name => "GU_#{gu.code}")
        ds_new.update_attributes({
          :display_name => "#{gu.name}",
          :style_sheets => "/stylesheets/custom_styles/ftp/ftp.css",
          :profile_id => profile_id,
          :file_location => "/data_sheets/pages/ftp/generator.html.erb",
          :creator_id => u.id,
          :updater_id => u.id
        })

        p = Presentation.find_or_initialize_by_data_sheet_id_and_data_element_collection_id(ds_new.id, gu_de.id)
        p.save

      end # 'if (line_count == 0)'
      line_count = line_count + 1;
	  
    end # 'File.open()'
  end # 'task :import_units'

  task :import_stations => :environment do
    require "highline/import"
    
    u = User.find_by_email('paul123@piguard.com')
    g = Globe.find_by_globe_reference('ftp')
    profile_id = g.profiles.find_by_name('Stations').id
    
    line_count = 0
    puts "Opening file..."
    File.open("test/data/power_stations.csv").each do |line|
      if (line_count == 0) then
        columns = line.split(',')
      else
        values = line.split(',')
        puts values

        # Find or create the power stations COLLECTION being described.
        ps_de = DataElementCollection.find_or_initialize_by_name_and_data_element_type("ST_#{values[1]}",'PowerStationDataElement')
        ps_de.update_attributes({
          :name => "ST_#{values[1]}",
          :page_limit => 1,
          :historic => 0,
          :variable_name => '@station',
          :globe_id => g.id
        })

        # Now, within this collection there may (or may not) be a whole series of data_element
        # instances that will describe this particular power station. Let's find the 'master'.
        ps = PowerStationDataElement.find_or_initialize_master_by_name("ST_#{values[1]}")
        
        ps.update_attributes({
          :name => "ST_#{values[1]}",
          :code => values[1],
          :full_name => values[0],
          :data_element_collection_id => ps_de.id,
          :primary_fuel_type => values[2],
          :globe_id => g.id,
          :user_id => u.id,
          :creator_id => u.id,
          :updater_id => u.id
        })
  
        ds_pstations = DataSheet.find_by_name('All Stations')
        p = Presentation.find_or_initialize_by_data_sheet_id_and_data_element_collection_id(ds_pstations.id, ps_de.id)
        p.save

        # Locate the Data Sheet: "Station: XXX" and link the new generator
        # unit into this if it isn't already.
        ds_new = DataSheet.find_or_initialize_by_name(:name => "ST_#{ps.code}")
        ds_new.update_attributes({
          :name => "ST_#{ps.code}",
          :display_name => "#{ps.name}",
          :style_sheets => "/stylesheets/custom_styles/ftp/ftp.css",
          :profile_id => profile_id,
          :file_location => "/data_sheets/pages/ftp/station.html.erb",
          :creator_id => u.id,
          :updater_id => u.id
        })

        p = Presentation.find_or_initialize_by_data_sheet_id_and_data_element_collection_id(ds_new.id, ps_de.id)
        p.save

      end
      line_count = line_count + 1;
    end
  end
end