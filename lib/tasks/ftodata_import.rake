namespace :ftodata do
  desc "Manage Globes through the command line"
  
  task :import_tlaf => :environment do
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
  
  task :import_units => :environment do
    require "highline/import"
    
    u = User.find_by_username('paul123')
    g = Globe.find_by_globe_reference('ftp')
    profile_id = g.profiles.find_by_name('Units').id

    line_count = 0
    puts "Opening file..."
    File.open("c:/development/mipi/test/data/generator_units.csv").each do |line|
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
    File.open("c:/development/mipi/test/data/power_stations.csv").each do |line|
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