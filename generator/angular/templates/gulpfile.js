var gulp = require('gulp'),
    del = require('del'),
    gutil = require('gulp-util'),
    streamqueue = require('streamqueue'),
    minifyHtml = require('gulp-minify-html'),
    templateCache = require('gulp-angular-templatecache'),
    concat = require('gulp-concat'),
    rename = require('gulp-rename'),
    uglify = require('gulp-uglify');

gulp.task('build', ['clean'], function() {
    var stream = streamqueue({objectMode: true});
    stream.queue(
        gulp.src('./templates/**/*.html')
            .pipe(minifyHtml({
                empty: true,
                spare: true,
                quotes: true
            }))
            .pipe(templateCache({
                module: 'osculteo.resources',
                root: 'decorators/bootstrap/'
            }))
            .pipe(gulp.dest('./.tmp/'))
    )
    stream.queue(
        gulp.src('./src/**/*.html')
            .pipe(minifyHtml({
                empty: true,
                spare: true,
                quotes: true
            }))
            .pipe(templateCache({
                module: 'osculteo.resources',
                transformUrl: function(url) {
                    return 'osculteo-resources/' + url.split('/')[url.split('/').length -1 ];
                }
            }))
            .pipe(rename('osculteo-resources.tpl.js'))
            .pipe(gulp.dest('./.tmp/'))
    )
    stream.queue(
            gulp.src([
            './src/resources.module.js',
            './src/**/*.js',
            './.tmp/*.js'
            ])
            .pipe(concat('osculteo-resources.js'))
            .pipe(gulp.dest('./build'))
            .pipe(uglify())
            .pipe(rename('osculteo-resources.min.js'))
            .pipe(gulp.dest('./dist'))
    )
    stream.done();
});
/**
 * Remove all files from the build, temp, and reports folders
 * @param  {Function} done - callback when complete
 */
gulp.task('clean', function(done) {
    var delconfig = [].concat('/build', '/dist');
    del(delconfig, done);
});
