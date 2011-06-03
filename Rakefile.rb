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

PROTOBUF_ARCHIVE="#{PROTOBUF_BASE}.tar.gz"
PROTOBUF_DOWNLOAD="tmp/#{PROTOBUF_ARCHIVE}"

directory 'tmp'

desc "download protobuf #{PROTOBUF_VERSION}"
file PROTOBUF_DOWNLOAD => 'tmp' do
  cd 'tmp' do
    command = "wget http://protobuf.googlecode.com/files/#{PROTOBUF_ARCHIVE}"
    sh command
  end
end

PROTOBUF_CONFIGURE=File.join(PROTOBUF_BASE, 'configure')
desc 'unpack protobuf'
file PROTOBUF_CONFIGURE => PROTOBUF_DOWNLOAD do |t|
  command = "tar xf #{PROTOBUF_DOWNLOAD}"
  sh command
end

PROTOBUF_MAKEFILE = File.join(PROTOBUF_TMP, 'Makefile')
directory PROTOBUF_TMP
desc 'configure protobuf creating makefile'
file PROTOBUF_MAKEFILE => [PROTOBUF_CONFIGURE, PROTOBUF_TMP] do
  cd PROTOBUF_TMP do
    command = '../configure'
    sh command
  end
end

desc 'build protoc and libraries'
file PROTOC => [PROTOBUF_MAKEFILE] do
  cd PROTOBUF_TMP do
    command = 'make'
    sh command
  end
end

CxxProject2Rake.new(FileList['**/*project.rb'], 'build', GCCChain, '.')
