/*global angular, $rootScope, things, console, document*/

//initialize Services
var minimalistServices = angular.module('minimalistServices', []);

/*
minimalistServices.factory('Profile', ['$resource',
 function($resource){
  return $resource('data/profile.json', {}, {
   query: {method:'POST', params:{userid:'users'}, isArray:true}
  });
}]);
*/

/**
 * Session service
 * @param {object} $rootScope
 */
minimalistServices.service('Session', ['$rootScope', function ($rootScope) {
    'use strict';

    //create session
    this.create = function (sessionid, userid, nickname, securitytoken) {

        this.sessionid = sessionid;
        this.userid = userid;
        this.nickname = nickname;
        this.securitytoken = securitytoken;

        $rootScope.isAuthenticated = true;

        $rootScope.currentUser = {'nickname': nickname, 'userid': userid, 'sessionid': this.sessionid, 'securitytoken': securitytoken};

    };//create

    //destroy session
    this.destroy = function () {

        this.sessionid = null;
        this.userid = null;
        this.nickname = null;
        this.securitytoken = null;

        $rootScope.isAuthenticated = false;
        $rootScope.currentUser = {'nickname': null, 'userid': null, 'sessionid': null, 'securitytoken': null};

    };//destroy

    //get logged-in user
    this.getUser = function () {

        var user;

        if (this.userid && this.nickname && this.sessionid && this.securitytoken) {
            user = {'userid': this.userid, 'nickname': this.nickname, 'sessionid': this.sessionid, 'securitytoken': this.securitytoken};
        } else {
            user = {'nickname': null, 'userid': null, 'sessionid': null, 'securitytoken': null};
        }

        return user;

    };//getUser

    return this;

}]);//Session service


/**
 * Auth service (AuthService)
 * @param {object} $rootScope
 * @param {object} $http (ng service)
 * @param {object} Session
 */
minimalistServices.service('AuthService', ['$rootScope', '$http', 'Session', function ($rootScope, $http, Session) {
    'use strict';

    var AuthService = {},
        currentUser = {};

    $rootScope.isAuthenticated = false;

    //try to log the member in
    //this method is called from:
    //- minimalistApp.run in app.js
    //- the signup controller in controllers.js
    //- the login controller in controllers.js
    AuthService.login = function (credentials) {

        var authurl = 'actions/login.php';

        //if credentials are null, we are trying to log in with a cookie
        //this gets a special case to prevent the 401 error when the page is refreshed
        if (credentials === null) {
            authurl = authurl + '?cookie=1';
        }

        return $http.
            post(authurl, credentials).
            then(function (res) {

                //console.log(res);

                //the userid arrives as a string
                if (res.data.userid !== undefined) {
                    res.data.userid = parseInt(res.data.userid, 10);
                }

                Session.create(res.data.sessionid, res.data.userid, res.data.nickname, res.data.securitytoken);

                currentUser = Session.getUser();

                return currentUser;
            });
    };//login

    //is the user authenticated?
    AuthService.isAuthenticated = function () {
        return !!Session.userid;
    };

    //set the logged-in user
    AuthService.setCurrentUser = function (user) {
        currentUser = user;
        $rootScope.currentUser = user;
    };

    //get the logged-in user
    AuthService.getCurrentUser = function () {
        currentUser = Session.getUser();
        return currentUser;
    };

    return AuthService;
}]);//AuthService


/**
 * Signup service (SignupService) - bound to the form on the signup page
 * @param {object} $rootScope
 * @param {object} $http (ng service)
 * @param {object} Session
 * @param {object} AuthService
 * @param {object.<string,string>} AUTH_EVENTS - (event 'constants')
 */
minimalistServices.service('SignupService', ['$rootScope', '$http', 'Session', 'AuthService', 'AUTH_EVENTS', function ($rootScope, $http, Session, AuthService, AUTH_EVENTS) {
    'use strict';

    var SignupService = {};

    /**
     * Signup service (SignupService)
     * @param {object} credentials - User details, coming from the form on the signup page
     */
    //signup method, initiated when the signup button in clicked on the signup form
    SignupService.signup = function (credentials) {

        return $http.
            post('actions/signup.php', credentials).
            //signup success
            success(function (res) {

                console.log('User created.');

                //console.log(res);

                Session.create(
                    res.sessionid,
                    res.userid,
                    res.nickname,
                    res.securitytoken
                );

                console.log('Session created.');

                var user = Session.getUser;
                AuthService.setCurrentUser(user);

                console.log('User logged in.');

                //return user data
                return res;

            }).
            //signup error
            error(function (data, status) {

                console.log('signup fail: ' + data.error);

                Session.destroy(); //credentials = false;

                return {'error': data.error, 'status': status};

            });
    };//signup

    SignupService.isAuthenticated = function () {
        return !!Session.userid;
    };

    return SignupService;
}]);//SignupService


/**
 * User service (user)
 */
/*
minimalistServices.service('user', function() {
    'use strict';

    var id = null, userService = {};

    userService.getId = function() {
        return id;
    };

    userService.things = function() {
        return $scope.things;
    };

    return userService;
});
*/