(function() {
    'use strict';
    angular
        .module('{parent_module}{module_name}')
        /**
         * @description {Module_name} provide something
         * @return {ObjectProvider} - an angular factory.
         */
        .provider('{Module_name}', {Module_name}Provider);

    function {Module_name}Provider() {
        this.$get = function() {
            return {
            };
        };
    }
})();
