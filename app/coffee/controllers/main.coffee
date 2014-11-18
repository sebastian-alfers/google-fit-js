"use strict"

###*
@ngdoc function
@name gFitJsApp.controller:MainCtrl
@description
# MainCtrl
Controller of the gFitJsApp
###
angular.module("gFitJsApp")
  .controller "MainCtrl", ($location, $rootScope, $scope, BrowserInfo, GoogleFitAuth, GoogleFitDataSource) -> #Requests
    if !GoogleFitAuth.isLoggedIn()
      $location.path("/login")
      return

    $('#login').hide()
    $('#list').removeClass('active')
    $('#start').addClass('active')
    $scope.addDeviceSuccess = (data) ->
      #alert 'device added'
      #$location.path("/")
      return location.reload()

    $scope.addDeviceError = (data) ->
      console.log data
      alert 'error while adding device ' + JSON.stringify(data)

    $scope.addDevice = () ->
      # hide button
      $('#add-device').hide()
      # show loading
      $('.load-add-device').show()
      browser = $scope.getBrowser()
      GoogleFitDataSource.add browser, $scope.addDeviceSuccess, $scope.addDeviceError

    $scope.getBrowser = () ->
      BrowserInfo.getInfo()

    $rootScope.updateDeviceRegistered = (devices) ->
      # return $scope.deviceIsNotRegistered()
      if devices.dataSource
        browser = BrowserInfo.getInfo()
        for device in devices.dataSource
          if device.device? && device.device.model == browser
            $scope.deviceIsRegistered(device)
            return
      $scope.deviceIsNotRegistered()

    $scope.deviceIsRegistered = (device) ->
      window.gapi.currentDevice = device
      console.log 'is registered'
      $('#deviceRegistered').show()
      $('#deviceNotRegistered').hide()

    $scope.deviceIsNotRegistered = () ->
      console.log 'is not registered'
      $('#deviceRegistered').hide()
      $('#deviceNotRegistered').show()

    isDeviceRegistered = () ->
      # alert "is device registered"
      GoogleFitDataSource.list($rootScope.updateDeviceRegistered)


    $scope.listDataSources = () ->
      ###
      if !(success?)
        success = $rootScope.success

      if !(error?)
        error = $rootScope.error
      s = success
      e = error
      ###
      url = "https://www.googleapis.com/fitness/v1/users/me/dataSources"
      GoogleFitDataSource.test
      #GoogleFitRequests.GET()
      #GoogleFitDataSource.list($rootScope.listSuccess)


    $('#deviceRegistered').hide()
    $('#deviceNotRegistered').hide()
    isDeviceRegistered()
