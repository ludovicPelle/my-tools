(function() {
    'use strict';
    angular
        .module('${parent_module}${module_name}')
        /**
         * @description ${ModuleName} provide something
         * @return {ObjectProvider} - an angular factory.
         */
        .provider('${ModuleName}', ${ModuleName}Provider);

    function ${ModuleName}Provider() {
        this.$get = function() {
            return {
            };
        };
    }
})();
