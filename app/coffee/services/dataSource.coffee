'use strict'

angular.module('gFitDataSource',[])


angular.module('gFitDataSource')
  .factory 'GoogleFitDataSource', ($q, $rootScope, $document) ->
    @url = "https://www.googleapis.com/fitness/v1/users/me/dataSources"

    addDataSource = (browser, success, error) ->
      manufacturer = "Public Healh App Demo"
      data =
        dataStreamId: "derived:com.google.step_count.delta:#{window.gauth.clientCode}:"+manufacturer+":"+browser+":1000001:"
        dataStreamName: ""
        name: "myDataSource"
        type: "derived"
        application:
          detailsUrl: "http://exampfffle.com"
          name: "Foo Exampasdfle App"
          version: "1"

        dataType:
          field: [
            name: "steps"
            format: "integer"
          ]
          name: "com.google.step_count.delta"

        device:
          manufacturer: manufacturer
          model: browser
          type: "tablet"
          uid: "1000001"
          version: "1"

      $.ajax
        url: "https://www.googleapis.com/fitness/v1/users/me/dataSources"
        data: JSON.stringify(data)
        type: "POST"
        #datatype: "application/json"
        success: success
        error: error
        beforeSend: window.setHeader



    list = (success, error) ->
      if !(success?)
        success = $rootScope.success

      if !(error?)
        error = $rootScope.error
      s = success
      e = error
      url = "https://www.googleapis.com/fitness/v1/users/me/dataSources"
      $.ajax
        url: "https://www.googleapis.com/fitness/v1/users/me/dataSources"
        type: "GET"
        #datatype: "application/json"
        success: success
        error: error
        beforeSend: window.setHeader

    #public api
    {
      list: list
      add: addDataSource
    }
