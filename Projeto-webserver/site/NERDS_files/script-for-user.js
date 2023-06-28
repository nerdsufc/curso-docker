
        
        (function(){
            var setAttributes = function (obj, attributes) {
            var fields = Object.keys(attributes);
            fields.forEach(function (field) {
                obj.setAttribute(field, attributes[field]);
            })
        }

        var createElement = function (tag, option) {
            var el = document.createElement(tag)
            setAttributes(el, option)
            return el
        }

        function initMap(options) {
            var height = options.height
            var width = options.width
            var place_id = options.place_id
            var embed_id = options.embed_id
            var cityUrl = options.cityUrl
            var lang = options.lang || 'en'
            var id = options.id || 'map'
            var cityAnchorText = options.cityAnchorText

            var langPartUrl = lang !== 'en' ? lang : ''
            var embedLinkOld = 'https://embedgooglemap.1map.com/' + langPartUrl
            var embedLink = '';
            if(!embedLink) {
				if(langPartUrl) embedLink = 'https://1map.com/' + langPartUrl + '/map-embed'
				else embedLink = 'https://1map.com' + '/map-embed'
			}

            var mapContainer = document.getElementById(id)
            addStyleToMapContainerWrapper(mapContainer.parentNode, { width: width, height: height })

			var mainLinkFromServer = !!'';
            var mainBackLink = getMainBackLink(mapContainer.parentNode, embedLink, embedLinkOld, mainLinkFromServer)
            var shareCodeIsNotIntegrated = !mainBackLink

            // Create link to 1map.com/embed-maps
            if (shareCodeIsNotIntegrated) {
                logIfLinkWasRemoved(embed_id)
                var link = createElement('a', { href: embedLink })
                link.textContent = '1Map'
                link.style.zIndex = -1;
                mapContainer.parentNode.appendChild(link)
            } else {
                mainBackLink.textContent = '1Map'

				if('') {
					mainBackLink.href = '';
				}
            }

            if(cityUrl) {
                // Create link to 1map.com/maps/[CITY]
                var linkCityHref = 'https://1map.com/'
                if (langPartUrl) linkCityHref += langPartUrl + '/'
                linkCityHref += 'maps' + cityUrl
                var linkCity = createElement('a', { href: linkCityHref })

                var cityName = cityUrl.slice(cityUrl.lastIndexOf('/') + 1)
                linkCity.textContent = '' || cityAnchorText || 'Map of ' + cityName

                mapContainer.parentNode.appendChild(linkCity)
                anchorStyling(linkCity)
                linkCity.style.zIndex = -1;
            }

            var mapIframe = createMapIframe({
                queryString: options.queryString,
                centerCoord: options.centerCoord,
                cid: options.cid,
                satellite: options.satellite,
                zoom: options.zoom,
                height: height
            })
            mapContainer.appendChild(mapIframe)

            var anchors = mapContainer.parentNode.querySelectorAll('a')
            for (var i = 0; i < anchors.length; i++)
                anchorStyling(anchors[i])
        }

        function createMapIframe(options) {
            var iframe = createElement('iframe', {
                height: options.height,
                src: createIframeSrc(options.queryString, options.centerCoord, options.cid, options.satellite, options.zoom, options.place_id)
            })

            iframe.style.maxWidth = '100%'
            iframe.style.width = '100%'
            iframe.style.border = 'none'
            iframe.style.padding = '0'
            iframe.style.margin = '0'
            iframe.style.height = options.height + 'px'

            return iframe
        }

        function addStyleToMapContainerWrapper(wrapperOfMap, options) {
            if (!wrapperOfMap) return false

            wrapperOfMap.style.width = options.width + 'px'
            wrapperOfMap.style.maxWidth = '100%'
            wrapperOfMap.style.position = 'relative'
            wrapperOfMap.style.clear = 'both'
            wrapperOfMap.style.maxHeight = options.height + 'px'
            wrapperOfMap.style.textAlign = 'left'

            return true
        }

        function httpGet(theUrl) {
            var xmlHttp = new XMLHttpRequest()
            xmlHttp.open('GET', theUrl)
            xmlHttp.send(null)
            return xmlHttp.responseText
        }

        function anchorStyling(anchor) {
            anchor.style.backgroundColor = '#F5F5F5'
            anchor.style.color = '#444444'
            anchor.style.fontSize = '10px'
            anchor.style.textDecoration = 'none'
            anchor.style.padding = '0 6px'
            anchor.style.lineHeight = '14px'
            anchor.style.fontFamily = 'Roboto, Arial, sans-serif'
            anchor.style.fontWeight = '400'
            anchor.style.position = 'absolute'
            anchor.style.bottom = '0'
        }

        function getMainBackLink(container, linkHref, oldLinkHref, mainLinkFromServer) {
        	var linkFromServer = null;
			if(mainLinkFromServer) linkFromServer = container.querySelector('a')

            var newLink = container.querySelector('a[href^="' + linkHref + '"]')
            var oldLink = container.querySelector('a[href^="' + oldLinkHref + '"]')

            return linkFromServer || newLink || oldLink
        }

        function createIframeSrc(query, coords, cid, satellite, zoom, placeId) {
            var zooms = {
                20: 158.963296919583, //  1128.497220
                19: 317.926593839, // 2256.994440
                18: 635.853187678, // 4513.988880
                17: 1271.7063755, // 9027.977761
                16: 2543.41275071, // 18055.955520
                15: 5086.82550143, // 36111.911040
                14: 10173.6510043, // 72223.822090
                13: 20347.3020113, // 144447.644200
                12: 40694.6040227, // 288895.288400
                11: 81389.2080313, // 577790.576700
                10: 162778.416006, // 1155581.153000
                9: 325556.832153, // 2311162.307000
                8: 651113.664307, // 4622324.614000
                7: 1302227.32847, // 9244649.227000
                6: 2604454.65638, // 18489298.450000
                5: 5208909.31417, // 36978596.910000
                4: 10417818.6283, // 73957193.820000
                3: 20835637.251, // 147914387.600000
                2: 41671274.5162, // 295828775.300000
                1: 83342549.0183 // 591657550.500000
            }

            var sateliteStatus = satellite ? 1 : 0
            return 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d'
                   + zooms[zoom]
                   + '!2d'
                   + coords[1]
                   + '!3d'
                   + coords[0]
                   + '!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x'
		           + cid
		           + '%3A'
                   + placeId
                   + '!2z'
                   + btoa(unescape(encodeURIComponent(query)))
                   + '!5e'
                   + sateliteStatus
                   + '!3m2!1sen!2sau!4v1471218824160'
        }

        function logIfLinkWasRemoved(id) {
            httpGet('https://1map.com/not-integrated/?id=' + id)
        }

        window.OneMap = { initMap: initMap }

            })()
        
    