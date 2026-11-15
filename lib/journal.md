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

