import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';



const initMapbox = () => {
    const mapElement = document.getElementById('map');
    const fitMapToMarkers = (map, markers) => {
        const bounds = new mapboxgl.LngLatBounds();
        markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
        if (markers.size > 0) map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
    };

    if (mapElement) { // only build a map if there's a div#map to inject into
        mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
        const map = new mapboxgl.Map({
            container: 'map',
            style: 'mapbox://styles/saraahbikai/ckf4en03a1ktp19o9mgsg72vx',
            zoom: 2
        });

        const nav = new mapboxgl.NavigationControl();
        map.addControl(nav, 'bottom-right');

        map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
            mapboxgl: mapboxgl }));

        const markers = JSON.parse(mapElement.dataset.markers);
        markers.forEach((marker) => {
            const popup = new mapboxgl.Popup({className:"pop-style"}).setHTML(marker.infoWindow);
            const element = document.createElement('div');
            element.className = 'marker';
            element.style.backgroundImage = `url('${marker.image_url}')`;
            element.style.backgroundSize = 'contain';
            element.style.width = '10px';
            element.style.height = '15px';

            new mapboxgl.Marker(element)
                .setLngLat([marker.lng, marker.lat])
                .addTo(map)
                .setPopup(popup);
        });
        fitMapToMarkers(map, markers);
    }
};

export { initMapbox };


/* const addMarkersToMap = (map, markers) => {
    markers.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this

        new mapboxgl.Marker()
            .setLngLat([marker.lng, marker.lat])
            .setPopup(popup) // add this
            .addTo(map);
    });
}; */