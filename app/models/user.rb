# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)
#  image_url              :string(255)
#  group_id               :integer
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  belongs_to :group

  def self.twitter_auth(auth_hash)
    email = auth_hash[:info][:nickname].downcase + '@twitter.com'
    image = auth_hash[:info][:image]
    if user = User.find_by_email(email)
      user.update_column(:image_url, image) if user.image_url != image
      user
    else
      User.create!( email: email,
                    username: auth_hash[:info][:nickname],
                    image_url: image,
                    password: Devise.friendly_token[0,10],
                    twitter_id: auth_hash[:uid])
    end
  end
end
