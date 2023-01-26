#! /bin/bash

echo "Updating community index..."
wget https://raw.githubusercontent.com/osmlab/osm-community-index/main/dist/completeFeatureCollection.json -O community_index.geojson
cat community_index.geojson | jq ".features[] | select(.id == \"Q2\").properties" > global.geojson
cat community_index.geojson | jq "{type: \"FeatureCollection\", features: [.features[] | select(.id != \"Q2\")]}" > local.geojson

# community_index.geojson

cd ../../MapComplete
ts-node scripts/slice.ts ../MapComplete-data/community_index/local.geojson 6 ../MapComplete-data/community_index/ --slice
