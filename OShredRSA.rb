#!/usr/bin/env ruby
#experiment with this to verify
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
puts ">> #{ARGV[0]} Pre Encryption Sha1 value:  #{a}\n"
#Encrypt file with RSA Public Key
begin
key1 = OpenSSL::PKey::RSA.new File.read 'public_key.pem'
key1.public?
file = File.open("#{ARGV[0]}", "rb")
data = file.read
file.close
encrypted = key1.public_encrypt('data')
output = File.open("#{ARGV[0]}", "wb")
output << encrypted
output.close
#Get SHA1 hash
b = Digest::SHA1.file("#{ARGV[0]}").hexdigest
puts ">> #{ARGV[0]} Post Encryption Sha1 value: #{b}\n"
rescue
  puts "Error #{e}\n"
end
