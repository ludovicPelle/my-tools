/* jshint -W117, -W030 */
describe('kids routes', function () {
    describe('state', function () {
        var view = 'app/faq/kids/kids.html';

        beforeEach(function() {
            module('app.faq.kids', bard.fakeToastr);
            bard.inject('$httpBackend', '$location', '$rootScope', '$state', '$templateCache');
        });

        beforeEach(function() {
            $templateCache.put(view, '');
        });

        bard.verifyNoOutstandingHttpRequests();

        it('should map state kids to url / ', function() {
            expect($state.href('kids', {})).to.equal('/');
        });

        it('should map /kids route to kids View template', function () {
            expect($state.get('kids').templateUrl).to.equal(view);
        });

        it('of kids should work with $state.go', function () {
           $state.go('kids');
           $rootScope.$apply();
            expect($state.is('kids'));
        });
    });
});
