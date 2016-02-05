/* jshint -W117, -W030 */
describe('old routes', function () {
    describe('state', function () {
        var view = 'app/faq/old/old.html';

        beforeEach(function() {
            module('app.faq.old', bard.fakeToastr);
            bard.inject('$httpBackend', '$location', '$rootScope', '$state', '$templateCache');
        });

        beforeEach(function() {
            $templateCache.put(view, '');
        });

        bard.verifyNoOutstandingHttpRequests();

        it('should map state old to url / ', function() {
            expect($state.href('old', {})).to.equal('/');
        });

        it('should map /old route to old View template', function () {
            expect($state.get('old').templateUrl).to.equal(view);
        });

        it('of old should work with $state.go', function () {
           $state.go('old');
           $rootScope.$apply();
            expect($state.is('old'));
        });
    });
});
