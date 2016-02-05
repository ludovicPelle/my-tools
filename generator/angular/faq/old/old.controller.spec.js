/* jshint -W117, -W030 */
describe('OldCtrl', function() {
    var controller;

    beforeEach(function() {
        bard.appModule('app.faq.old');
        bard.inject('$controller', '$log');
    });

    beforeEach(function () {
        controller = $controller('OldCtrl');
        $rootScope.$apply();
    });

    bard.verifyNoOutstandingHttpRequests();

    describe('Old controller', function() {
        it('should be created successfully', function () {
            expect(controller).to.be.defined;
        });
    });
});
