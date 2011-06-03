require 'cxxproject'

PROTOBUF_VERSION='2.4.1'
PROTOBUF_BASE="protobuf-#{PROTOBUF_VERSION}"

CxxProject2Rake.new(FileList['**/*project.rb'], 'build', GCCChain, '.')
