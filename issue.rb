class Issue < ActiveRecord::Base
  belongs_to :project, foreign_key: 'project_id'
end
