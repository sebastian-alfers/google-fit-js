<!doctype html>
<html class="no-js">
  <head>
    <meta charset="utf-8">
    <title></title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">
    <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
    <!-- build:css(.) styles/vendor.css -->
    <!-- bower:css -->
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.css" />
    <!-- endbower -->
    <!-- endbuild -->
    <!-- build:css(.tmp) styles/main.css -->
    <link rel="stylesheet" href="styles/main.css">
    <link rel="stylesheet" href="styles/custom.css">
    <!-- endbuild -->
  </head>
  <body ng-app="gFitJsApp">
    <!--[if lt IE 7]>
      <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->

    <!-- Add your site or application content here -->
    <div class="container">
      <div class="header">
        <ul class="nav nav-pills pull-right">
          <li id="login" class="nav"><a ng-href="#/login">Login</a></li>
          <li id="start" class="nav"><a ng-href="#/">Start Session</a></li>
        </ul>
        <h3 class="text-muted">Google Fit with JS - Demo</h3>
      </div>

      <div ng-view=""></div>

      <div class="footer">
        <p>&copy; - <a href="http://www.sebalf.de">Sebastian Alfers</a></p>
      </div>
    </div>
    <script>
