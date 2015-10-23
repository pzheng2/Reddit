class Post < ActiveRecord::Base
  validates :title, :sub_id, :author_id, presence: true

  # belongs_to(
  #   :sub,
  #   class_name: "Sub",
  #   foreign_key: :sub_id,
  #   primary_key: :id
  # )

  has_many(
    :post_sub,
    class_name: "PostSub",
    foreign_key: :post_id,
    primary_key: :id,
    inverse_of: :post
  )

  has_many(
    :subs,
    through: :post_sub,
    source: :sub
  )

end
