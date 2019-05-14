class User < ApplicationRecord

  has_many :reviews

  validates_presence_of :name

  def self.top_reviewers
    joins(:reviews).group(:id).order('count(reviews) DESC').limit(3)
    #     FROM users
    #       INNER JOIN reviews ON reviews.user_id = users.id
    #
    #     GROUP BY user_id
    #     ORDER BY count
    #     DESC limit(3);


        #username and review count
    # joins(:reviews).select("users*, count(user_id)").group(:id
    # joins(:reviews).
  end
end
