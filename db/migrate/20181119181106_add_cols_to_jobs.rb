class AddColsToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :job_title, :string
    add_column :jobs, :contact_email, :string
    add_column :jobs, :job_description, :text
    add_column :jobs, :other_information, :text
  end
end
