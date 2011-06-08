require 'cxxproject'

PROTOC = '/usr/bin/protoc'
GEN_FOLDER = File.join('build', 'protoc')

directory GEN_FOLDER

desc 'protoc addressbook.proto'
file File.join(GEN_FOLDER, 'addressbook', 'addressbook.pb.cc') => [File.join('addressbook', 'addressbook.proto'), GEN_FOLDER, PROTOC] do
  command = "#{PROTOC} --cpp_out=#{GEN_FOLDER} #{File.join('addressbook', 'addressbook.proto')}"
  sh command
end

CxxProject2Rake.new(FileList['**/*project.rb'], 'build', GCCChain, '.')
