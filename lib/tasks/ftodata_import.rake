namespace :import do
  desc "Manage Globes through the command line"
  
  task :tlaf => :environment do
    require "highline/import"
    
#    str_filename = ask("Enter CSV file of TLAFs to load:")
#    File.open(str_filename).each do |line|

    u = User.find_by_username('paul123')
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

  task :import_data => :environment do
    require "highline/import"
    
    meta_data = Hash.new
    name_column = 0
    fk_tail = '_data_element'
    fk_tail_length = fk_tail.length

    u = User.find_by_username('paul123')
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

  task :data, [:username, :password] => :environment do |t, args|
    require "highline/import"
    
    meta_data = Hash.new
    name_column = 0
    fk_tail = '_data_element'
    fk_tail_length = fk_tail.length

    u = User.find_by_username('paul123')
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
  task :create_data_sheet_for_all_data_element_type => :environment do
    require "highline/import"
    
    u = User.find_by_username('paul123')

#    globe_reference = ask('Globe Reference?')
    globe_reference = 'ftp'
    g = Globe.find_by_globe_reference(globe_reference)

    puts "Profile List:"
    g.profiles.each do |profile|
      puts profile.name
    end
    profile_name = ask("Which profile?")
    p = Profile.find_by_globe_id_and_name(g.id, profile_name)

    data_element_stem = ask("Please enter the Model that you wish to create Data Sheets for each collection. OMit the '_data_element' section of the model.")
#    data_element_type = "data_domain_data_element"
    data_element_type = data_element_stem + "_data_element"
    
    html_file_name = "/data_sheets/pages/#{globe_reference}/#{data_element_stem}.html.erb"
    css_file_name = "/stylesheets/custom_styles/#{globe_reference}/#{globe_reference}.css"
    
    decs = DataElementCollection.find(:all, :conditions => { :globe_id => g.id, :data_element_type => data_element_type.camelcase })
    decs.each do |dec|
      ds = DataSheet.find_or_initialize_by_name_and_profile_id(dec.name, p.id)
      ds.style_sheets = css_file_name
      ds.file_location = html_file_name
      de = dec.data_elements.find(:last, :order => 'version')
      if (de) then
        de = de.type.constantize.find(de.id)
      end
      
      if (de)
        ds.display_name = de.friendly_name
      else
        ds.display_name = dec.name
      end
      ds.creator_id = u.id
      ds.updater_id = u.id
      ds.save

      pres = Presentation.find_or_initialize_by_data_sheet_id_and_data_element_collection_id(ds.id, dec.id)
      pres.save
    end

  end
  
  task :link_data_sheet_to_data_element_type => :environment do
    require "highline/import"
    
    u = User.find_by_username('paul123')
    g = Globe.find_by_globe_reference('ftp')
    
    puts "Profile List:"
    g.profiles.each do |profile|
      puts profile.name
    end
    profile_name = ask("Which profile?")
    p = Profile.find_by_globe_id_and_name(g.id, profile_name)

    puts "Data Sheets:"
    p.data_sheets.each do |data_sheet|
      puts data_sheet.name
    end
    data_sheet_name = ask("Please enter the 'Name' of the data sheet.")
#    data_sheet_name = "[All Data Sets]"
    data_element_type = ask("Please enter the Model that you wish to connect to this Data Sheet.")
#    data_element_type = "data_set_data_element"
    
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
    
    u = User.find_by_username('paul123')
    g = Globe.find_by_globe_reference('ftp')
    profile_id = g.profiles.find_by_name('Units').id

    line_count = 0
    puts "Opening file..."
    File.open("c:/development/ftp_demo/test/data/generator_units.csv").each do |line|
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

      end
      line_count = line_count + 1;
    end
  end

  task :import_stations => :environment do
    require "highline/import"
    
    u = User.find_by_username('paul123')
    g = Globe.find_by_globe_reference('ftp')
    profile_id = g.profiles.find_by_name('Stations').id
    
    line_count = 0
    puts "Opening file..."
    File.open("c:/development/ftp_demo/test/data/power_stations.csv").each do |line|
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