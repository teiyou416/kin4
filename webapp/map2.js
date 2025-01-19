 async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
  const map = new Map(document.getElementById("map"), {
    center: { lat: 339.88214293741206, lng: 116.4109209181572 },
    zoom: 14,
    mapId: "roadmap",
  });
  const priceTag = document.createElement("div");

  priceTag.className = "price-tag";
  priceTag.textContent = "Great Palace";

  const marker = new AdvancedMarkerElement({
    map,
    position: { lat: 39.88214293741206, lng: 116.4109209181572 },
    content: priceTag,
  });
}

initMap();