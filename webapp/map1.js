 async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
  const map = new Map(document.getElementById("map"), {
    center: { lat: 40.43198933684734, lng: 116.57040708299654 },
    zoom: 14,
    mapId: "roadmap",
  });
  const priceTag = document.createElement("div");

  priceTag.className = "price-tag";
  priceTag.textContent = "Great Palace";

  const marker = new AdvancedMarkerElement({
    map,
    position: { lat: 40.43198933684734, lng: 116.57040708299654 },
    content: priceTag,
  });
}

initMap();