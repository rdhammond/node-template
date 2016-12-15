grunt = require 'grunt'

grunt.initConfig
    clean:
        prod: 'public'

    sass:
        compile:
            files: [{
                expand: yes
                cwd: 'client/'
                src: ['**/*.scss']
                dest: 'public/css/'
                flatten: yes
                ext: '.css'
            }]

    copy:
        to_prod:
            files: [
                {
                    expand: yes
                    cwd: 'bower_components/'
                    src: [
                        'jquery/dist/jquery.js'
                        'what-input/dist/what-input.js'
                        'foundation-sites/dist/js/foundation.js'
                    ]
                    dest: 'public/js/'
                    flatten: yes
                },
                {
                    expand: yes
                    cwd: 'bower_components/'
                    src: [
                        'foundation-sites/dist/css/foundation.css'
                    ]
                    dest: 'public/css/'
                    flatten: yes
                },
                {
                    expand: yes
                    cwd: 'client/'
                    src: ['**/*.js', '!**/*.min.js']
                    dest: 'public/js/'
                    flatten: yes
                }
            ]

    uglify:
        prod:
            files: [{
                expand: true
                cwd: 'public/js/'
                src: ['**/*.js', '!**/*.min.js']
                dest: 'public/js/'
                ext: '.min.js'
                flatten: yes
            }]

    cssmin:
        prod:
            files: [{
                expand: yes
                cwd: 'public/css/'
                src: ['**/*.css', '!**/*.min.css']
                dest: 'public/css/'
                ext: '.min.css'
                flatten: yes
            }]

    imagemin:
        prod:
            files: [{
                expand: yes
                cwd: 'client/img/'
                src: ['**/*.{jpg,gif,png}']
                dest: 'public/img/'
                flatten: yes
            }]

grunt.loadNpmTasks 'grunt-contrib-clean'
grunt.loadNpmTasks 'grunt-sass'
grunt.loadNpmTasks 'grunt-contrib-copy'
grunt.loadNpmTasks 'grunt-contrib-uglify'
grunt.loadNpmTasks 'grunt-contrib-cssmin'
grunt.loadNpmTasks 'grunt-contrib-imagemin'

grunt.registerTask 'default', () ->
    grunt.task.run 'clean'
    grunt.task.run 'sass:compile'
    grunt.task.run 'copy:to_prod'
    grunt.task.run 'uglify:prod', 'cssmin:prod', 'imagemin:prod'
