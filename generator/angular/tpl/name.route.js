(function() {
    'use strict';

    angular
        .module('${parent_module}${module_name}')
        .config(cfg);

    cfg.$$inject = ['RouterProvider'];
    /* @ngInject */
    function cfg(RouterProvider) {
        RouterProvider.configureStates(getStates());
        if(!RouterProvider.config.otherwise) {
            RouterProvider.configure({otherwise:'${module_name}'})
        }
    }

    function getStates() {
        return [
            {
                name: '${module_name}',
                title: '${module_name}',
                url: '/${module_name}',
                parent:'layout',
                views: {
                    'content': {
                        templateUrl: '${prefix}${parent_path}${module_name}/${module_name}.html',
                        controller: '${ModuleName}Ctrl',
                        controllerAs: 'vm',
                    }
                }
            }
        ];
}
})();
