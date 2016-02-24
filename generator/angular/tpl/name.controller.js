(function () {
    'use strict';

    angular
        .module('${parent_module}${module_name}')
        .controller('${ModuleName}Ctrl', ${ModuleName}Ctrl);

    ${ModuleName}Ctrl.$$inject = [];

    /* @ngInject */
    function ${ModuleName}Ctrl() {
        var vm = this;
    }
})();
