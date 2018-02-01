/* jshint -W117, -W030 */
describe('${ModuleName} Routes', function() {
    describe('state', function () {
        var view = '${prefix}${parent_path}${module_name}/${module_name}.html';

        beforeEach(function() {
            module('${parent_module}${module_name}', bard.fakeToastr);
            bard.inject('$$httpBackend', '$$location', '$$rootScope', '$$state', '$$templateCache');
            injectLayoutTemplates()
        });

        beforeEach(function() {
            $$templateCache.put(view, '');
        });

        bard.verifyNoOutstandingHttpRequests();

        it('should map state ${module_name} to url /${module_name} ', function() {
            expect($$state.href('${module_name}', {})).to.equal('/${module_name}');
        });

        it('should map /${module_name} route to ${module_name} View template', function () {
            expect($$state.get('${module_name}').views['content'].templateUrl).to.equal(view);
        });

        it('of ${module_name} should work with $$state.go', function () {
           $$state.go('${module_name}');
           $$rootScope.$$apply();
            expect($$state.is('${module_name}'));
        });
    });
});
