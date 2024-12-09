# Website

This folder contains the static assets and scripts for the front-end of the project. It serves as the user interface for interacting with the deployed API Gateway and Lambda-based backend. The website is designed to provide an intuitive interface for adding items and retrieving them by email.

## Folder Contents

### Files
1. **`index.html`**:
   - The main HTML file for the website.
   - Contains the structure of the front-end interface, including forms for adding and searching items.
   - Links to the `script.js` file for functionality.

2. **`script.js`**:
   - The core JavaScript file for handling API requests.
   - Features the following functionality:
     - Sends `POST` requests to add new items.
     - Sends `GET` requests to search for items by email.
     - Handles CORS and displays API responses dynamically in the browser.

3. **`styles.css`** (if present):
   - Defines the styling for the website, including layout, colors, and fonts.

## Website Functionality

### Features
1. **Add New Items**:
   - Users can enter their name and email in a form and submit the data.
   - The data is sent via a `POST` request to the `/items` endpoint of the API Gateway.

2. **Search Items by Email**:
   - Users can enter an email address to search for items associated with it.
   - The data is retrieved via a `GET` request to the `/items` endpoint.

3. **Dynamic Response Handling**:
   - API responses are displayed dynamically in the browser without requiring a page reload.

## Setup and Usage

### Prerequisites
- Ensure the back-end API (API Gateway and Lambda) is deployed and functional.
- Retrieve the API base URL (`api_url`) from the Terraform deployment output.

---

## Notes

- **CORS Configuration**:
  - Ensure the API Gateway and Lambda include proper CORS headers, as required by modern browsers.
