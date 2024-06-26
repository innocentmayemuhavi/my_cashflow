'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "caf13d4402c526c271db663591ab898f",
"assets/AssetManifest.bin.json": "fafdffa465bb2180a7014c8255fe1d15",
"assets/AssetManifest.json": "ff367ac24f15ee509a02fb6b9daca7e6",
"assets/assets/fonts/Kanit-Black.ttf": "98e93fc09832d3891a57162b83ecb930",
"assets/assets/fonts/Kanit-BlackItalic.ttf": "2ec43223c5620d6cb2fc97adbab58902",
"assets/assets/fonts/Kanit-Bold.ttf": "69646b07726772636b613cc5e12a1f28",
"assets/assets/fonts/Kanit-BoldItalic.ttf": "7c3d44c8821780dc2451c67cb30d31da",
"assets/assets/fonts/Kanit-ExtraBold.ttf": "41df63b2d1938bf065ba71700f32b623",
"assets/assets/fonts/Kanit-ExtraBoldItalic.ttf": "10727518e2122f5478b18fd5b6a8979c",
"assets/assets/fonts/Kanit-ExtraLight.ttf": "8b786d6635f731d5bfe226e9f776531b",
"assets/assets/fonts/Kanit-ExtraLightItalic.ttf": "26a1b414edb5f96f52933acbcdbbfa18",
"assets/assets/fonts/Kanit-Italic.ttf": "681198abb02b3001bcd92b9437894450",
"assets/assets/fonts/Kanit-Light.ttf": "eb18967912c9c66c98deec24bfe1efbd",
"assets/assets/fonts/Kanit-LightItalic.ttf": "3b58ba9e1202872b29ee615e2cab2088",
"assets/assets/fonts/Kanit-Medium.ttf": "2fedce7deb446c41cc5274c226b43c04",
"assets/assets/fonts/Kanit-MediumItalic.ttf": "e1b3b87b0c17b0f670f5170e0a34eb93",
"assets/assets/fonts/Kanit-Regular.ttf": "ba95370355da928d1c09da6a0a49a1d6",
"assets/assets/fonts/Kanit-SemiBold.ttf": "efc1b35c18175cae0b8a3d06e3025cbe",
"assets/assets/fonts/Kanit-SemiBoldItalic.ttf": "1fecb41477cac535aeaf9b4f96890d80",
"assets/assets/fonts/Kanit-Thin.ttf": "c0b1b7e615614217544a2f588cc18188",
"assets/assets/fonts/Kanit-ThinItalic.ttf": "49e6ab0af059a77c7f2ac161b92642ba",
"assets/assets/images/logo.png": "f43ed7d72c6ad7e4dda7581c3b252a8e",
"assets/assets/images/otp.png": "727261e64e6ed3420c054ab5eb16610c",
"assets/FontManifest.json": "8972f7651d853feb5168fd365b35bd8d",
"assets/fonts/MaterialIcons-Regular.otf": "70c2d6488a157e0465627f9dc077f6c5",
"assets/NOTICES": "14eedc4846c01e5d62aa12deb8619a1b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "9f6c6b49a5f65d6832b6e949b2c00c37",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "7e87bd062846b3773479c0cd6efb5403",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "2e000b7ecaf5477d35f71534939cde32",
"/": "2e000b7ecaf5477d35f71534939cde32",
"main.dart.js": "47ca8c7a24d50f4c1c701c2f295a8268",
"manifest.json": "c3034da4ab40d9fdaffb3ed5f1af87a3",
"version.json": "e9fba1588a338e35679cbaa99c7b6c42"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
