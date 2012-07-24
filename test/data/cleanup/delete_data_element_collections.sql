DELETE
FROM			data_element_collections
WHERE			id
IN (
	SELECT		data_element_collection_id
	FROM			view_generator_unit_data_elements
	UNION
	SELECT		data_element_collection_id
	FROM			view_power_station_data_elements
)

