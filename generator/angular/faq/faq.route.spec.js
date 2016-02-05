/* jshint -W117, -W030 */
describe('faq routes', function () {
    describe('state', function () {
        var view = 'app/faq/faq.html';

        beforeEach(function() {
            module('app.faq', bard.fakeToastr);
            bard.inject('$httpBackend', '$location', '$rootScope', '$state', '$templateCache');
        });

        beforeEach(function() {
            $templateCache.put(view, '');
        });

        bard.verifyNoOutstandingHttpRequests();

        it('should map state faq to url / ', function() {
            expect($state.href('faq', {})).to.equal('/');
        });

        it('should map /faq route to faq View template', function () {
            expect($state.get('faq').templateUrl).to.equal(view);
        });

        it('of faq should work with $state.go', function () {
           $state.go('faq');
           $rootScope.$apply();
            expect($state.is('faq'));
        });
    });
});
