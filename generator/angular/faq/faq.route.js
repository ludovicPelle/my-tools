(function() {
    'use strict';

    angular
        .module('app.faq')
        .run(appRun);

    appRun.$inject = ['routerHelper'];
    /* @ngInject */
    function appRun(routerHelper) {
        routerHelper.configureStates(getStates());
    }

    function getStates() {
        return [
            {
                state: 'faq',
                config: {
                    url: '/faq',
                    templateUrl: 'app/faq/faq.html',
                    controller: 'FaqCtrl',
                    controllerAs: 'vm',
                    title: 'faq'
                }
            }
        ];
    }
})();
