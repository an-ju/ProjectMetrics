require 'yaml'
require 'active_support/all'

class ProjectMetric

  def self.metrics(project_ids)
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

end