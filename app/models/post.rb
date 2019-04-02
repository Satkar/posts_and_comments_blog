class Post
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :user_id, type: Integer

  has_many :comments
end
