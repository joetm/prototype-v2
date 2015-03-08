/*
Adopted from the following tutorial:
Mike Cunsolo 2013. Get Up And Running With Grunt.
URL: http://www.smashingmagazine.com/2013/10/29/get-up-running-grunt/
*/

module.exports = function(grunt){

	'use strict';

	// load grunt-jslint;
	grunt.loadNpmTasks('grunt-jslint');

    //grunt.loadNpmTasks('grunt-stripcomments');

    //grunt-contrib-concat for JS
    grunt.loadNpmTasks('grunt-contrib-concat');

    //grunt-concat-css for CSS
    grunt.loadNpmTasks('grunt-concat-css');

	require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks);


    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
		watch: {
		    html: {
		        files: ['index.html'],
		        tasks: ['htmlhint']
		    },
		    js: {
		        files: ['app/app.js', 'app/controllers.js', 'app/services.js'],
		        tasks: ['jslint', 'uglify', 'concat']
		    },
		    css: {
			        files: ['css/style.scss'],
			        tasks: ['buildcss']
		    }
		},
		/*------*/
		/* HTML */
		/*------*/
        htmlhint: {
		    build: {
		        options: {
		            'tag-pair': true,					// Force tags to have a closing pair
		            'tagname-lowercase': true,			// Force tags to be lowercase
		            'attr-lowercase': true,				// Force attribute names to be lowercase
		            'attr-value-double-quotes': false,	// Force attributes to have double quotes rather than single
		            'doctype-first': true,				// Force the DOCTYPE declaration to come first in the document
		            'spec-char-escape': true,			// Force special characters to be escaped
		            'id-unique': true,					// Prevent using the same ID multiple times in a document
		            'head-script-disabled': true,		// Prevent script tags in the header for performance reasons
		            'style-disabled': false				// Prevent style tags
		        },
		        src: ['index.html']
		    }
		},
		/*----*/
		/* JS */
		/*----*/
        uglify: {
		    build: {
		        files: {
		            'app/_prod.js': ['app/controllers.js', 'app/services.js', 'app/app.js']
		        }
		    }
		},
        concat: {
            options: {
                separator: ';',
            },
            dist: {
                src: [
                    './js/angular/angular.min.js',
                    './js/angular/angular-route.min.js',
                    './js/angular/angular-cookies.min.js',
                    './js/imagesloaded.pkgd.min.js',
                    './js/packery.pkgd.min.js',
                    './js/draggabilly.pkgd.min.js',
                    './js/ngDialog.min.js',
                    './js/dropzone.min.js',
                    './app/_prod.js'
                ],
                dest: 'app/_prod.js'
            }
        },
		//jslint
		jslint: {
			  build: {
				// files to lint
				src: [
					'app/app.js',
					'app/controllers.js',
					'app/services.js'
				],
				// lint options (taken from technical page of Webarchitecture module)
				// https://hci.ecs.soton.ac.uk/wiki/NodejsReferences
				directives: {
					//node: true,
					//devel: true,
					//sloppy: true,
					unparam: true, //prevent "unused variable" jslint errors when running jQuery each loops and callback functions
					//nomen: true,
					//white: false
					//latedef: false
				}
			  },
		},
		/*-----*/
		/* CSS */
		/*-----*/
		sass: {
		    build: {
		        files: {
		            'css/style.css': 'css/style.scss'
		        }
		    }
		},
		cssc: {
			build: {
				options: {
					consolidateViaDeclarations: true,
					consolidateViaSelectors:    true,
					consolidateMediaQueries:    true
				},
				files: {
					'css/style.css': 'css/style.css'
				}
			}
		},
		concat_css: {
			build: {
				src: [
					'css/bootstrap.min.css',
					'css/ngDialog.css',
					'css/ngDialog-theme-default.css',
					'css/ngDialog-theme-plain.css',
					'css/dropzone.css',
					'css/style.css'
				],
				dest: 'css/_prod.css'
			}
		},
		cssmin: {
			build: {
				src: 'css/_prod.css',
				dest: 'css/_prod.css'
			}
		}
    });

    grunt.registerTask('default', []);

    grunt.registerTask('buildcss',  ['sass', 'cssc', 'concat_css', 'cssmin']);

};