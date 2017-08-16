echo "Removing containters..."
docker-compose down

echo "Deleting data..."

rm -rf ./go/server/resources/godata
rm -rf ./go/server/resources/home-go-dir

rm -rf ./go/agent/resources/godata
rm -rf ./go/agent/resources/home-go-dir