## Fixtures

In Data layer, a **fixture** is a representation (a _mock_) for the real data we want to work with.

In this project, we have a fixture for every data structure that the API could send us.

It's important the **the fixture matches the actual structure of the API data** (in this case, JSON). However, it doesn't matter what values we put in the structure.

Finally, we've added a high order function to read these files as a String and allocate them in the same folder.
