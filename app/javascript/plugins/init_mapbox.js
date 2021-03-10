import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  // const mapElement = document.getElementById('map');

  // if (mapElement) {
  //   mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  //   const map = new mapboxgl.Map({
  //     container: 'map',
  //     style: 'mapbox://styles/mapbox/streets-v10'
  //   });

  //   const markers = JSON.parse(mapElement.dataset.markers);

  //   markers.forEach((marker) => {
  //     new mapboxgl.Marker()
  //     .setLngLat([ marker?.lng, marker?.lat ])
  //     .addTo(map);
  //   });

  //   const fitMapToMarkers = (map, markers) => {
  //     if (markers.length === 0) return;
  //     const bounds = new mapboxgl.LngLatBounds();
  //     markers.forEach(marker => bounds.extend([ marker?.lng, marker?.lat ]));
  //     map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  //   };

  //   if (mapElement) {
  //     fitMapToMarkers(map, markers);
  //   }
  // }
};

export { initMapbox };
