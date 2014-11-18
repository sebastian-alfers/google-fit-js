'use strict'

# define the module
angular.module('gFit.Auth',[])

angular.module('gFit.Auth')
  .factory 'GoogleFitAuth', ($q, $rootScope, $document) ->

    window.setHeader = (xhr) ->
      # console.log gapi
      token = window.gapi.auth.getToken().access_token
      xhr.setRequestHeader('Authorization', 'Bearer ' + token)
      xhr.setRequestHeader('Content-Type', 'application/json; charset=utf-8')
      # xhr.setRequestHeader('x-referer', 'abcdefg')
      return xhr

    isLoggedIn = () ->
      token = window.gapi.auth.getToken()
      token?

    checkAuth = (notAuthenticated, authenticated) ->
      $rootScope.notAuthenticated = notAuthenticated
      $rootScope.authenticated = authenticated
      auth = gapi.auth
      if !auth
        location.reload()
        return

      auth.authorize
        client_id: window.gauth.clientId
        scope: ["https://www.googleapis.com/auth/fitness.activity.write"]
        immediate: true
        , handleAuthResult

    handleAuthResult = (authResult) ->
      console.log 'handle auth'
      if authResult and not authResult.error
        $rootScope.authenticated()
      else
        $rootScope.notAuthenticated()

    handleAuthClick = (notAuthenticated, authenticated) ->
      $rootScope.notAuthenticated = notAuthenticated
      $rootScope.authenticated = authenticated
      gapi.auth.authorize
        client_id: window.gauth.clientId
        scope: ["https://www.googleapis.com/auth/fitness.activity.write"]
        immediate: false
      , handleAuthResult
      false

    #public api
    {
      #getDataSources : getDataSources
      checkAuth: checkAuth
      handleAuthClick: handleAuthClick
      isLoggedIn: isLoggedIn
    }
