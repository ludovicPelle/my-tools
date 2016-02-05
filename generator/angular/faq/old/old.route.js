(function() {
    'use strict';

    angular
        .module('app.faq.old')
        .run(appRun);

    appRun.$inject = ['routerHelper'];
    /* @ngInject */
    function appRun(routerHelper) {
        routerHelper.configureStates(getStates());
    }

    function getStates() {
        return [
            {
                state: 'old',
                config: {
                    url: '/old',
                    templateUrl: 'app/faq/old/old.html',
                    controller: 'OldCtrl',
                    controllerAs: 'vm',
                    title: 'old'
                }
            }
        ];
    }
})();
