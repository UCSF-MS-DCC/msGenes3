class Job < ApplicationRecord
  validates_presence_of :job_title
  validates_presence_of :contact_email
  validates_presence_of :job_description
end
