# -*- encoding : utf-8 -*-
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'haml'
require 'json'

configure do
  set :views, '.'
end

get '/' do
  markdown :README, layout_engine: :haml
end

post '/callbacks/boletosimples' do
  verify_signature

  payload = JSON.parse(request_body)
  "Event Code: #{payload['event_code']}"
end

def request_body
  @request_body ||= request.body.read.to_s
end

def secret_key
  return halt 500, "Set WEBHOOK_SECRET_KEY environment variable before running web server.\nExample:\n $ export WEBHOOK_SECRET_KEY=c2ef97bc3e0bfa301bda735a0fdbf2fbee154c7e73b91ba9c61a8ef39be0211c\n  $ shotgun config.ru" if ENV['WEBHOOK_SECRET_KEY'].nil?
  ENV['WEBHOOK_SECRET_KEY']
end

def signature_from_request
  request.env['HTTP_X_HUB_SIGNATURE']
end

def generated_signature
  'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), secret_key, request_body)
end

def verify_signature
  return halt 500, "Invalid Signature!" unless Rack::Utils.secure_compare(signature_from_request, generated_signature)
end