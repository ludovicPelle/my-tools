/* jshint -W117, -W030 */
describe('FaqCtrl', function() {
    var controller;

    beforeEach(function() {
        bard.appModule('app.faq');
        bard.inject('$controller', '$log');
    });

    beforeEach(function () {
        controller = $controller('FaqCtrl');
        $rootScope.$apply();
    });

    bard.verifyNoOutstandingHttpRequests();

    describe('Faq controller', function() {
        it('should be created successfully', function () {
            expect(controller).to.be.defined;
        });
    });
});
