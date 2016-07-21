require 'yaml'
require 'active_support/all'

class ProjectMetric

  @@metrics = []

  def self.metrics project_ids 
    cnf = YAML::load_file('config.yml')
    cnf['sources'].map do |source|
       require source
    end
    project_ids.map do |project_id|
      cnf['sources'].map do |source|
         source.camelize.constantize.new(project_id)
      end
    end
  end

  def self.add_metric metric
    @@metrics << metric
  end

  def self.configure
    yield self
  end

  def self.metrics
    @@metrics
  end

end