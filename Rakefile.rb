require 'cxxproject'

PROTOBUF_VERSION='2.4.1'
PROTOBUF_BASE="protobuf-#{PROTOBUF_VERSION}"
PROTOBUF_TMP = File.join(PROTOBUF_BASE, 'tmp')
PROTOC = File.join(PROTOBUF_TMP, 'src', 'protoc')

GEN_FOLDER = File.join('addressbook', 'gen')
directory GEN_FOLDER
['addressbook.pb.cc'].each do |f|
  desc 'protoc addressbook.proto'
  generated_filename = File.join(GEN_FOLDER, 'addressbook', f)
  file generated_filename => [File.join('addressbook', 'addressbook.proto'), GEN_FOLDER, PROTOC] do
    command = "#{PROTOC} --cpp_out=#{GEN_FOLDER} #{File.join('addressbook', 'addressbook.proto')}"
    sh command
  end
end

CxxProject2Rake.new(FileList['**/*project.rb'], 'build', GCCChain, '.')
