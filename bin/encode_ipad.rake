#!/usr/bin/env rake

SOURCE_DIR = "~/Movies/Encode to iPad"

desc "Encode"
task :encode, :in do |t,args|
  file_in = args[:in]
  puts "Converting #{file_in} to iPad..."
  system "ffmpeg -i #{SOURCE_DIR}/#{file_in}.mov [FFMPEG settings] #{PRODUCTION_DIR}/#{file_in}.flv"
  puts "Done with Movie"
end

