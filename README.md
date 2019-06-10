# the-api-awakens

## iOS Techdegree Project 5

Using what you learned about APIs, Networking, Concurrency, and JSON you will get information about all types of Star Wars entities from the Star Wars API: https://swapi.co/

In the mockup, you will notice that regardless of which view a user is on, there is a bar across the top showing the largest and smallest member of the group. In addition, because all measurements are given in metric units (meters), you will need to create a feature that convert the units to British units (inches), at a tap of a button. For starships and vehicles, students will need to create a button that can convert “Galactic Credits” to US Dollars, based on a exchange rate provided by the user in a text field.

<img src="https://github.com/elenamene/the-api-awakens/blob/master/appImages/starWarsApp02%402x.png">
<img src="https://github.com/elenamene/the-api-awakens/blob/master/appImages/starWarsApp01%402x.png">

### Required Tasks

1. Create the appropriate types for people, vehicles, and starships. Consider your options in terms of structs, classes, composition, inheritance, etc.

2. Create asynchronous networking code to retrieve JSON results from the SWAPI API. Make sure your code is reusable for the different entities (people, vehicles, starships) that you will be handling and displaying.

3. Create logic to parse the JSON result and display the names of all members of the entities in the Picker Wheel. 

4. Use a single layout for displaying the resource attributes and change/show/hide UI elements programmatically.

5. Create logic such that when a user selects from the pick wheel, all the related fields on the screen are being populated.

6. Create logic to populate the Quick Facts Bar. You may want to use generics for this.

7. Create a feature such that a user can convert metric units (meters) to British units (inches) with a tap of a button.

8. Create a feature such that a user can input an exchange rate in a text field and then convert between Galactic Credits and US Dollars.

9. Add error handling which include, but not limited to:
  - The device going offline when an API call is in progress
  - A user entering a 0 or negative exchange rate
  - An error resulting from a key or element missing from the JSON returned from the API

### Extra Credit

* When a person is selected, all (if any) associated vehicles, starships anfd films are listed as well

* All the data returned from the API is used to populate the picker, not just the first page of returned data

### Personal Enhancements

* Added app icon and launch screen
* Added a search bar inside the navigation bar that returns all entitites types with the possibily to filter results
* Quick bar is also present inside the film section returning the newest and oldest film
* Added Film category, each film display a list of characters, starships and vehicles appeard in it
