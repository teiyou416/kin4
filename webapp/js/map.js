 async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
  const map = new Map(document.getElementById("map"), {
    center: { lat: 39.91, lng: 116.39 },
    zoom: 14,
    mapId: "roadmap",
  });
  const priceTag = document.createElement("div");

  priceTag.className = "price-tag";
  priceTag.textContent = "Great Palace";

  const marker = new AdvancedMarkerElement({
    map,
    position: { lat: 39.9166980, lng: 116.3971850 },
    content: priceTag,
  });
}

initMap();