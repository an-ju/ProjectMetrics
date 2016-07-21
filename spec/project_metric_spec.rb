require 'project_metric'

describe ProjectMetric do
  it 'can be configured to report a particular metric' do
    described_class.configure do |config|
      config.add_metric :code_climate_project_metrics
    end
    expect(ProjectMetric.metrics).to include(:code_climate_project_metrics)
  end
  it 'can be configured to report multiple metrics' do
    described_class.configure do |config|
      config.add_metric :code_climate_project_metrics
      config.add_metric :github_project_metrics
    end
    expect(ProjectMetric.metrics).to include(:code_climate_project_metrics)
    expect(ProjectMetric.metrics).to include(:github_project_metrics)
  end
end