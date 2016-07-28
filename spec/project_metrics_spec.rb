require 'project_metrics'

describe ProjectMetrics, :vcr  do

  after do
    described_class.reset
  end  

  before do
    described_class.configure do 
      add_metric :project_metric_code_climate
    end
  end

  describe '.class_for' do
    it 'returns the class name for a metric' do
      expect(ProjectMetrics.class_for('code_climate')).to eq ProjectMetricCodeClimate
    end
  end

  context 'when configured to report a single metric' do

    describe '.metrics' do
      it 'returns that single metric' do
        expect(ProjectMetrics.metrics).to contain_exactly(:project_metric_code_climate)
      end
    end

    describe '.metric_names' do
      it 'returns the single metric as a string' do
        expect(ProjectMetrics.metric_names).to contain_exactly('code_climate')
      end
    end

    describe '.report' do
      subject(:report) { described_class.report(['github/AgileVentures/WebsiteOne']) }
      it 'can report score for a project metric' do
        expect(report.first.first).to respond_to :score
      end
      it 'can report image for a project metric' do
        expect(report.first.first).to respond_to :image
      end
    end

  end

  context 'when configured to report multiple metrics' do

    before do
      described_class.configure do 
        add_metric :project_metric_github
      end
    end

    describe '.metrics' do
      it 'returns all the metrics in a list' do
        expect(ProjectMetrics.metrics).to contain_exactly(:project_metric_code_climate,
                                                         :project_metric_github)
      end
    end

    describe '.metric_names' do
      it 'returns all the metric names as strings' do
        expect(ProjectMetrics.metric_names).to contain_exactly('code_climate',
                                                               'github')
      end
    end

    describe '.report' do
      subject(:report) { described_class.report(['github/AgileVentures/WebsiteOne']).first }

      it 'can report score for the first project metric' do
        expect(report.first).to respond_to :score
      end
      it 'can report image for the first project metric' do
        expect(report.first).to respond_to :image
      end
      it 'can report score for the second project metric' do
        expect(report.second).to respond_to :score
      end
      it 'can report image for the second project metric' do
        expect(report.second).to respond_to :image
      end
    end
  end
end