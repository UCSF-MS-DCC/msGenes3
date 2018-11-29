class Paper < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :author
  validates_presence_of :pubdate
  validates_presence_of :pmid
  validates_presence_of :publication
end
