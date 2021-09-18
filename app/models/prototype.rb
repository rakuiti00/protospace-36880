class Prototype < ApplicationRecord

  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true

  belongs_to :user
  has_one_attached :image
  # プロトタイプのレコードが消えるとき、一緒に関連するコメントも一斉に消える設定
  has_many :comments, dependent: :destroy

end
