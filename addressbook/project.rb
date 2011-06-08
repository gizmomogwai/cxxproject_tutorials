cxx_configuration do

  source_lib'addressbook_pb_api',
    :sources => ['../build/protoc/addressbook/addressbook.pb.cc'],
    :includes => ['../build/protoc'],
    :dependencies => ['protobuf']

  exe 'addressbook_write',
    :sources => ['addressbook_write.cc'],
    :dependencies => ['addressbook_pb_api']

  exe 'addressbook_read',
    :sources => ['addressbook_read.cc'],
    :dependencies => ['addressbook_pb_api']

end
