#!/usr/bin/env ruby
# Modify according to your needs
require 'rubygems'
require 'openssl'
require 'digest/sha1'

exit if Object.const_defined?(:Ocra)

unless ARGV.length == 1
  puts "Syntax: ruby OShredAES.rb filename.txt\n"
  exit
end

# test if file, if not exit
if File.file?("#{ARGV[0]}") == true
  puts ">> File Verified #{ARGV[0]}\n"
else
  puts ">> File only. Closing.\n"
  exit
end
# get file size
s = File.stat("#{ARGV[0]}").size
puts ">> #{ARGV[0]} File Size " "#{s}" " bytes.\n"
if s == 0
  puts ">> #{ARGV[0]} File Size 0.  Closing.\n\n"
  exit
end
# if s <= 1gbtest
if s <= 1000000000
  puts ">> #{ARGV[0]} File Size Accepted limit.\n"
 else  
  puts ">> #{ARGV[0]} File over 1gb, untested.  Exiting Program."
  exit
end
#Get SHA1 hash
a = Digest::SHA1.file("#{ARGV[0]}").hexdigest
puts ">> #{ARGV[0]} Pre Encryption Sha1 value: #{a}\n"
#Encrypt file with AES-256-CBC
begin
  puts ">> Beginning AES Encryption Process....\n"
  file = File.open("#{ARGV[0]}", "rb")
  data = file.read
  file.close
  #encrypt file
  cipher = OpenSSL::Cipher.new 'AES-256-CBC'
  cipher.encrypt
  iv = cipher.random_iv
  key = cipher.random_key
  puts %(Key: "#{key.inspect}") #obviously to be removed, left for testing and verification purposes
  puts %(Initialization Vector: "#{iv.inspect}")
  puts %(Cipher Alg:   #{cipher.inspect}")
  encrypted = cipher.update "#{data}"
  encrypted << cipher.final
  output = File.open("#{ARGV[0]}", "wb")
  output << encrypted
  output.close
  puts ">> AES Encryption complete.\n"
  #resets
  file = nil 
  output = nil
  key = nil
  iv = nil
  cipher.reset
rescue
  puts "Error #{e}\n"
end
#post encryption SHA1 value
b = Digest::SHA1.file("#{ARGV[0]}").hexdigest
puts ">> #{ARGV[0]} Post Encryption Sha1 value: #{b}\n"
#values on exit
puts "values on exit\n"
puts "file: #{file}"
puts "output: #{output}"
puts "iv: #{iv.inspect}"
puts "key: #{key.inspect}"
#delete file
begin
  File.delete("#{ARGV[0]}")
  puts ">> #{ARGV[0]} deleted.\n\n"
rescue Errno::ENOENT
  File.delete(@lf)
end
