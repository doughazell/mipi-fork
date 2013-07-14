UPDATE data_elements
SET most_recent = TRUE
FROM data_elements de
INNER JOIN
(
SELECT data_element_collection_id, MAX(version) AS version
FROM data_elements
GROUP BY data_element_collection_id
) t1
ON t1.data_element_collection_id = de.data_element_collection_id
AND t1.version = de.version



