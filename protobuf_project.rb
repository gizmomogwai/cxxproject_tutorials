cxx_configuration do
  BinaryLibrary.new('protobuf').set_lib_searchpaths(File.join(PROTOBUF_BASE, 'tmp', 'src', '.libs')).set_includes(File.join(PROTOBUF_BASE, 'src'))
end
