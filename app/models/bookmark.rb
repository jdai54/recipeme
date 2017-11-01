class Bookmark < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :like, dependent: :destroy
end
