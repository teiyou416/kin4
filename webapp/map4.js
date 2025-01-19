 async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
  const map = new Map(document.getElementById("map"), {
    center: { lat: 39.993199758890455, lng: 116.39652781861307 },
    zoom: 14,
    mapId: "roadmap",
  });
  const priceTag = document.createElement("div");

  priceTag.className = "price-tag";
  priceTag.textContent = "Great Palace";

  const marker = new AdvancedMarkerElement({
    map,
    position: { lat:39.993199758890455, lng: 116.39652781861307 },
    content: priceTag,
  });
}

initMap();

