</script>
<script src="https://apis.google.com/js/client.js?onload=handleClientLoad"></script>
<script src="http://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/md5.js"></script>

<!-- build:js(.) scripts/oldieshim.js -->
<!--[if lt IE 9]>
<script src="bower_components/es5-shim/es5-shim.js"></script>
<script src="bower_components/json3/lib/json3.js"></script>
<![endif]-->
<!-- endbuild -->

<!-- build:js(.) scripts/vendor.js -->
<!-- bower:js -->
<script src="bower_components/jquery/dist/jquery.js"></script>
<script src="bower_components/angular/angular.js"></script>
<script src="bower_components/bootstrap/dist/js/bootstrap.js"></script>
<script src="bower_components/angular-resource/angular-resource.js"></script>
<script src="bower_components/angular-cookies/angular-cookies.js"></script>
<script src="bower_components/angular-sanitize/angular-sanitize.js"></script>
<script src="bower_components/angular-animate/angular-animate.js"></script>
<script src="bower_components/angular-touch/angular-touch.js"></script>
<script src="bower_components/angular-route/angular-route.js"></script>
<script src="bower_components/moment/moment.js"></script>
<!-- endbower -->
<!-- endbuild -->

    <!-- build:js({.tmp,app}) scripts/scripts.js -->
    <script src="scripts/services/googleFitAuth.js"></script>
    <script src="scripts/services/browser.js"></script>
    <script src="scripts/services/dumbbellsCount.js"></script>
    <script src="scripts/app.js"></script>
    <script src="scripts/services/dataSource.js"></script>
    <script src="scripts/controllers/main.js"></script>
    <script src="scripts/controllers/list.js"></script>
    <script src="scripts/controllers/login.js"></script>
    <script src="scripts/controllers/sessions.js"></script>
    <!-- endbuild -->
</body>
</html>
