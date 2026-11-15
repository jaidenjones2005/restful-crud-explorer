# RESTful CRUD Explorer Journal

## Phase 0: The Blueprint

### My Plan

For this project, I plan to create a Flutter application that manages a collection of digital albums using the JSONPlaceholder API.

The application will retrieve albums from the server and display them in a scrollable list. Each album will have information such as an ID, user ID, and title.

When a user selects an album, the application will display its details above the list. I plan to use a state variable to keep track of which album is currently selected.

The application will also allow users to delete a selected album by sending a request to the server. After a successful response, the application will clear the selected album and return to the list.

I also plan to include a loading indicator while waiting for the API and an error message if something goes wrong.

### Reflection

The most confusing part right now is understanding how Flutter will communicate with the API and turn the returned JSON data into album objects. I'm also unsure about how to update the screen after selecting or deleting an album. I plan to keep the code organized and work through each feature one step at a time.

## Phase 1: The List Operation

### What I Accomplished

In this phase, I connected my Flutter application to the JSONPlaceholder API using the http package. I created an Album model class to store the album ID, user ID, and title.

I also used FutureBuilder to handle loading, success, and error states. The albums are displayed in a scrollable list using ListView.builder.

### Reflection

The main difference between requesting a list of items and requesting a single item is how the data is processed. When requesting multiple albums, the API returns a JSON array that must be converted into a List of Album objects. A single album would return one JSON object instead.

This phase helped me understand how Flutter handles asynchronous API requests and displays data after it finishes loading.

## Phase 2: The Detail Operation

### What I Accomplished

In this phase, I added the ability to select an album from the list and view its details. I used a nullable Album variable called selectedAlbum to track which album is currently selected.

I also used setState to update the selected album when a user clicks on an item. The application now displays the album's ID, user ID, and full title above the list.

### Reflection

Using a state variable to switch between album details is different from navigating between pages because the application stays on the same screen. Instead of opening another page, Flutter rebuilds part of the interface based on the selected album.

This approach makes it easier to display information without adding more complicated navigation logic.

## Phase 3: The Delete Operation

### What I Accomplished

In this phase, I added a Delete Album button to the selected album details. When the button is clicked, the application sends an HTTP DELETE request using the selected album's ID.

I also added error handling and checked the server's response status before updating the interface. When the server returns status 200, the selected album is cleared and removed from the visible list.

### Reflection

Checking the status code is important because it confirms whether the server accepted the delete request. If the application updated the interface without checking the response, users might think an album was deleted even if the request failed.

I also learned that JSONPlaceholder is a testing API, so the deletion is not permanent. The application keeps track of deleted albums locally to make the interface behave as expected.

