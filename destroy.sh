echo "Removing containters..."
docker-compose down

echo "Deleting data..."

rm -rf ./go/server/data/godata
rm -rf ./go/server/data/home-go-dir

rm -rf ./go/agent/data/godata
rm -rf ./go/agent/data/home-go-dir