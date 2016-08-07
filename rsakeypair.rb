#!/usr/bin/env ruby
# RSAkeygen
# Generate and public/private RSA key pair.
# Secure private key with password
require 'openssl'

exit if Object.const_defined?(:Ocra)

unless ARGV.length == 1
  puts "Syntax: ruby RSAkeygen.rb KeyPairSize\n"
  puts "Example: ruby RSAkeygen.rb 2048"
  exit
end

begin 
#RSA Shizzle
key = OpenSSL::PKey::RSA.new 2048
open 'private_key.pem', 'w' do |io| io.write key.to_pem end
open 'public_key.pem', 'w' do |io| io.write key.public_key.to_pem end
puts "RSA Keypair successfull generated."
rescue
  puts "Error #{e}\n"
end

begin
print "Enter passphrase to secure key using AES 128: "
pass_phrase = STDIN.gets.chomp
cipher = OpenSSL::Cipher.new 'AES-128-CBC'
key_secure = key.export cipher, pass_phrase
open 'private.secure.pem', 'w' do |io|
  io.write key_secure
end
rescue
  puts "Error #{e}\n"
end
