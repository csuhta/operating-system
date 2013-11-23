module.exports = function(grunt) {

  grunt.initConfig({
    uglify: {
      files: {
        src: "javascripts/**/*.js",   // source files mask
        dest: "public/assets/js",     // destination folder
        expand: true,                 // allow dynamic building
        flatten: false                // do not remove the directory structure
      }
    },
    watch: {
      files: ["javascripts/**/*.js"],
      tasks: ["uglify"]
    }
  });

  grunt.loadNpmTasks("grunt-contrib-uglify");
  grunt.loadNpmTasks("grunt-contrib-watch");
  grunt.registerTask("default", ["uglify"]);

};
