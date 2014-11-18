'use strict'

# define the module
angular.module('Browser',[])

angular.module('Browser')
  .factory 'BrowserInfo', ($q, $rootScope, $document) ->
    {
      ###
         taken from: http://stackoverflow.com/questions/5916900/detect-version-of-browser
         modiefied by me
      ###
      getInfo: ()->
        # return navigator.userAgent.split("/").join("-")
        ua = navigator.userAgent
        tem = undefined
        M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) or []
        if /trident/i.test(M[1])
          tem = /\brv[ :]+(\d+)/g.exec(ua) or []
          return "IE " + (tem[1] or "")
        if M[1] is "Chrome"
          tem = ua.match(/\bOPR\/(\d+)/)
          return "Opera " + tem[1]  if tem?
        M = (if M[2] then [
          M[1]
          M[2]
        ] else [
          navigator.appName
          navigator.appVersion
          "-?"
        ])
        M.splice 1, 1, tem[1]  if (tem = ua.match(/version\/(\d+)/i))?
        client = M.join " "

        client + "-" + CryptoJS.MD5(navigator.userAgent)

    }
