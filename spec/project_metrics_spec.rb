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
  end

  context 'when configured with hierarchies' do

    before do
      described_class.configure do
        add_metric :project_metric_github
      end
    end

    describe '.add_hierarchy' do
      let(:hierarchy) {{l1: %I[project_metric_code_climate project_metric_github]}}

      it 'updates the hierarchy' do
        expect(ProjectMetrics.add_hierarchy(hierarchy)).to eq hierarchy
      end

      it 'returns the right hierarchy' do
        ProjectMetrics.add_hierarchy hierarchy
        expect(ProjectMetrics.hierarchies(:l1)).to eq hierarchy[:l1]
      end

    end
  end
end
