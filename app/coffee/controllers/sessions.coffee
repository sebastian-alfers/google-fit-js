"use strict"

###*
@ngdoc function
@name gFitJsApp.controller:AboutCtrl
@description
# AboutCtrl
Controller of the gFitJsApp
###
angular.module("gFitJsApp").controller "SessionsCtrl", ($location, $scope, Game, GoogleFitAuth) -> # Requests

  if !GoogleFitAuth.isLoggedIn()
    $location.path("/login")
    return

  $scope.onSuccessSessionDeleted = () ->
    console.log 'session was deleted'
    $scope.listSessions()

  $scope.onErrorSessionDeleted = () ->
    alert 'error while deleting session'

  $scope.removeSession = (session) ->
    s = $scope.onSuccessSessionDeleted
    e = $scope.onErrorSessionDeleted
    url = "https://www.googleapis.com/fitness/v1/users/me/sessions/#{session.id}"
    # Requests.DELETE(url, s, e)
    $.ajax
      url: url
      type: "DELETE"
      success: s
      error: e
      beforeSend: window.setHeader

  getTimestamp =  () ->
    (new Date).getTime()

  $scope.startSession = () ->
    $scope.started = getTimestamp()
    sessionStarted()

  getRandomId = () ->
    getTimestamp() + Math.floor((Math.random()*100000)+1)


  errorAddDataPoints = (error) ->
    console.log 'mist, error while adding data points'
    console.log error

  successAddDataPoints = (dataPointsResponse) ->
    activityTypeWeightLifting = 97
    sessionId = getRandomId()
    url = "https://www.googleapis.com/fitness/v1/users/me/sessions/"+sessionId
    #scope = "https://www.googleapis.com/auth/fitness.activity.write"

    $scope.stopped = getTimestamp()
    sessionStopped()
    data =
      id: sessionId
      name: "test Session"
      description: "meine super test session"
      startTimeMillis: $scope.started
      endTimeMillis: $scope.stopped
      modifiedTimeMillis: $scope.stopped
      application:
        packageName: "htw.maph.weightlifting"
        version: "0.1"
        detailsUrl: "http://health.sebalf.de/#/details"
        name: "Test App for Weightlifting"
      activityType: activityTypeWeightLifting


    $.ajax
      url: url
      data: JSON.stringify(data)
      type: "PUT"
      #datatype: "application/json"
      success: success
      error: error
      beforeSend: window.setHeader

  $scope.stopSession = () ->
    if $scope.dataPoints.length == 0
      alert 'no data points'
      sessionStopped()
      return

    $('.session-container').hide()
    $('.load-sessions').show()

    # add data pints
    dataSourceId = window.gapi.currentDevice.dataStreamId

    firstDataPointStart = $scope.firstDataPointStart
    lastDataPointEnd = $scope.lastDataPointEnd
    dataSetId = "#{firstDataPointStart}-#{lastDataPointEnd}"
    addPointsUrl = encodeURI("https://www.googleapis.com/fitness/v1/users/me/dataSources/#{dataSourceId}/datasets/#{dataSetId}")

    dataSetData =
      minStartTimeNs: firstDataPointStart
      maxEndTimeNs: lastDataPointEnd
      dataSourceId: dataSourceId
      point: $scope.dataPoints


    console.log 'first point: ' + moment(parseInt(firstDataPointStart)).format('MMMM Do YYYY, h:mm:ss a')
    console.log '*********'
    for point in $scope.dataPoints
      console.log point.created.format('MMMM Do YYYY, h:mm:ss a')
    console.log '*********'
    console.log 'last point: ' + moment(parseInt(lastDataPointEnd)).format('MMMM Do YYYY, h:mm:ss a')

    $.ajax
      url: addPointsUrl
      data: JSON.stringify(dataSetData)
      type: "PATCH"
      success: successAddDataPoints
      error: errorAddDataPoints
      beforeSend: window.setHeader

    # clear data points
    $scope.dataPoints = []


  success = (data) ->
    console.log '**added session****'
    console.log data
    $scope.listSessions()

  error = (data) ->
    console.log '*error while adding*****'
    console.log data

  sessionStopped = () ->
    $('#startSessionBtn').show()
    $('#stopSessionBtn').hide()
    return true

  sessionStarted = () ->
    $('#startSessionBtn').hide()
    $('#stopSessionBtn').show()
    Game.start(pointScored)

    return true

  pointScored = (points) ->
    $scope.addDataPoint()

  $scope.sessionList = []
  successListSessions = (data) ->
    $scope.sessionList = []
    if data.session.length
      for session in data.session
        session.startTimeMoment = moment(parseInt(session.startTimeMillis))
        session.endTimeMoment = moment(parseInt(session.endTimeMillis))
        session.duration = moment.duration(session.endTimeMoment.diff(session.startTimeMoment))
        $scope.sessionList.push session
    console.log $scope.sessionList
    $scope.$apply()
    $('.session-container').show()
    $('.load-sessions').hide()

  errorListSessions = (data) ->
    console.log 'error while reading sessions'

  $scope.listSessions = () ->
    $('.session-container').hide()
    $('.load-sessions').show()

    url = "https://www.googleapis.com/fitness/v1/users/me/sessions"

    $.ajax
      url: url
      type: "GET"
      #datatype: "application/json"
      success: successListSessions
      error: errorListSessions
      beforeSend: window.setHeader
    return true
    #$scope.sessions.push 'test'+getRandomId()
    #console.log $scope.sessions
    # $scope.apply()


  $scope.dataPoints = []
  $scope.addDataPoint = () ->
    startTime = getTimestamp() *1000000
    endTime = startTime

    if(!$scope.dataPoints.length)
      $scope.firstDataPointStart = startTime

    $scope.lastDataPointEnd = endTime

    data =
      startTimeNanos: startTime
      endTimeNanos: endTime
      dataTypeName: "com.google.step_count.delta"
      value: [intVal: 1]
      created: moment()
    $scope.dataPoints.push data
    $scope.$apply()

  $scope.showSessionDetails = (session) ->
    console.log 'data set from' + moment(parseInt(session.startTimeMillis)).format('MMMM Do YYYY, h:mm:ss a')
    console.log 'data set to' + moment(parseInt(session.endTimeMillis)).format('MMMM Do YYYY, h:mm:ss a')
    datasetId = session.endTimeMillis*1000000 + "-" + session.startTimeMillis*1000000
    # datasetId = "1416137954720000000-1416137954729000000"

    getDataSet(datasetId)

  $scope.successGetDataSet = (data) ->
    $scope.sessionStarted = moment(data.minStartTimeNs / 1000000)
    $scope.sessionStopped = moment(data.maxEndTimeNs / 1000000)
    $scope.sessionDataPoints = null
    if data.point?
      for point in data.point
        point.startTimeMoment = moment(point.startTimeNanos / 1000000)
      $scope.sessionDataPoints = data.point

      console.log $scope.sessionDataPoints
    $scope.$apply()
    $('.loading').hide()
    $('.session-details-content').show()

  $scope.errorGetDataSet = (error) ->
    alert 'eror while getting dataSet'
    console.log error

  getDataSet = (datasetId) ->
    dataSourceId = window.gapi.currentDevice.dataStreamId
    url = encodeURI("https://www.googleapis.com/fitness/v1/users/me/dataSources/#{dataSourceId}/datasets/#{datasetId}")
    console.log url
    $.ajax
      url: url
      type: "GET"
      #datatype: "application/json"
      success: $scope.successGetDataSet
      error: $scope.errorGetDataSet
      beforeSend: window.setHeader
