RestaurantReviews
=================

The Problem
--------------
Truefit is in the midst of building a mobile application that will let restaurant patrons rate the restaurant in which they are eating. As part of the build, we need to develop an API that will accept and store the ratings and other sundry data. 

For this project, we would like you to build this api. Feel free to add your own twists and ideas to what type of data we should collect and return, but at a minimum your API should be able to:

1. Get a list of restaurants by city
2. Post a restaurant that is not in the database
3. Post a review for a restaurant
4. Get of a list of reviews by user
5. Delete a review

Details
--------------
BLL exposes all of the methods and DTO exposes all return types. We can than create Web Serivces, Mobile Apps, and Web Project by  referencing the BLL and DTO, thus minimizing any refactoring when changes are made to the core API methods and eliminating and direct exposure to the Data Access Layer. I used a mixture of ADO and EF in the Data Access Layer to show expose the use of custom SQL data types.
