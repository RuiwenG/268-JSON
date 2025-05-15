# JSON and Serialization

This repo aims to help people understand how does serialization work in Flutter, and how to parse JSON files in the background.

## Getting Started

### Setting up json_serializable in a project

To include json_serializable in your project, you need one regular dependency, and two dev dependencies. In short, dev dependencies are dependencies that are not included in our app source code—they are only used in the development environment.

To add the dependencies, run flutter pub add:

<code> flutter pub add json_annotation dev:build_runner dev:json_serializable </code>

Run flutter pub get inside your project root folder (or click Packages get in your editor) to make these new dependencies available in your project.

### Parsing JSON in the background

<code> flutter pub add http </code>
