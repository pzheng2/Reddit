class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id
  )

  # has_many(
  #   :posts,
  #   class_name: "Post",
  #   foreign_key: :sub_id,
  #   primary_key: :id
  # )

  has_many(
    :post_subs,
    class_name: "PostSub",
    foreign_key: :post_id,
    primary_key: :id
  )

  has_many(
    :posts,
    through: :post_subs,
    source: :post
  )

end
