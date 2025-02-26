
# Show help
help: 
  just --list

# Build pong project
build:
  go build -o . ./...

# Run pong project
run:
  go run cmd/pong/main.go

# run tests
test:
  go test ./...

# Clean the project
clean:
  rm -rf bin/
