call bundle exec rake db:create
call bundle exec rake db:migrate
call bundle exec rake db:fixtures:load
echo Update the User.first password.
pause
call bundle exec rake import:import_units
call bundle exec rake import:import_stations
call bundle exec rake import:import_data[paul123@piguard.com,ftp,data_domains.csv]
call bundle exec rake import:import_data[paul123@piguard.com,ftp,data_sub_domains.csv]
call bundle exec rake import:import_data[paul123@piguard.com,ftp,data_sets.csv]
call bundle exec rake import:import_data[paul123@piguard.com,ftp,data_line_items.csv]
echo Configure the Profiles and Data Sheets
pause
call bundle exec rake import:link_data_sheet_to_data_element_type[paul123@piguard.com,ftp,'Data Domains','[All Data Domains]',data_domain_data_element]
call bundle exec rake import:link_data_sheet_to_data_element_type[paul123@piguard.com,ftp,'Data Sub Domains','[All Data Sub Domains]',data_sub_domain_data_element]
call bundle exec rake import:link_data_sheet_to_data_element_type[paul123@piguard.com,ftp,'Data Sets','[All Data Sets]',data_set_data_element]
call bundle exec rake import:link_data_sheet_to_data_element_type[paul123@piguard.com,ftp,'Data Items','[All Data Items]',data_line_item_data_element]
call bundle exec rake import:create_data_sheet_for_all_data_element_type['paul123@piguard.com',ftp,'Data Domains',data_domain]
call bundle exec rake import:create_data_sheet_for_all_data_element_type['paul123@piguard.com',ftp,'Data Sub Domains',data_sub_domain]
call bundle exec rake import:create_data_sheet_for_all_data_element_type['paul123@piguard.com',ftp,'Data Sets',data_set]
call bundle exec rake import:create_data_sheet_for_all_data_element_type['paul123@piguard.com',ftp,'Data Items',data_line_item]
echo Ensure the [Hierarchy] profile and data sheet are created.
pause
call bundle exec rake import:link_data_sheet_to_data_element_type[paul123@piguard.com,ftp,'Data Hierarchy','[Hierarchy]',data_domain_data_element]
call bundle exec rake import:link_data_sheet_to_data_element_type[paul123@piguard.com,ftp,'Data Hierarchy','[Hierarchy]',data_sub_domain_data_element]
call bundle exec rake import:link_data_sheet_to_data_element_type[paul123@piguard.com,ftp,'Data Hierarchy','[Hierarchy]',data_set_data_element]
call bundle exec rake import:link_data_sheet_to_data_element_type[paul123@piguard.com,ftp,'Data Hierarchy','[Hierarchy]',data_line_item_data_element]