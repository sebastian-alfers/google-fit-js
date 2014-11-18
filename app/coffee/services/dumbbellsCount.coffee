'use strict'

# define the module
angular.module('DumbbellsCount',[])

angular.module('DumbbellsCount')
  .factory 'Game', ($rootScope, $document) ->

    alpha = $("#alpha")
    minLog = $("#min")
    maxLog = $("#max")
    currLog = $("#curr")
    result = $("#result")
    upperThreshold = 95
    lowerThreshold = 10
    px = ""
    curr = 0
    min = 0
    max = 0
    count = 0
    wasDown = true
    wasUp = true

    increaseMax = true

    stop = () ->
      window.ondevicemotion = () ->


    start = (pointScored) ->
      count = 0
      result.html count
      if window.DeviceMotionEvent is `undefined`
        alert 'sorry, device is not able to play'
      else
        $rootScope.onPointScored = pointScored
        window.ondevicemotion = onDeviceMotion


    onDeviceMotion = (e) ->
      ax = event.accelerationIncludingGravity.x * 5
      ay = event.accelerationIncludingGravity.y * 5

      #document.getElementById("accelerationX").innerHTML = e.accelerationIncludingGravity.x;
      #document.getElementById("accelerationY").innerHTML = e.accelerationIncludingGravity.y;
      #document.getElementById("accelerationZ").innerHTML = e.accelerationIncludingGravity.z;
      curr = Math.abs(e.accelerationIncludingGravity.y) * 10
      # currLog.html curr
      min = curr  if min is 0
      min = curr  if max is 0

      #
      if(increaseMax)
        if curr > max
          max = curr
          # maxLog.html "max: " + curr

      #if curr < min
      #  min = curr
      #  minLog.html "min: " + min
      if wasDown and curr > upperThreshold
        alpha.addClass('reset')
        increaseMax = false
        count++
        $rootScope.onPointScored(count)
        result.html count
        max = 0

        wasDown = false
        wasUp = true


      if wasUp and curr < lowerThreshold
        wasDown = true
        wasUp = false
        increaseMax = true

      px = max + "%"

      #console.log(px);
      alpha.css "width", px

      return

    # public api
    {
      start: start
      stop: stop
    }
