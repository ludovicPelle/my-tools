(function() {
    'use strict';

    angular
        .module('{parent}{module_name}')
        .run(appRun);

    appRun.$inject = ['routerHelper'];
    /* @ngInject */
    function appRun(routerHelper) {
        routerHelper.configureStates(getStates());
    }

    function getStates() {
        return [
            {
                state: '{module_name}',
                config: {
                    url: '/{module_name}',
                    templateUrl: '{root}{parent_path}{module_name}/{module_name}.html',
                    controller: '{Module_name}Ctrl',
                    controllerAs: 'vm',
                    title: '{module_name}'
                }
            }
        ];
    }
})();
