/* jshint -W117, -W030 */
describe('${ModuleName}Ctrl', function() {
    var controller;

    beforeEach(function() {
        bard.appModule('${parent_module}${module_name}');
        bard.inject('$$controller', '$$log');
    });

    beforeEach(function () {
        controller = $$controller('${ModuleName}Ctrl');
        $$rootScope.$$apply();
    });

    bard.verifyNoOutstandingHttpRequests();

    describe('${ModuleName} controller', function() {
        it('should be created successfully', function () {
            expect(controller).to.be.defined;
        });
    });
});
