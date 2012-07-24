DELETE		pres
FROM			presentations pres
INNER JOIN	data_sheets dats
ON				pres.data_sheet_id = dats.id
WHERE			data_element_collection_id
IN (
	SELECT 		id
	FROM			data_element_collections
	WHERE			id
	IN (
		SELECT		data_element_collection_id
		FROM			view_generator_unit_data_elements
		UNION
		SELECT		data_element_collection_id
		FROM			view_power_station_data_elements
	)
)

