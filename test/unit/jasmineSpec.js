//
// jasmineSpec.js
//

'use strict';

describe('List controller', function() {

    describe('ListCtrl', function(){

        var scope, ctrl, $httpBackend;

        beforeEach(module('minimalistControllers')); //minimalistApp

        //mock http connection
        beforeEach(inject(function(_$httpBackend_, $rootScope, $controller) {
            $httpBackend = _$httpBackend_;
            $httpBackend.expectGET('data/list.json').
                respond([{nickname: 'Hans'}, {nickname: 'Franz'}]);

            scope = $rootScope.$new();
            ctrl = $controller('ListCtrl', {$scope: scope});
        }));

        it('should create "users" model with 2 users fetched via $http', function() {
            expect(scope.users).toBeUndefined();
            $httpBackend.flush();
            expect(scope.users).toEqual([{nickname: 'Hans'}, {nickname: 'Franz'}]);
        });

    });

});