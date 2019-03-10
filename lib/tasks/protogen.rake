desc "Compile protobuf definitions"
task :protogen do
  grpc_ruby_plugin = `which grpc_ruby_plugin`.chomp
  command_string = "protoc \
    -I ./lib \
    --ruby_out ./lib \
    --grpc_out ./lib \
    --plugin=protoc-gen-grpc=#{grpc_ruby_plugin} \
    ./lib/riddler/protobuf/*.proto"

  system command_string
end
