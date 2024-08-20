/*
Data Cleaning Processes
1. Remove unneccessary by select the ones needed
2. Extract the YouTube cahnnel names from the first columns
3. Rename the columns
*/

SELECT *
FROM youtube_data_from_python

SELECT
	NOMBRE,
	total_subscribers,
	total_views,
	total_videos
FROM youtube_data_from_python

-- The CHARINDEX Function: Allows you to find the starting position of one  string inside another string
SELECT
	CHARINDEX('@', NOMBRE) as Position_of_@_in_NOMBRE, NOMBRE
FROM youtube_data_from_python

-- The SUBSTRING Function: Allows you to extract the data from each cells
-- First argument is NOMBRE (the column we want to extract from)
-- Second argument is the start of the string we want to extract from
-- Third is going to be the ending position of the string we want to extract from
-- Add -1 to get rid of the @ symbols

CREATE VIEW UK_youtubers_2024_view AS

SELECT CAST(SUBSTRING(NOMBRE, 1, CHARINDEX('@', NOMBRE)-1) AS varchar(100)) AS Channel_names,
	total_subscribers,
	total_views,
	total_videos
FROM youtube_data_from_python

SELECT *
FROM UK_youtubers_2024_view

/*
Data Quality test
1. The data needs to be 100 youtube channels (Row Count Test)
2. The columns need to be 4 (Column Count Test)
3. The channel name format must be string format and the other columns must be nmerical data type (Whole Numbers)
4. Each record must be unique in the dataset (Duplicate Count Test)

Row Count should be 100
Column Count should be 4

Data types
channel_name = VARCHAR
total_subscribers = INTEGER
total_views = INTEGER
total_videos = INTEGER

Duplicates = 0
*/

-- 1. Row Count Check
SELECT
	COUNT(*) AS Num_of_Rows
FROM UK_youtubers_2024_view

--2. Column Count Check
SELECT
	COUNT(*) AS Num_of_Columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UK_youtubers_2024_view'

--3. Data Type Check
SELECT
	COLUMN_NAME,
	DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'UK_youtubers_2024_view'

-- 4. Duplicate Count Check
SELECT
	Channel_names,
	COUNT(*) AS Count_Duplicate
FROM UK_youtubers_2024_view
GROUP BY Channel_names
HAVING COUNT(*) > 1

