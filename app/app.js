/*global angular, console*/

/**
 * App definition and module injection
 * @param {string} Name of the app (minimalistApp)
 * @param {object} Modules to be included:
       - ngRoute:               AngularJS route provider
       - minimalistControllers: Custom controllers, defined in controllers.js
       - minimalistServices:    Custom services, defined in services.js
       - dropzone:              Custom dropzone module, defined in controllers.js
       - packery:               Custom packery module, defined in controllers.js
       - ngDialog:              Custom ngDialog module, defined in controllers.js
       - ngCookies:             AngularJS cookie provider
 */
var minimalistApp = angular.module('minimalistApp', [
        'ngRoute',
        'minimalistControllers',
        'minimalistServices',
        'dropzone',
        'packery',
        'ngDialog',
        'ngCookies'
    ]);

//Gert Hengeveld, March 2014.
//Techniques for authentication in AngularJS applications
//https://medium.com/opinionated-angularjs/techniques-for-authentication-in-angularjs-applications-7bbf0346acec
/**
 * AUTH_EVENTS Object - defines the set of event names used throughout the app.
 * @param {string} Name of the constant
 * @param {object.<string,string>} event names
       - loginSuccess: login success event
       - loginFailed:  login failure event
       - logoutSuccess: (unused)
       - sessionTimeout: (unused)
       - notAuthenticated: (unused)
       - notAuthorized: (unused)
 */
minimalistApp.constant('AUTH_EVENTS', {
    loginSuccess: 'auth-login-success',
    loginFailed: 'auth-login-failed',
    logoutSuccess: 'auth-logout-success',
    sessionTimeout: 'auth-session-timeout',
    notAuthenticated: 'auth-not-authenticated',
    notAuthorized: 'auth-not-authorized'
});
/*
//(unused)
minimalistApp.constant('USER_ROLES', {
    all: '*',
    admin: 'admin',
    user: 'user',
    guest: 'guest'
});
*/


//John Kevin M. Basco, May 2014
//Protecting routes in AngularJS
//http://blog.john.mayonvolcanosoftware.com/protecting-routes-in-angularjs/
/**
 * loginRequired function - protects routes from unauthenticated access
 * @param {object} $location (ng provider)
 * @param {object} $q (ng)
 * @param {object} AuthService
 * @param {object} SignupService
 */
var loginRequired = ['$location', '$q', 'AuthService', 'SignupService', function ($location, $q, AuthService, SignupService) {
    'use strict';

    var deferred = $q.defer();
    if (!AuthService.isAuthenticated()) {
        deferred.reject();
        $location.path('/login');
    } else {
        deferred.resolve();
    }
    return deferred.promise;

}];//loginRequired


/*
minimalistApp.factory('HttpResponseInterceptor', ['$q', '$location', function ($q, $location) {
    'use strict';
    return {
        response: function (response) {
            if (response.status === 401) {
                console.log("HttpResponseInterceptor: Response 401");
            }
            return response || $q.when(response);
        },
        responseError: function (rejection) {
            if (rejection.status === 401) {
                console.log("HttpResponseInterceptor: Response Error 401", rejection);
                //$location.path('/login').search('returnTo', $location.path());
            }
            return $q.reject(rejection);
        }
    };
}]);
*/


/**
 * Router - defines the routes of the application
 * @param {object} $routeProvider (ng provider)
 * @param {object} $httpProvider (ng provider)
 */
minimalistApp.config(['$routeProvider', '$httpProvider', function ($routeProvider, $httpProvider) {
    'use strict';

    //http request header configuration
    $httpProvider.defaults.headers.post.Accept =
        $httpProvider.defaults.headers.common.Accept = "application/json, text/plain, */*";
    $httpProvider.defaults.headers.post['Content-Type'] =
        $httpProvider.defaults.headers.common['Content-Type'] = 'application/json;charset=utf-8';


    //$httpProvider.interceptors.push('HttpResponseInterceptor');


    //in production, the web application could be run with HTML5 mode enabled to allow for search engine friendlier urls.
    //this requires the <base> html meta tag
    //https://docs.angularjs.org/guide/$location#-location-service-configuration
    /*
    $locationProvider.html5Mode({
        enabled: true,
        requireBase: false
    });
    */

    //routes
    $routeProvider.
        when('/', {
            title: 'Minimalist Social Network',
            templateUrl: 'templates/home.html',
            controller: 'HomeCtrl'
        }).
        when('/list', {
            title: 'List',
            templateUrl: 'templates/list.html',
            controller: 'ListCtrl'
        }).
        when('/profile/:userId', {
            title: 'Profile',
            templateUrl: 'templates/profile.html',
            controller: 'ProfileCtrl'
        }).
        when('/login', {
            title: 'Login',
            templateUrl: 'templates/login.html',
            controller: 'LoginCtrl'
        }).
        when('/signup', {
            title: 'Signup',
            templateUrl: 'templates/signup.html',
            controller: 'SignupCtrl'
        }).
        when('/edit/profile', {
            title: 'Edit Profile',
            templateUrl: 'templates/edit-profile.html',
            controller: 'EditProfileCtrl'
            /*
            resolve: {
                auth: loginRequired
            }
            */
        }).
        when('/upload', {
            title: 'Upload',
            templateUrl: 'templates/upload.html',
            controller: 'UploadCtrl',
            resolve: {
                auth: loginRequired
            }
        }).
        //unknown route -> redirect to homepage
        otherwise({
            redirectTo: '/'
        });
}]);//minimalistApp.config


/**
 * auth_fail function - clears the user details and alerts about a failed log-in
 * @param {object} response
 * @param {object} $rootScope
 * @param {object} Session - Session service
 */
function auth_fail(response, $rootScope, Session) {
    'use strict';

    Session.destroy();

	$rootScope.isAuthenticated = false;
	$rootScope.currentUser = response;

    console.log('- login failed');
    //console.log('- user credentials: ', $rootScope.currentUser);

}//auth_fail

/**
 * Running the application (minimalistApp.run)
 * @param {object} $location (ng provider)
 * @param {object} $http (ng provider)
 * @param {object} $rootScope
 * @param {object} AuthService
 * @param {object.<string,string>} AUTH_EVENTS - (event 'constants')
 * @param {object} $cookies (ng provider)
 * @param {object} Session
 */
minimalistApp.run(['$location', '$http', '$rootScope', 'AuthService', 'AUTH_EVENTS', '$cookies', 'Session', function ($location, $http, $rootScope, AuthService, AUTH_EVENTS, $cookies, Session) { //$cookies
    'use strict';

    //try to log the user in, based on the cookie
    //use null as user credentials for Auth->login() => cookie authentication instead of email/password
    //unlike the request from the login page, this request will always reply with '200' status
    AuthService.login(null).then(
        //success
        function (response) {

            if (response.error !== undefined || response.userid === undefined || !response.userid) {

                //login failed
                auth_fail(response, $rootScope, Session);

            } else {

                //login returned user details

                $rootScope.isAuthenticated = true;
                $rootScope.currentUser = response;

                console.log('- cookie login success, user: ', $rootScope.currentUser);
                //console.log($rootScope.currentUser);

                $rootScope.$broadcast(AUTH_EVENTS.loginSuccess, response); //emit event downwards in scope
            }
        },
        //failure:
        function (response) {

            auth_fail(response, $rootScope, Session);

            //$rootScope.$broadcast(AUTH_EVENTS.loginFailed); //emit event downwards in scope

        }
    );//then


    //change title of app
    //jkoreska, Nov 2012
    //http://stackoverflow.com/questions/12506329/how-to-dynamically-change-header-based-on-angularjs-partial-view
    $rootScope.$on('$routeChangeSuccess', function (event, current, previous) {
        if (current.$$route.title) {
            $rootScope.title = current.$$route.title;
        }
    });

    //set up application-wide CSRF token headers
    $http.defaults.headers.post['X-XSRF-TOKEN'] = $cookies.csrftoken;

    //When upload page is requested, redirect to login if user is not logged in (routeChangeStart event)
    $rootScope.$on('$routeChangeStart', function (event, next, current) {

        // redirect to login page if not logged in
        if ($location.path() === '/upload' && !$rootScope.currentUser) {
            $location.path('/login');
        }

    });

}]);//minimalistApp.run
