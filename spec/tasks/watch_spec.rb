require 'rails_helper.rb'

# rubocop:disable Rspec/MultipleDescribes
describe 'watch:all', vcr: { cassette_name: 'apie_all' } do
  include_context 'rake'

  before { Tools::EndpointDatabaseFiller.instance.refill_database }

  context 'with all endpoints' do
    it 'exactly send 40 workers to sidekiq' do
      task.invoke
      expect { PingWorker.drain }.to change { PingWorker.jobs.size }.from(endpoints_count).to(0)
    end
  end
end

describe 'watch:period_1', vcr: { cassette_name: 'apie_all' } do
  include_context 'rake'

  before { Tools::EndpointDatabaseFiller.instance.refill_database }

  context 'with all endpoints' do
    it 'exactly send 2 workers to sidekiq' do
      task.invoke
      expect { PingWorker.drain }.to change { PingWorker.jobs.size }.from(2).to(0)
    end
  end
end

describe 'watch:period_5', vcr: { cassette_name: 'apie_all' } do
  include_context 'rake'

  before { Tools::EndpointDatabaseFiller.instance.refill_database }

  context 'with all endpoints' do
    it 'exactly send 5 workers to sidekiq' do
      task.invoke
      expect { PingWorker.drain }.to change { PingWorker.jobs.size }.from(5).to(0)
    end
  end
end

describe 'watch:period_60', vcr: { cassette_name: 'apie_all' } do
  include_context 'rake'

  before { Tools::EndpointDatabaseFiller.instance.refill_database }

  context 'with all endpoints' do
    it 'exactly send 33 workers to sidekiq' do
      task.invoke
      expect { PingWorker.drain }.to change { PingWorker.jobs.size }.from(33).to(0)
    end
  end
end
