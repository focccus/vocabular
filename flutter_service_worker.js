'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "99914b932bd37a50b983c5e7c90ae93b",
"assets/FontManifest.json": "580ff1a5d08679ded8fcf5c6848cece7",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/LICENSE": "950fe08c430ea815bde814ef1a1a0d2a",
"icons/180.png": "18f64c6f00734d23820e66091f1f6933",
"icons/192.png": "b2dd17549056c82d5272e94b7dcd5f3c",
"icons/512.png": "ce329b62511d8498d991fd5b7fe00228",
"icons/72.png": "81761ec3bbb76d7f53544908c49da2eb",
"icons/96.png": "6e24eb097b66e85fb17b71013765d85f",
"index.html": "7e8020160b69a523f1c7888204a9ed82",
"main.dart.js": "edc539814a01795d056385c40323dc19",
"manifest.json": "9788de4e810a3ef8ddfcb98352dc08b4"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
