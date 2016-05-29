class Roll < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)

    #Rails.logger.info auth.inspect
    #Rails.logger.info "========="  #這是如果有錯的話可以用來檢查
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

        user.email = auth.info.email

        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name

        user.image = auth.info.image
    end

  end
  
end
