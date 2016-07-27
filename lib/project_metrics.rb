require 'active_support/all'

class ProjectMetrics

  def self.configure &block
    instance_eval &block
  end

  def self.metrics
    @metrics
  end

  def self.report project_ids 
    require_metrics
    assemble_metrics_for project_ids
  end

  def self.reset
    @metrics = []
  end

  private

  @metrics = []

  def self.add_metric metric
    @metrics << metric
  end

  def self.require_metrics
    @metrics.map do |source|
      require source.to_s
    end
  end

  def self.assemble_metrics_for project_ids
    project_ids.map do |project_id|
      @metrics.map do |source|
         source.to_s.camelize.constantize.new project_id
      end
    end
  end
end