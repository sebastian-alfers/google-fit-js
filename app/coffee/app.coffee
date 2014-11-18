"use strict"

###*
@ngdoc overview
@name gFitJsApp
@description
# gFitJsApp

Main module of the application.
###
app = angular.module("gFitJsApp", [
  "Browser" #custom service
  "gFitDataSource" # custom service
  "gFit.Auth" # custom service
  "DumbbellsCount" # custom service
  "ngAnimate"
  "ngCookies"
  "ngResource"
  "ngRoute"
  "ngSanitize"
  "ngTouch"
])

app.config ($routeProvider) ->
  $routeProvider.when("/",
    templateUrl: "views/main.html"
    #controller: "MainCtrl"
  ).when("/login",
    templateUrl: "views/login.html"
    #controller: "AboutCtrl"
  ) #.otherwise redirectTo: "/"

app.run ($rootScope, $location) ->
  if(!$rootScope.isAuthenticated?)
    $rootScope.isAuthenticated = false

  if(!$rootScope.isAuthenticated)
    $location.path("/login")
