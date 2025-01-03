# Shopping App

## Description
This Flutter app demonstrates a shopping interface featuring:
- A PageView for products.
- A GridView for product cards with "add to cart" functionality.
- A horizontal ListView for hot offers.

## Features
- Responsive UI using `MediaQuery`.
- SnackBar for feedback when adding items to the cart.
- Sign-Up Page:
    Validates user input with the following checks:
    Full Name must start with a capital letter.
    Email must contain the @ symbol.
    Password must have a minimum of 6 characters.
    Confirm Password must match the Password.
    Displays appropriate error messages using Validator.
    On successful sign-up, shows a success dialog and navigates to the shopping screen.

## Animations:
- After signing up successfully, a fade-out animation transitions from the Signup   
  Page to the Shopping Page.
- Customizable animation duration.
