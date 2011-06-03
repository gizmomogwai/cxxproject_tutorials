cxx_configuration do
  BinaryLibrary.new('protobuf').set_lib_searchpaths(File.join(PROTOBUF_BASE, 'tmp', 'src', 'lib'))
end
