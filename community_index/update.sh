#! /bin/bash

echo "Updating community index..."
# wget https://raw.githubusercontent.com/osmlab/osm-community-index/main/dist/completeFeatureCollection.json -O community_index.geojson
# cat community_index.geojson | jq ".features[] | select(.id == \"Q2\").properties.resources" > global.json
# cat community_index.geojson | jq "{type: \"FeatureCollection\", features: [.features[] | select(.id != \"Q2\")]}" > local.geojson


cat community_index.geojson | jq ".features[].properties.resources | keys[] as \$k | .[$k].type" | sort | uniq | tr -d '"' > types.txt

for TYPE in `cat types.txt`
do
	if [[ -f $TYPE.svg ]]
	then
		echo "Already exists: $TYPE"
	else
		wget https://raw.githubusercontent.com/osmlab/osm-community-index/main/dist/img/$TYPE.svg
	fi
done

echo -e "\r                                        "


# community_index.geojson

cd ../../MapComplete
# ts-node scripts/slice.ts ../MapComplete-data/community_index/local.geojson 6 ../MapComplete-data/community_index/ --clip
