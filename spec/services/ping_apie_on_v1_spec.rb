require 'rails_helper'

describe PingAPIEOnV1, type: :service do
  subject(:service) { described_class.new }

  let(:endpoint_etablissements) do
    Endpoint.new(
      name: 'etablissements',
      api_version: 1,
      api_name: 'apie',
      parameter: '41816609600069',
      options:
      {
        recipient: 'SGMAP',
        context: 'Ping'
      }
    )
  end

  it 'ensure all endpoints works', vcr: { cassette_name: 'apie_v1' } do
    expect(Rails.logger).not_to receive(:error)

    service.perform do |p|
      expect("#{p.name}: #{p.status}").to eq("#{p.name}: up")
    end
  end

  describe 'with a specific period' do
    subject(:service) { described_class.new(hash) }
    let(:hash) { { :period => 60 } }

    it 'loads less endpoints' do
      expect(service.send(:endpoints).count).to eq(11)
    end
  end
end