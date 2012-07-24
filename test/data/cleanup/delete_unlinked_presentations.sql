DELETE		pres
FROM			presentations pres
LEFT JOIN	data_sheets dats
ON 			pres.data_sheet_id = dats.id
WHERE			dats.id IS NULL
