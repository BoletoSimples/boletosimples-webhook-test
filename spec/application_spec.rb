# -*- encoding : utf-8 -*-
require "spec_helper"

describe 'main application' do
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  describe "GET /" do
    before { get '/' }
    it { expect(last_response).to be_ok }
    it { expect(last_response.body).to include('Exemplo de Webhook Server para Boleto Simples') }
  end

  describe "POST /" do
    let(:secret_key) { '2ef97bc3ec0bb91ba9c61afa301bda735a0fdbf2fbee154c7e738ef39be0211c' }
    let(:request_body) { '{"event_code":"ping","webhook":{"id":12,"url":"http://boletosimples-webhook-test-rafael.ngrok.com/callbacks/boletosimples"}}' }
    before { allow(ENV).to receive(:[]).with('WEBHOOK_SECRET_KEY').and_return(secret_key) }
    before { post "/callbacks/boletosimples", request_body, {'Content-Type' => 'application/json', 'HTTP_X_HUB_SIGNATURE' => signature} }
    context 'valid signature' do
      let(:signature) { 'sha1=615fde3645ef3fb20da020a47e9d23044e6434be' }
      it { expect(last_response).to be_ok }
      it { expect(last_response.body).to eq('Event Code: ping') }
    end
    context 'invalid signature' do
      let(:signature) { 'invalid-signature' }
      it { expect(last_response).not_to be_ok }
      it { expect(last_response.body).to eq("Invalid Signature!") }
    end
  end
end