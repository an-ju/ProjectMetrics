require 'project_metrics'

describe ProjectMetrics do

  after do
    described_class.reset
  end  

  context 'when configured to report a single metric' do
    
    before do
      described_class.configure do 
        add_metric :code_climate_project_metrics
      end
    end

    describe '.metrics' do
      it 'returns that single metric' do
        expect(ProjectMetrics.metrics).to contain_exactly(:code_climate_project_metrics)
      end
    end

    describe '.metric_names' do
      it 'returns the single metric as a string' do
        expect(ProjectMetrics.metric_names).to contain_exactly('code_climate_project_metrics')
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
      described_class.configure do 
        add_metric :code_climate_project_metrics
        add_metric :github_project_metrics
      end
    end

    describe '.metrics' do
      it 'returns all the metrics in a list' do
        expect(ProjectMetrics.metrics).to contain_exactly(:code_climate_project_metrics,
                                                         :github_project_metrics)
      end
    end

    describe '.metric_names' do
      it 'returns all the metric names as strings' do
        expect(ProjectMetrics.metric_names).to contain_exactly('code_climate_project_metrics',
                                                               'github_project_metrics')
      end
    end

    describe '.report' do
      subject(:report) { described_class.report(['github/AgileVentures/WebsiteOne']).first }

      it 'can report scalar for the first project metric' do
        expect(report.first).to respond_to :scalar
      end
      it 'can report image for the first project metric' do
        expect(report.first).to respond_to :image
      end
      it 'can report scalar for the second project metric' do
        expect(report.second).to respond_to :scalar
      end
      it 'can report image for the second project metric' do
        expect(report.second).to respond_to :image
      end
    end
  end
end