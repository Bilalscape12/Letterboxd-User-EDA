This is a data analysis of Letterboxd user data which can be exported from the account settings.

## Table of Contents

- [Step 1: Database Creation](#step-1-database-creation)
- [Step 2: Data Imports](#step-2-data-imports)
- [Step 3: Data Wrangling](#step-3-data-wrangling)
- [Step 4: Data Analysis and Power BI Dashboard](#step-4-data-analysis-and-power-bi-dashboardd)

# Step 1: Database Creation

First, I started off by designing and creating a database to import the data into from the CSVs provided by Letterboxd.

Link to the script: [https://github.com/Bilalscape12/Letterboxd-User-EDA/blob/main/schema.sql](https://github.com/Bilalscape12/Letterboxd-User-EDA/blob/main/schema.sql)

<img width="1555" alt="initial ER diagram containing 9 tables" src="https://github.com/Bilalscape12/Letterboxd-User-EDA/blob/main/images/letterboxd-initial-erd.png">

# Step 2: Data Imports

After the database is created, the next step is to import the data. The exported Letterboxd data comes with many CSV files but this project only uses the 7 main files in the user directory and the 2 files in the likes directory for liked films and liked reviews. 
The script first copies the data into temporary tables which are then inserted into the database tables if the row does not already exist. This method of importing prevents duplication of existing rows.
Note that this script needs to be edited based on the file locations of the CSVs.

Link to the script: [https://github.com/Bilalscape12/Letterboxd-User-EDA/blob/main/data-imports.sql](https://github.com/Bilalscape12/Letterboxd-User-EDA/blob/main/data-imports.sql)

# Step 3: Data Wrangling

I found that while the data itself was clean, the original column formatting of the CSVs left a lot to be desired. For example, film ratings are stored in their own table separate from the watched films table but can (and should) easily be merged. 
Likewise, I decided to merge the diary and reviews tables. The last change I wanted to make, was to update the watch_date column in the watched table to store the earliest date possible for each film. 

Link to the script: [https://github.com/Bilalscape12/Letterboxd-User-EDA/blob/main/data-wrangle.sql](https://github.com/Bilalscape12/Letterboxd-User-EDA/blob/main/data-wrangle.sql)

<img width="1555" alt="ER diagram post-wrangling containing 2 less tables" src="https://github.com/Bilalscape12/Letterboxd-User-EDA/blob/main/images/letterboxd-wrangled-erd.png">

# Step 4: Data Analysis and Power BI Dashboard

Before continuing, I was able to get a few of my friends to share their data with me. 
Information about reviews, ratings, comments, likes, and relevant dates are stored in the CSVs. As such, a majority of the queries I made were related to the number of watched films, ratings, and dates.

Link to the script: [https://github.com/Bilalscape12/Letterboxd-User-EDA/blob/main/queries.sql](https://github.com/Bilalscape12/Letterboxd-User-EDA/blob/main/queries.sql)

Here is the dashboard I created through Power BI featuring data from me and 3 others:

<img width="2767" alt="Letterboxd Stats dashboard" src="https://github.com/Bilalscape12/Letterboxd-User-EDA/blob/main/images/letterboxd-dashboard.png">
