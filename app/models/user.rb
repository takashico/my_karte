class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  validates :user_name, presence: true, length: { maximum: 50 }
  validate :picture_size
  mount_uploader :user_image, PictureUploader

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.user_attributes"] &&
        session["devise.user_attributes"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
      if data = session["devise.user_attributes"]
        user.provider = data["provider"] if user.provider.blank?
        user.uid = data["uid"] if user.uid.blank?
      end
    end
  end

  private

  def picture_size
    if user_image.size > 5.megabytes
      errors.add(:user_image, "5MB以上のファイルはアップロードできません")
    end
  end
end
