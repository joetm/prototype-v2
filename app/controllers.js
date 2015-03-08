/*global angular, AuthService, Packery, Draggabilly, ngDialog, Dropzone, console, setTimeout, document*/

//initialize controllers
var minimalistControllers = angular.module('minimalistControllers', []);


/**
 * bug fix - make sure that all the edit icon overlays are showing 100% of the time
 */
var bug_fix = function () {
    'use strict';
    angular.forEach(angular.element(document.querySelector('#thing-container')).children(), function (item) {
        //re-set the css 'position' attribute for the edit icon
        //this should make sure that it is showing
        item.style.position = 'absolute';
    });
};//bug_fix


/**
 * BODY element controller (BodyController) - used for hiding/showing elements when user is authenticated
 * @param {object} $scope
 * @param {object} $rootScope
 * @param {object} AuthService
 * @param {object.<string,string>} AUTH_EVENTS - (event 'constants')
 */
minimalistControllers.controller('BodyController', ['$scope', '$rootScope', 'AuthService', 'AUTH_EVENTS', function ($scope, $rootScope, AuthService, AUTH_EVENTS) {
    'use strict';

    //make the search query available to the list page content
    //(because ng-include for the navbar has its own scope)
    $scope.listpage = {'searchQuery' : ''};

    //$scope.user = null;

    $scope.currentUser = AuthService.getCurrentUser();
    $scope.isAuthorized = AuthService.isAuthorized;

    /*
    console.log("bodycontroller rootscope: user.userid: " + $rootScope.userid + " - currentUser.userid: " + $rootScope.currentUser.userid);
    */

    //events
    //listen for authentification broadcast messages
    $scope.$on(AUTH_EVENTS.loginSuccess, function (event, data) {

        console.log('- BodyController receives loginsuccess');

        $rootScope.isAuthenticated = true;
        $rootScope.currentUser = data;

    });
    $scope.$on(AUTH_EVENTS.loginFailed, function (event, data) {

        $rootScope.isAuthenticated = false;
        $rootScope.currentUser = {'userid': null, 'nickname': null, 'sessionid': null, 'securitytoken': null};

    });

}]);//BodyController


/**
 * NAVBAR template controller (NavbarController)
 * @param {object} $scope
 * @param {object} $rootScope
 * @param {object} $location (ng service)
 * @param {object} AuthService
 * @param {object.<string,string>} AUTH_EVENTS - (event 'constants')
 */
minimalistControllers.controller('NavbarController', ['$scope', '$rootScope', '$location', 'AuthService', 'AUTH_EVENTS', function ($scope, $rootScope, $location, AuthService, AUTH_EVENTS) {
    'use strict';

    //console.log('- NavbarController');

    $scope.currentUser = AuthService.getCurrentUser();
    $scope.isAuthorized = AuthService.isAuthorized;

    //EVENTS
    //listen for authentification broadcast messages
    $scope.$on(AUTH_EVENTS.loginSuccess, function (event, data) {
        console.log('- NavbarController receives loginsuccess');
        $scope.isAuthenticated = true;
        $scope.currentUser = data;
    });
    $scope.$on(AUTH_EVENTS.loginFailed, function (event, data) {
        $scope.isAuthenticated = false;
        $scope.currentUser = {'userid': null, 'nickname': null, 'sessionid': null, 'securitytoken': null};
    });

    //hide navbar elements on some pages based on active route
    //User "dylants" on stackoverflow
    //http://stackoverflow.com/a/23838169/426266
    //see also: http://stackoverflow.com/a/18562339/426266
    $scope.isActive = function (viewLocation) {
        return viewLocation === $location.path();
    };

}]);//NavbarController


/**
 * LIST page controller (ListCtrl)
 * @param {object} $scope
 * @param {object} $rootScope
 * @param {object} $http (ng service)
 */
minimalistControllers.controller('ListCtrl', ['$scope', '$rootScope', '$http', function ($scope, $rootScope, $http) {
    'use strict';

    //console.clear();
    console.log('List page');

    //reset the error message
    $rootScope.error = {};

    $http.get('data/list.json').
        success(function (data) {
            $scope.users = data;
        }).
        //error getting the users
        error(function (data, status) { //, headers
            $scope.users = [];

            //show error message if no users are found (this should never happen)
            $scope.error = {};
            $scope.error.status = status;
            $scope.error.msg = data.error;
        });

}]);//ListCtrl


/**
 * LOGIN page controller (LoginCtrl)
 * @param {object} $scope
 * @param {object} $rootScope
 * @param {object} $location (ng service)
 * @param {object} AuthService
 * @param {object.<string,string>} AUTH_EVENTS - (event 'constants')
 */
minimalistControllers.controller('LoginCtrl', ['$scope', function ($scope) {
    'use strict';

    //console.clear();
    console.log('Login page');

    //reset the error message display
    $scope.login_failed = false;

}]);//LoginCtrl


/**
 * LoginFormController - bound to the form on the login page
 * @param {object} $scope
 * @param {object} $rootScope
 * @param {object} $location (ng service)
 * @param {object} AuthService
 * @param {object.<string,string>} AUTH_EVENTS - (event 'constants')
 */
minimalistControllers.controller('LoginFormController', ['$scope', '$rootScope', '$location', 'AuthService', 'AUTH_EVENTS', function ($scope, $rootScope, $location, AuthService, AUTH_EVENTS) {
    'use strict';

    //default credentials for the form
    $scope.credentials = {
        email: '',
        password: ''
    };

    /**
     * method that is being called when login form is submitted
     * @param {object} $credentials
     */
    $scope.loginSubmit = function (credentials) {

        //reset the error message display
        $scope.login_failed = false;

        //call AuthService with the supplied credentials to log the member in
        AuthService.login(credentials).then(
            //success:
            function (user) {

                console.log('- login success');

                $scope.login_failed = false;

                $rootScope.$broadcast(AUTH_EVENTS.loginSuccess, user); //emit event downwards in scope
                //$scope.$emit(AUTH_EVENTS.loginSuccess, user); //emit event upwards in scope

                AuthService.setCurrentUser(user);

                $location.path('/profile/' + parseInt(user.userid, 10));

            },
            //failure:
            function (response) {

                console.log('Error: ' + response.data.error);
                //console.log('login fail');

                $scope.login_failed = true;
                $scope.login_errormsg = response.data.error;

                $rootScope.$broadcast(AUTH_EVENTS.loginFailed); //emit event downwards in scope
                //$scope.$emit(AUTH_EVENTS.loginFailed); //emit event upwards in scope

            }
        );//AuthService.login(credentials).then
    };
}]);//LoginFormController


/**
 * SIGNUP page controller (SignupCtrl)
 * @param {object} $scope
 * @param {object} $rootScope
 * @param {object} $location (ng service)
 * @param {object} SignupService
 * @param {object} $anchorScroll (ng service)
 * @param {object} AuthService
 * @param {object.<string,string>} AUTH_EVENTS - (event 'constants')
 */
minimalistControllers.controller('SignupCtrl', ['$scope', '$rootScope', '$location', 'SignupService', '$anchorScroll', 'AuthService', 'AUTH_EVENTS', function ($scope, $rootScope, $location, SignupService, $anchorScroll, AuthService, AUTH_EVENTS) {
    'use strict';

    //console.clear();
    console.log('Signup page');

    //reset the error message
    //$rootScope.error = {};

    //start with blank form
    $scope.credentials = {
        firstname: '',
        lastname: '',
        nickname: '',
        password: '',
        retypepassword: ''
    };

    //when clicking the signup button on the signup form
    $scope.signup = function (credentials) {

        //alert( JSON.stringify(credentials) );

        if (credentials.password !== credentials.retypepassword) {
            console.log('- password mismatch');
            return false;
        }

        SignupService.signup(credentials).then(
            //success:
            function (user) {

                $rootScope.$broadcast(AUTH_EVENTS.loginSuccess, user.data); //emit event downwards in scope
                //$scope.$emit(AUTH_EVENTS.loginSuccess, user); //emit event upwards in scope

                AuthService.setCurrentUser(user.data);

                console.log('- Signup success: ', user.data);

                $rootScope.currentUser = user.data;

                console.log('- Redirecting to edit-profile page.');
                $location.path('/edit/profile');

            },
            //signup failure:
            function (response) {

                //console.log('- signup fail'); //there is already an output in services.js
                //console.log(response);

                $rootScope.$broadcast(AUTH_EVENTS.loginFailed); //emit event downwards in scope
                //$scope.$emit(AUTH_EVENTS.loginFailed); //emit event upwards in scope

                $rootScope.error = {'status': response.status, 'msg': response.data.error};

                //scroll to the top, so that error message is visible
                $location.hash('navbar'); //go to navbar
                $anchorScroll();

            }
        );//SignupService.signup(credentials).then
    };//$scope.signup
}]);//SignupCtrl


/**
 * HOMEPAGE controller (HomeCtrl)
 * @param {object} $scope
 * @param {object} $location (ng service)
 * @param {object} $anchorScroll (ng service)
 */
minimalistControllers.controller('HomeCtrl', ['$scope', '$location', '$anchorScroll', function ($scope, $location, $anchorScroll) {
    'use strict';

    //console.clear();
    console.log('Home page');

    /**
     * click event for down arrow on homepage
     * this will scroll to the bottom of the page
     * https://docs.angularjs.org/api/ng/service/$anchorScroll
     */
     //no longer used
    $scope.gotoBottom = function () {
        console.log('- scrolling down');
        $location.hash('footer');
        $anchorScroll();
    };

    //function for signup button
    $scope.go = function (path) {
        console.log('- going to ' + path + ' page');
        $location.path(path);
    };

}]);//HomeCtrl


/**
 * EDIT-PROFILE page controller (EditProfileCtrl)
 * @param {object} $scope
 */
minimalistControllers.controller('EditProfileCtrl', ['$scope', function ($scope) {
    'use strict';

    //console.clear();
    console.log('EditProfile page');

}]);//EditProfileCtrl


/**
 * UPLOAD page controller (UploadCtrl)
 * @param {object} $scope
 * @param {object} $rootScope
 */
minimalistControllers.controller('UploadCtrl', ['$scope', '$rootScope', function ($scope, $rootScope) {
    'use strict';

    //console.clear();
    console.log('Upload page');

    //make the userid available in the template
    $scope.currentUser.userid = $rootScope.currentUser.userid;

}]);//UploadCtrl


/**
 * PROFILE page controller (ProfileCtrl)
 * @param {object} $scope
 * @param {object} $rootScope
 * @param {object} $http (ng service)
 * @param {object} $routeParams (ng service)
 * @param {object} AuthService
 * @param {object.<string,string>} AUTH_EVENTS - (event 'constants')
 * @param {object} ngDialog (ngDialog module)
 */
minimalistControllers.controller('ProfileCtrl', ['$scope', '$rootScope', '$http', '$routeParams', 'AuthService', 'AUTH_EVENTS', 'ngDialog', function ($scope, $rootScope, $http, $routeParams, AuthService, AUTH_EVENTS, ngDialog) {
    'use strict';

    //console.clear();
    console.log('Profile page');

    //when edit dialog form is submitted
    $scope.edit_thing = function (formdata) {

        console.log('- saving updated thing...');
        //console.log(formdata);

        $http({
            url: 'actions/edit-thing.php',
            method: 'POST',
            params: {
                'formdata' : angular.toJson(formdata)
            }
        }).
            success(function (data) {
                if (data === 'OK') {
                    console.log('- thing saved');
                } else {
                    console.log('- edit error: ' + data.error);
                }
            }).
            error(function (data, status) {
                console.log('- edit error: ' + status + ' ' + data.error);
            });

        return true;

    };//edit_thing

    //show the edit dialog when edit icon is clicked
    $scope.showEditDialog = function (item) {

        $scope.thing = item;

        console.log('- opening dialog for thing: ' + item.thingid);

        //dialog box for editing
        ngDialog.open({
            'template': 'templates/dialog/edit-thing.html',
//            'data': itemid,
            closeByEscape: true,
            cache: false,
            scope: $scope
        });

    };//showEditDialog


    //routeparams comes from the router and contains the userid
    var userid = parseInt($routeParams.userId, 10); //used in the template
    $rootScope.user = {'userid': userid}; //make the userid available in the packery directive


    //get user credentials of logged in user
    $scope.currentUser = AuthService.getCurrentUser();
    //debug
    console.log("- user.userid: " + userid + " - currentUser.userid: " + $scope.currentUser.userid);


    //get the profile info
    $http({
        url: 'data/profile-' + userid + '.json',
        method: 'GET',
        params: {'userid' : userid}
    }).
        success(function (data) {

            if (data.userid !== undefined) {
                data.userid = parseInt(data.userid, 10); //userid arrives as string
            }

            $scope.user = data;

            //bug fix to show the edit_icons
            bug_fix();

        }).
        //error getting the user
        error(function (data, status) {

            $scope.user = {};
            $scope.user.things = {};

            $scope.error = {};
            $scope.error.status = status;
            $scope.error.msg = data.error;

        });


    //EVENTS
    //listen for authentification broadcast messages
    $scope.$on(AUTH_EVENTS.loginSuccess, function (event, data) {
        console.log('- ProfileCtrl receives loginsuccess');
        $scope.isAuthenticated = true;
        $scope.currentUser = data;
    });
    $scope.$on(AUTH_EVENTS.loginFailed, function (event, data) {
        $scope.isAuthenticated = false;
        $scope.currentUser = {'userid': null, 'nickname': null, 'sessionid': null, 'securitytoken': null};
    });

}]);//ProfileCtrl


/**
 * PACKERY module
 */
angular.module('packery', []).
/**
 * PACKERY directive for angularJS (packerygallery)
 * packery controls the layout of the gallery and makes images draggable (see http://packery.metafizzy.co)
 * @param {object} $rootScope
 * @param {object} $http (ng service)
 */
    directive('packerygallery', ['$rootScope', '$http', function ($rootScope, $http) {
        'use strict';

        return {

            constrain: 'A',

            link: function (scope, element, attrs) {

                var tmp = element; //does not work without this assignment

                //console.log('- running Packery directive');

                //receive the last element event from the angular repeat loop (itemRepeatDirective)
                scope.$on('LastThing', function (event, element, attrs) {

                    //console.log('- event: last element');

                    if ($rootScope.packery === undefined || $rootScope.packery === null) {

                        console.log('- creating packery gallery');

                        //initialise packery
                        var packery = new Packery(tmp[0], {
                            rowHeight: '.module-sizer',
                            itemSelector: '.thing',
                            columnWidth: '.module-sizer'
                        }),
                            things = {},
                            i = 0;

                        //make the gallery draggable
                        //but only if the profile userid is matching the current logged-in user's userid
                        //console.log('- rootScope.currentUser.userid: ' + $rootScope.currentUser.userid);
                        //console.log('- rootScope.user.userid: ' + $rootScope.user.userid);
                        //console.log(typeof($rootScope.currentUser.userid));
                        //console.log(typeof($rootScope.user.userid));
                        if ($rootScope.currentUser !== undefined &&
                                $rootScope.currentUser.userid === $rootScope.user.userid) {

                            angular.forEach(packery.getItemElements(), function (item) {

                                var itemid = item.dataset.id,
                                    draggable = new Draggabilly(item);

                                //drag cursor
                                item.style.cursor = 'move';

                                things[itemid] = i;
                                i = i + 1; //I prefer i++;

                                packery.bindDraggabillyEvents(draggable);
                            });

                            console.log('- thing images are draggable');
                        }

                        packery.layout();


                        //picture drag events
                        packery.on('dragItemPositioned', function (pckryInstance, draggedItem) {

                            console.log('- reorder-event');

                            //reset object
                            things = {};

                            //loop through the updated elements to get the new order
                            angular.forEach(packery.getItemElements(), function (item, key) {
                                var itemid = item.dataset.id;
                                things[itemid] = key;
                            });

                            //output new order of things to console
                            var console_string = '';
                            angular.forEach(things, function (item, key) {
                                console_string += key + ':' + item + ', ';
                            });
                            console.log('- new order: ' + console_string.replace(/,$/, ''));
                            console_string = null;

                            //things now contains an updated internal order
                            //store this order in the database
                            $http({
                                url: 'actions/order.php',
                                method: 'POST',
                                params: {
                                    'userid' : '1',
                                    'things' : angular.toJson(things)
                                }
                            }).success(function (data) {
                                if (data === 'OK') {
                                    console.log('- order saved');
                                } else {
                                    console.log('- re-ordering error');
                                }
                            }).error(function (data, status) {
                                console.log('- re-ordering error: ' + status + ' ' + data.error);
                            });

                        });//picture drag events

                    }//if packery does not exist

                    //bug fix to show the edit_icons
                    bug_fix();

                });//LastThing event

            }//link function
        };//return
    }]).//packerygallery
    /**
     * onLastRepeat directive
     * fires an event when the last element in the packery gallery is processed
     * this event is received by the LastThing listeners of the packerygallery directive
     */
    directive('onLastRepeat', function () {
        'use strict';

        return function (scope, element, attrs) {

            //settimeout is necessary for doing dom manipulation
            //see Joseph Oster on stackoverflow:
            //http://stackoverflow.com/a/16134593/426266
            if (scope.$last) {
                setTimeout(function () {
                    scope.$emit('LastThing', element, attrs);
                }, 1);
            }

        };
    });//onLastRepeat


/**
 * DROPZONE module
 */
angular.module('dropzone', []).
/**
 * DROPZONE directive
 * packery controls the layout of the gallery and makes images draggable (see http://packery.metafizzy.co)
 * @param {object} $rootScope
 * @param {object} $http (ng service)
 */
    directive('dropzone', function () {
        'use strict';

        return function (scope, element, attrs) {

            console.log('- creating dropzone');

            var dropzone,
                eventHandlers = {
                    'sending': function (file, formData, xhr) {
                        console.log('- sending images');
                    },
                    'success': function (file, response) {
                        console.log('- upload succeeded');
                    }
                };

            //create a Dropzone for the element
            dropzone = new Dropzone(element[0], {'url': 'actions/upload.php'});

            //bind the given event handlers
            angular.forEach(eventHandlers, function (handler, event) {
                dropzone.on(event, handler);
            });

        };

    });//dropzone directive
/**
 * DROPZONE page controller (DropzoneCtrl)
 * @param {object} $scope
 */
minimalistControllers.controller('DropzoneCtrl', ['$scope', function ($scope) {
    'use strict';

    console.log('DropzoneCtrl');

}]);//DropzoneCtrl