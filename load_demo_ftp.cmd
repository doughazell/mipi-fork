
call bundle exec rake import:import_units
call bundle exec rake import:import_stations
call bundle exec rake import:import_data[paul123@piguard.com,ftp,data_domains.csv]
call bundle exec rake import:import_data[paul123@piguard.com,ftp,data_sub_domains.csv]
call bundle exec rake import:import_data[paul123@piguard.com,ftp,data_sets.csv]
call bundle exec rake import:import_data[paul123@piguard.com,ftp,data_line_items.csv]
call bundle exec rake import:create_data_sheet_for_all_data_element_type['paul123@piguard.com','ftp','Data Domains','data_domain']
call bundle exec rake import:create_data_sheet_for_all_data_element_type['paul123@piguard.com','ftp','Data Sub Domains','data_sub_domain']
call bundle exec rake import:create_data_sheet_for_all_data_element_type['paul123@piguard.com','ftp','Data Sets','data_set'
call bundle exec rake import:create_data_sheet_for_all_data_element_type['paul123@piguard.com','ftp','Data Line Item','data_line_item']

