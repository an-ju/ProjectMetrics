require 'yaml'
require 'active_support/all'

class ProjectMetric

  @metrics = []

  def self.report project_ids 
    @metrics.map do |source|
      require source.to_s
    end
    project_ids.map do |project_id|
      @metrics.map do |source|
         source.to_s.camelize.constantize.new(project_id)
      end
    end
  end

  def self.add_metric metric
    @metrics << metric
  end

  def self.configure
    yield self
  end

  def self.metrics
    @metrics
  end

  def self.reset
    @metrics = []
  end

end