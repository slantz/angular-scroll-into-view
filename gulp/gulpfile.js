var gulp = require('gulp');
var coffee = require('gulp-coffee');
var sourcemaps = require('gulp-sourcemaps');
var uglify = require('gulp-uglify');
var ngAnnotate  = require('gulp-ng-annotate');
var rename = require("gulp-rename");

var pkg = require('./package.json');

var banner = ['/*! <%= pkg.name %> - version <%= pkg.version %>',
' * created on - '+getDate(),
' * <%= pkg.description %>',
' * © '+getDate({day: false, month: false}),
' * <%= pkg.author %> */',
''].join('\n');

function getDate(args) {
  var date = new Date(),
  append = {},
  result = [];
  ['day', 'month', 'year'].forEach(function(val, k) {
  append[val] = args && typeof args[val] != 'undefined' ? args[val] : true;
  });
  append.day && result.push(('0' + date.getDate()).slice(-2));
  append.month && result.push(('0' + (date.getMonth()+1)).slice(-2));
  append.year && result.push(date.getFullYear());
  return result.join('-');
}

gulp.task('js-dev-app', function() {
  return gulp.src([
    '../src/assets/coffee/'+pkg.name+'.coffee',
  ])
  .pipe(coffee())
  .pipe(ngAnnotate({
    sourcemap: true
  }))
  .pipe(uglify({
    options: {
    mangle: false,
    preserveComments: false
    }
  }))
  .pipe(rename({
    basename: pkg.name,
    suffix: '.min',
    extname: ".js"
  }))
  .pipe(gulp.dest('../dist/js'))
});

gulp.task('js-dev', ['js-dev-app']);

gulp.task('watch', function() {
  gulp.watch('../src/assets/coffee/*.coffee', ['js-dev']);
});

gulp.task('default', ['js-dev-app']);
gulp.task('js_dev_only', ['js-dev']);