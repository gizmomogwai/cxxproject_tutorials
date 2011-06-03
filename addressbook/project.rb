cxx_configuration do

  exe 'addressbook_write',
    :sources => ['addressbook_write.cc'],
    :dependencies => ['addressbook_pb_api']

  exe 'addressbook_read',
    :sources => ['addressbook_read.cc'],
    :dependencies => ['addressbook_pb_api']

end
