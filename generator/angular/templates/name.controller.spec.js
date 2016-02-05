/* jshint -W117, -W030 */
describe('{Module_name}Ctrl', function() {
    var controller;

    beforeEach(function() {
        bard.appModule('{parent_module}{module_name}');
        bard.inject('$controller', '$log');
    });

    beforeEach(function () {
        controller = $controller('{Module_name}Ctrl');
        $rootScope.$apply();
    });

    bard.verifyNoOutstandingHttpRequests();

    describe('{Module_name} controller', function() {
        it('should be created successfully', function () {
            expect(controller).to.be.defined;
        });
    });
});
