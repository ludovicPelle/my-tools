(function() {
    'use strict';

    angular
        .module('${parent_module}${module_name}')
        .directive('${moduleName}',${moduleName}Dir);

    ${moduleName}Dir.$$inject = [];

    /* @ngInject */
    function ${moduleName}Dir() {
        var linkFn = function(scope, element, attrs) {
            console.log('link', element);
        };
        return {
            restrict: 'A',
            link: linkFn
        };
    };
})();
