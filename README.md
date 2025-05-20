# JSON and Serialization

This repo aims to help people understand how does serialization work in Flutter, and how to parse JSON files in the background.</p>
It contains three showcases, one for how to manually parsing objects to JSON format, one for how to generated JSON code for complicated objects, and one 
for how to obtain JSON strings using API calls.</p>


### Setting up json_serializable in a project

To include json_serializable in your own project, you need one regular dependency, and two dev dependencies. 

To add the dependencies, run flutter pub add:

<code> flutter pub add json_annotation dev:build_runner dev:json_serializable </code>

### Parsing JSON in the background

<code> flutter pub add http </code></p>
For this repository, we are using the free API call from <https://openweathermap.org>. To utilize this function, create <code>.env</code> file with your API key under the root folder. </p>
The format is <code>API_KEY=...</code>

## Questions?
JSON documentation: <https://docs.flutter.dev/data-and-backend/serialization/json>. </p>
Slides (Login with SCU account): <https://docs.google.com/presentation/d/1x8XDomWpkKjyc07wazI-BauoF6yq8AkDbyeSSi4Zwwk/edit?usp=sharing> 

