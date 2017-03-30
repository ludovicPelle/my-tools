(function() {
    'use strict';

    angular
        .module('{parent}{module_name}')
        .config(cfg);

    cfg.$inject = ['RouterProvider'];
    /* @ngInject */
    function cfg(routerHelperProvider) {
        RouterProvider.configureStates(getStates());
    }

    function getStates() {
        return [
            {
                name: '{module_name}',
                url: '/{module_name}',
                templateUrl: '{root}{parent_path}{module_name}/{module_name}.html',
                controller: '{Module_name}Ctrl',
                controllerAs: 'vm',
                title: '{module_name}',
                resolve: {
                }
            }
        ];
    }
})();
