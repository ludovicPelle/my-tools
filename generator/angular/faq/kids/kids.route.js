(function() {
    'use strict';

    angular
        .module('app.faq.kids')
        .run(appRun);

    appRun.$inject = ['routerHelper'];
    /* @ngInject */
    function appRun(routerHelper) {
        routerHelper.configureStates(getStates());
    }

    function getStates() {
        return [
            {
                state: 'kids',
                config: {
                    url: '/kids',
                    templateUrl: 'app/faq/kids/kids.html',
                    controller: 'KidsCtrl',
                    controllerAs: 'vm',
                    title: 'kids'
                }
            }
        ];
    }
})();
