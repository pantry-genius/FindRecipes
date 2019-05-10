fuck git
# FindRecipes
Group Project
lmaoooo
===

# Pantry Genius (Meal helper)

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
[ Upon downloading, the user first inputs about 10 food items that they have at the house.  From there a number of meals are generated to suggest what he/she should cook. ]

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Food
- **Mobile:**  Its easier to input items you're looking at while stading (since you'll need to check whats in your fridge and cabnets ) with a phone than a computer.  Also when you're cooking the meal suggested, referencing a phone in your hand will be much easier than a laptop that could potentially get messed up much easier in the kitchen.
- **Story:**  Do you ever have trouble coming up with a meal to cook even though you have ingredients to make stuff ?  Are you tired of cooking the same old meal ? Well with the "Pantry Genius" you can take that problem away.  It autogenerates different meals.
- **Market:** People who cook.  This would be more helpful for those who dont cook often and need inspiration.
- **Habit:** Deciding what to eat is a daily effort and Pantry Genius would streamline this process for the user. 
- **Scope:** Pantry Genius would initally focus solely on the input of ingredients and return possible recipes for the items. Further implementations would allow for user submission of recipes and a ranking ability to categorize popular/less popular recipes. 

## Product Spec
### Milestone 1 Walkthrough GIF
<img src="http://g.recordit.co/CtDCFoCAlO.gif" width=250><br>

### 1. User Stories (Required and Optional)
**Required Must-have Stories**
- [x] Enter about 20 food items ( Items are saved )
- [x] View that generates a few meals to cook
- [] Create account, Sign In
- [] View to search for a recipe
- [] Collection view of other user recipes
- [] Settings -> create a profile

**Optional Nice-to-have Stories**
- [] Users can submit their own recipes
- [] Dark vs Light mode
- [] Leave comments on others recipes
- [] Downvote or upvote recipes
- [] User can favorite recipes they like

### 2. Screen Archetypes

* Input Screen
    * User can input ingredients and search for recipes
* Recipe Screen
    * User can view a collection of recipes
    * can set level of difficulty of making the meal.  Ex.  casserole is harder to make than spaghetti  
    * can set the amount of time you want to devote to making the meal 
    * ACCOUNT ONLY: upload meal
* Login/Create Account Screen
    * User can log in
* Settings Screen
    * User can add profile picture
    * User can change username 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* add ingredients controller
* mealscontroller
* recipes controller

**Flow Navigation** (Screen to Screen)

* addingredientcontroller -> mealcontroller -> recipescontroller

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="<a href="https://ibb.co/Twc3MZ4"><img src="https://i.ibb.co/mRJW5m9/Scannable-Document-on-Apr-22-2019-at-6-54-20-PM.png" alt="Scannable-Document-on-Apr-22-2019-at-6-54-20-PM" border="0"></a>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

### Models

### Networking
- Home Feed (Input Ingredients)
    - (Read/GET) Query all ingredients for specific user

- Sign In/ Sign Up Screen
    - (Create/POST) User creates an account
    - (Read/GET) Query User logged in
    - (Update/PUT) User updates profile image
        
- Profile Screen
    - (Read/Get) Fetch user's saved recipes 
    
### Spoonacular API
    - Base Url: https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/

| Property | Type     | 
| -------- | -------- | 
| GET (required params) | findByIngredients?ingredients=apples%2Cflour%2Csugar 
| GET (optional params)| findByIngredients?number=5&ranking=1&ignorePantry=false&ingredients=apples%2Cflour%2Csugar 

| Sub-Property | Description     | 
| -------- | -------- |
ingredients (required)| A comma-separated list of ingredients that the recipes should contain.
number (optional) | The maximal number of recipes to return (default = 5)
ranking (optional)  |  Whether to maximize used ingredients (1) or minimize missing ingredients (2) first.
ignorePantry (optional) | Whether to ignore pantry ingredients such as water, salt, flour etc..


    - URL to GET request documentation: https://rapidapi.com/spoonacular/api/recipe-food-nutrition?endpoint=55e1b3e1e4b0b74f06703be6
