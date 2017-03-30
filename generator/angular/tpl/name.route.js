(function() {
    'use strict';

    angular
        .module('${parent_module}${module_name}')
        .config(cfg);

    cfg.$$inject = ['RouterProvider'];
    /* @ngInject */
    function cfg(RouterProvider) {
        RouterProvider.configureStates(getStates());
    }

    function getStates() {
        return [
            {
                name: '${module_name}',
                url: '/${module_name}',
                templateUrl: '${prefix}${parent_path}${module_name}/${module_name}.html',
                controller: '${ModuleName}Ctrl',
                controllerAs: 'vm',
                title: '${module_name}'
            }
        ];
}
})();
