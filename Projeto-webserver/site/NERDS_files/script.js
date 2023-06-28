(function () {
    var setting = {"height": 500, "width": 500, "zoom": 17, "queryString": "Universidade Federal do Ceará - Campus de Russas - Rua Felipe Santiago - Cidade Universitária, Russas - CE, Brasil", "place_id": "ChIJzUSO7Z6CuQcRKQft5hSf1z0", "satellite": false, "centerCoord": [-4.946708201374462, -37.97437594999998], "cid": "0x3dd79f14e6ed0729", "lang": "pt", "cityUrl": "/brazil/russas-369324", "cityAnchorText": "", "id": "map-9cd199b9cc5410cd3b1ad21cab2e54d3", "embed_id": "941156"};
    var d = document;
    var s = d.createElement('script');
    s.src = 'https://1map.com/js/script-for-user.js?embed_id=941156';
    s.async = true;
    s.onload = function (e) {
        window.OneMap.initMap(setting)
    };
    var to = d.getElementsByTagName('script')[0];
    to.parentNode.insertBefore(s, to);
})();