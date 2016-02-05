(function () {
    'use strict';

    angular
        .module('${parent_module}${module_name}')
        .controller('${Module_name}Ctrl', ${Module_name}Ctrl);

    ${Module_name}Ctrl.$$inject = [];

    /* @ngInject */
    function ${Module_name}Ctrl() {
        var vm = this;
    }
})();
