"use strict"

###*
@ngdoc function
@name gFitJsApp.controller:AboutCtrl
@description
# AboutCtrl
Controller of the gFitJsApp
###
angular.module("gFitJsApp").controller "LoginCtrl", ($rootScope, $scope, $location, GoogleFitAuth) ->

  $scope.isLoading = true
  $('#login').addClass('active')
  loading = (loading) ->
    $scope.isLoading = loading
    if(loading)
      $('.loading').show()
      $('.content').hide()
    else
      $('.loading').hide()
      $('.content').show()

  $scope.changeView =  (location) ->
    $location.path(location)
    $scope.$apply()

  notAuthenticated = ->
    loading(false)
    console.log 'show login btn'

  authenticated = ->
    $rootScope.isAuthenticated = true
    $scope.changeView("/")

  $scope.login = ->
    GoogleFitAuth.handleAuthClick notAuthenticated, authenticated

  #console.log BrowserInfo
  GoogleFitAuth.checkAuth notAuthenticated, authenticated
