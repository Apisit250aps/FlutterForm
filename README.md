# flutter_form

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



Here’s a detailed API documentation for your endpoints using Markdown:

---

# API Documentation

## Base URL
```
https://wallet-api-7m1z.onrender.com/
```

## Endpoints

### Register
- **POST** `/auth/register`
- **Description:** Register a new user.
- **Request Body:**
  ```json
  {
    "username": "string",
    "password": "string"
  }
  ```
- **Response:**
  - **Status Code:** 201 Created
  - **Content:**
    ```json
    {
      "message": "User registered successfully."
    }
    ```
  - **Status Code:** 400 Bad Request
  - **Content:**
    ```json
    {
      "error": "Registration failed due to invalid data."
    }
    ```

### Login
- **POST** `/auth/login`
- **Description:** Authenticate a user and return a JWT token.
- **Request Body:**
  ```json
  {
    "username": "string",
    "password": "string"
  }
  ```
- **Response:**
  - **Status Code:** 200 OK
  - **Content:**
    ```json
    {
      "token": "string"
    }
    ```
  - **Status Code:** 401 Unauthorized
  - **Content:**
    ```json
    {
      "error": "Invalid username or password."
    }
    ```

### Get User Information
- **GET** `/user/information`
- **Description:** Retrieve user information.
- **Headers:**
  - **Authorization:** Bearer `<token>`
- **Response:**
  - **Status Code:** 200 OK
  - **Content:**
    ```json
    {
      "userId": "string",
      "username": "string",
      "fname": "string",
      "lname": "string"
    }
    ```
  - **Status Code:** 401 Unauthorized
  - **Content:**
    ```json
    {
      "error": "Invalid or missing token."
    }
    ```

### Set Profile
- **POST** `/user/set/profile`
- **Description:** Update user profile information.
- **Request Body:**
  ```json
  {
    "fname": "string",
    "lname": "string"
  }
  ```
- **Headers:**
  - **Authorization:** Bearer `<token>`
- **Response:**
  - **Status Code:** 200 OK
  - **Content:**
    ```json
    {
      "message": "Profile updated successfully."
    }
    ```
  - **Status Code:** 400 Bad Request
  - **Content:**
    ```json
    {
      "error": "Failed to update profile due to invalid data."
    }
    ```
  - **Status Code:** 401 Unauthorized
  - **Content:**
    ```json
    {
      "error": "Invalid or missing token."
    }
    ```

---

Feel free to adjust the content according to any additional specifics or requirements for your API.