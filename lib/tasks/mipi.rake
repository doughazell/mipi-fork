namespace :mipi do
  namespace :ftp_demo do 
   
    desc "Create FTP Demo Data"
    task :data => :environment do

      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:schema:load'].invoke
      Rake::Task['db:fixtures:load'].invoke
    
      Rake::Task['import:import_units'].invoke
      Rake::Task['import:import_stations'].invoke
    
      Rake::Task['import:import_data'].invoke('paul123@piguard.com','ftp.ip','data_domains.csv')
      Rake::Task['import:import_data'].invoke('paul123@piguard.com','ftp.ip','data_sub_domains.csv')
      Rake::Task['import:import_data'].invoke('paul123@piguard.com','ftp.ip','data_sets.csv')
      Rake::Task['import:import_data'].invoke('paul123@piguard.com','ftp.ip','data_line_items.csv')

    end

    desc "Create FTP Demo Presentation Layer"
    task :presentation => :environment do
    
      Rake::Task['import:link_data_sheet_to_data_element_type'].invoke('paul123@piguard.com','ftp','Data Domains','[All Data Domains]','data_domain_data_element')
      Rake::Task['import:link_data_sheet_to_data_element_type'].invoke('paul123@piguard.com','ftp','Data Sub Domains','[All Data Sub Domains]','data_sub_domain_data_element')
      Rake::Task['import:link_data_sheet_to_data_element_type'].invoke('paul123@piguard.com','ftp','Data Sets','[All Data Sets]','data_set_data_element')
      Rake::Task['import:link_data_sheet_to_data_element_type'].invoke('paul123@piguard.com','ftp','Data Items','[All Data Items]','data_line_item_data_element')

    end

    desc "Create FTP Demo Datasheets"
    task :data_sheets => :environment do

      Rake::Task['import:create_data_sheet_for_all_data_element_type'].invoke('paul123@piguard.com','ftp','Data Domains','data_domain')
      Rake::Task['import:create_data_sheet_for_all_data_element_type'].invoke('paul123@piguard.com','ftp','Data Sub Domains','data_sub_domain')
      Rake::Task['import:create_data_sheet_for_all_data_element_type'].invoke('paul123@piguard.com','ftp','Data Sets','data_set')
      Rake::Task['import:create_data_sheet_for_all_data_element_type'].invoke('paul123@piguard.com','ftp','Data Items','data_line_item')

    end

  end
end
