(function() {
    'use strict';

    angular
        .module('{parent_module}{module_name}')
        .directive('{module_name}',{module_name}Dir);

    {module_name}Dir.$inject = [];

    /* @ngInject */
    function {module_name}Dir() {
        var linkFn = function(scope, element, attrs) {
            console.log('link', element);
        };
        return {
            restrict: 'A',
            link: linkFn
        };
    };
})();
