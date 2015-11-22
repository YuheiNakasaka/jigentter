class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :tweets

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:          auth.uid,
        provider:     auth.provider,
        email:        User.dummy_email(auth),
        password:     Devise.friendly_token[0, 20],
        access_token: auth.credentials.token,
        secret_token: auth.credentials.secret,
        name: auth.info.nickname
      )
    end

    if user.try(:access_token) != auth.credentials.token || user.try(:secret_token) != auth.credentials.secret
      user.access_token = auth.credentials.token
      user.secret_token = auth.credentials.secret
      user.name = auth.info.nickname
      user.save!
    end

    user
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
