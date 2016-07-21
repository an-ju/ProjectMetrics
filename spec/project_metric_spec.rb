require 'project_metric'

describe ProjectMetric do

  after do
    described_class.reset
  end  

  context 'when configured to report a single metric' do
    
    before do
      described_class.configure do |config|
        config.add_metric :code_climate_project_metrics
      end
    end

    describe '.metrics' do
      it 'returns that single metric' do
        expect(ProjectMetric.metrics).to contain_exactly(:code_climate_project_metrics)
      end
    end
    describe '.report' do
      subject(:report) { described_class.report(['github/AgileVentures/WebsiteOne']) }
      it 'can report scalar for a project metric' do
        expect(report.first.first).to respond_to :scalar
      end
      it 'can report image for a project metric' do
        expect(report.first.first).to respond_to :image
      end
    end

  end

  context 'when configured to report multiple metrics' do

    before do
      described_class.configure do |config|
        config.add_metric :code_climate_project_metrics
        config.add_metric :github_project_metrics
      end
    end

    describe '.metrics' do
      it 'returns all the metrics in a list' do
        expect(ProjectMetric.metrics).to contain_exactly(:code_climate_project_metrics,
                                                         :github_project_metrics)
      end
    end

    describe '.report' do
      subject(:report) { described_class.report(['github/AgileVentures/WebsiteOne']) }

      it 'can report scalar for the first project metric' do
        expect(report.first.first).to respond_to :scalar
      end
      it 'can report image for the first project metric' do
        expect(report.first.first).to respond_to :image
      end
      it 'can report scalar for the second project metric' do
        expect(report.first.second).to respond_to :scalar
      end
      it 'can report image for the second project metric' do
        expect(report.first.second).to respond_to :image
      end
    end
  end
end