/* jshint -W117, -W030 */
describe('KidsCtrl', function() {
    var controller;

    beforeEach(function() {
        bard.appModule('app.faq.kids');
        bard.inject('$controller', '$log');
    });

    beforeEach(function () {
        controller = $controller('KidsCtrl');
        $rootScope.$apply();
    });

    bard.verifyNoOutstandingHttpRequests();

    describe('Kids controller', function() {
        it('should be created successfully', function () {
            expect(controller).to.be.defined;
        });
    });
});
