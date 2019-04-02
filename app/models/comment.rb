class Comment
  include Mongoid::Document
  field :message, type: String
  field :user_id, type: Integer
  field :post_id, type: Integer

  belongs_to :post
end
