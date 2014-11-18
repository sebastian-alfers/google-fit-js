# Google Fit JS Example

A sample application to show how to use Google Fit REST api.

## Use tools

* yeoman.io to bootstrap the app
* grunt to run the dev environment
* bower to handle dependencies
* angularJs (CoffeeScript)
* "Google APIs Client Library for JavaScript" to handle OAuth2 (https://code.google.com/p/google-api-javascript-client/)

## Usage

Install node dependencies:

    $ npm install

Create a config file '.gFitCredentials' to store local / production Google API Credentials

     {
       "dev": {
         "clientCode": "your-client-code-here",
         "clientId": "your-client-id-here",
         "apiKey": "your-api-key-here"
       },
       "prod": {
         "clientCode": "your-client-code-here",
         "clientId": "your-client-id-here",
         "apiKey": "your-api-key-here"
       }
     }

Create index.html file for local credentials. Please configure the credentials in your Google Developer Console

     $ grunt concat:dev

To use prod credentials, type:

     $ grunt concat:prod

To start a local development server, type:

      $ grunt serve
