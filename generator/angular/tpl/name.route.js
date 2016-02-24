(function() {
    'use strict';

    angular
        .module('${parent_module}${module_name}')
        .run(appRun);

    appRun.$$inject = ['routerHelper'];
    /* @ngInject */
    function appRun(routerHelper) {
        routerHelper.configureStates(getStates());
    }

    function getStates() {
        return [
            {
                state: '${module_name}',
                config: {
                    url: '/${module_name}',
                    templateUrl: '${prefix}${parent_path}${module_name}/${module_name}.html',
                    controller: '${ModuleName}Ctrl',
                    controllerAs: 'vm',
                    title: '${module_name}'
                }
            }
        ];
    }
})();
