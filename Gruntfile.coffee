path = require 'path'

module.exports = (grunt) ->
  # Load grunt tasks automatically
  require('load-grunt-tasks') grunt

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    # Empties folders to start fresh
    clean:
      all:
        files: [dot: true, src: ['build']]

    # Compiles CoffeeScript to JavaScript
    coffee:
      options:
        sourceMap: true
      src:
        files: [
          expand: true
          cwd: 'src'
          src: '**/*.coffee'
          dest: 'build'
          ext: '.js']

    # Watches files for changes in interactive mode
    watch:
      coffee:
        files: ['src/**/*.coffee']
        tasks: ['coffeelint', 'coffee']
      livereload:
        options:
          livereload: 35729
        files: ['build/**/*.js']

    coffeelint:
      options:
        no_trailing_whitespace: level: 'error'
        arrow_spacing: level: 'error'
        cyclomatic_complexity: level: 'warn'
        empty_constructor_needs_parens: level: 'error'
        line_endings: level: 'error'
        no_empty_functions: level: 'error'
        no_empty_param_list: level: 'error'
        no_interpolation_in_single_quotes: level: 'error'
        no_stand_alone_at: level: 'error'
        no_unnecessary_double_quotes: level: 'error'
        no_unnecessary_fat_arrows: level: 'error'
        space_operators: level: 'error'
      gruntfile:
        files:
          src: ['Gruntfile.coffee']
      src:
        files:
          src: ['src/**/*.coffee']

    connect:
      server:
        options:
          livereload: 35729
          port: 9001
          base: '.'

  # Run the server and watch for file changes
  grunt.registerTask 'serve', (target) ->
    grunt.task.run [
      'coffeelint'
      'coffee'
      'connect'
      'watch']

  # Default task
  grunt.registerTask 'default', ['coffee']
