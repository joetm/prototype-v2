/*global browser, describe, element, by, toEqual, it, expect*/

//protractorSpec.js

//http://angular.github.io/protractor/#/tutorial

//test homepage title
describe('Test homepage', function() {
  it('should have a title', function() {

    browser.get('http://localhost/Webdev-project/www/');

    expect(browser.getTitle()).toEqual('Minimalist Social Network');

  });
});

describe('Signup page', function() {

    var email_field = by.model('credentials.email'),
        firstname_field = by.model('credentials.firstname'),
        lastname_field = by.model('credentials.lastname'),
        nickname_field = by.model('credentials.nickname'),
        password_field = by.model('credentials.password'),
        retypepassword_field = by.model('credentials.retypepassword'),
		submitbutton = by.id('submitbutton');


    it('should deactivate the signup button when email is not valid', function() {

        browser.get('http://localhost/Webdev-project/www/#/signup');

		//test a non-valid email
        element(email_field).sendKeys('invalid-email');
        expect(
			element(submitbutton).isEnabled()
		).toBe(false);

    });

    it('should show password error message when retyped password does not match password', function() {

        browser.get('http://localhost/Webdev-project/www/#/signup');

		//check password mismatch
        element(password_field).sendKeys('testpassword');
        element(retypepassword_field).sendKeys('notmatchingpassword');

        expect(
			element(by.id('passwordmismatch')).isDisplayed()
		).toBeTruthy();

    });

    it('should not show error message when retyped password matches password', function() {

        browser.get('http://localhost/Webdev-project/www/#/signup');

		//check password mismatch
        element(password_field).sendKeys('testpassword');
        element(retypepassword_field).sendKeys('testpassword');

        expect(
			element(by.id('passwordmismatch')).isDisplayed()
		).toEqual(false);

    });

    it('should redirect to the "edit profile" page after signup', function() {

        browser.get('http://localhost/Webdev-project/www/#/signup');

        element(email_field).sendKeys('test@email.com');
        element(firstname_field).sendKeys('Test');
        element(lastname_field).sendKeys('Tester');
        element(nickname_field).sendKeys('Testy');
        element(password_field).sendKeys('testpassword');
        element(retypepassword_field).sendKeys('testpassword');

        element(by.id('submitbutton')).click();

        browser.sleep(1000);

        //if signup is successful, we are redirected to profile edit page
        expect(
			browser.getLocationAbsUrl()
		).toMatch("/edit/profile");

    });

});
