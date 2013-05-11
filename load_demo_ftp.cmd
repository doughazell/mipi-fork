
call bundle exec rake import:import_units
call bundle exec rake import:import_stations
call bundle exec rake import:import_data[paul123@piguard.com,ftp,data_domains.csv]
call bundle exec rake import:import_data[paul123@piguard.com,ftp,data_sub_domains.csv]
call bundle exec rake import:import_data[paul123@piguard.com,ftp,data_sets.csv]
call bundle exec rake import:import_data[paul123@piguard.com,ftp,data_line_items.csv]
