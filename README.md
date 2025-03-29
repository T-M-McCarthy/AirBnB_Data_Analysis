# AirBnB_Data_Analysis

Link to Dashboard:
https://public.tableau.com/app/profile/thomas.mccarthy8203/viz/AirBnB_Project_17432783993280/Dashboard1

Project Title: Airbnb Data Cleanup and Analysis

Objective:
This project aims to clean, transform, and analyze an Airbnb dataset to ensure consistency and accuracy, and extract meaningful insights for potential decision-making. The process includes handling missing data, standardizing column names, converting data types, and performing various analysis tasks to gain insights into Airbnb listings.

Project Outline:
Dataset Overview:

The dataset, airbnb_info, contains information on various Airbnb listings, including attributes such as listing names, host details, pricing, review counts, and other relevant metadata.

Data Cleaning:

Column Name Standardization:
Renamed columns to maintain consistency across the dataset. This included changing column names like NAME to name and host_identity_verified to host identity verified.

Data Type Modification:
The price and service fee columns were converted to DECIMAL type to ensure proper numerical calculations.

Data Transformation:
Removed dollar signs and commas from the price and service fee columns to convert them into clean numerical formats.

Handling Missing and Null Data:

Identified missing or null values across multiple columns using SQL queries.

Imputed missing values with default placeholders such as 'Not Verified' for textual data and -1 for numerical data.

Removed unnecessary columns (e.g., license) containing no usable information.

Data Integrity Check:

Removed rows or entries that were incomplete or redundant, ensuring that the dataset contains only accurate and usable data.

Data Analysis:

Duplicate Listings Identification:
Identified and highlighted duplicate listings based on name, host name, and neighbourhood, assisting in the cleanup process and preventing skewed analysis.

Price Analysis:
Identified the 10 most expensive listings and calculated the average price for each neighbourhood, providing a clearer picture of the price distribution across the platform.

Price Range Distribution:
Categorized listings into different price ranges (e.g., under $50, $50-$100) to understand the distribution of listings across various price points.

Review Analysis:
Identified the top 10 most reviewed listings, showcasing the listings with the highest engagement and user feedback.

Tools and Technologies Used:

SQL: For querying, cleaning, and transforming the data.

Database Management System (DBMS): SQL-based database to execute queries and manage data integrity.

Airbnb Dataset: A real-world dataset of Airbnb listings containing a range of attributes related to the listings.

Key Takeaways and Insights:
Improved Data Quality:
By standardizing column names, converting data types, and cleaning the dataset, the data is now consistent, making it ready for further analysis or reporting.

Identifying and Handling Missing Data:
The project highlights the importance of handling missing data, either by imputation or removal, to ensure that analyses yield reliable results.

Price and Review Insights:
The analysis reveals price trends across neighbourhoods and identifies highly reviewed listings, providing valuable insights for future decision-making, such as pricing strategies or marketing efforts.

Conclusion:
This project demonstrates my ability to clean, transform, and analyze raw data to generate meaningful insights. By leveraging SQL, I ensured that the dataset was ready for advanced analytics, helping to identify trends and patterns that would inform business decisions. This process exemplifies my ability to work with large datasets, handle data inconsistencies, and provide actionable insights based on comprehensive data analysis.
