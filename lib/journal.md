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

