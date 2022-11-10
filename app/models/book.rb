class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  #過去７日分それぞれの投稿数を一覧表示する
  #scope :スコープの名前, -> { 条件式 }
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } #今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } #前日
  scope :created_two_day_ago, -> { where(created_at: 2.days.ago.all_day) }
  scope :created_three_day_ago, -> { where(created_at: 3.days.ago.all_day) }
  scope :created_four_day_ago, -> { where(created_at: 4.days.ago.all_day) }
  scope :created_five_day_ago, -> { where(created_at: 5.days.ago.all_day) }
  scope :created_six_day_ago, -> { where(created_at: 6.days.ago.all_day) }
  #scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } #今週
  #scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } #先週


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐        完全一致以外の検索方法は、contentの前後(もしくは両方に)、__%__を追記することで定義することができる。 where(カラム名: "検索したい文字列")
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE?', content + '%')
    elsif method == 'backward'
      Book.where('title LIKE?', '%' + content)
    else
      Book.where('title LIKE?', '%' + content + '%')
    end
  end
end