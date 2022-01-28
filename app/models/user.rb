class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true

    def send_password_reset
        self.reset_password_token = generate_base64_token
        self.reset_password_sent_at = Time.zone.now
        save!
        PasswordMailer.with(user: self).reset.deliver_now
    end

    def password_token_valid?
        (self.reset_password_sent_at + 1.hour) > Time.zone.now
    end

    def reset_password(password)
        self.reset_password_token = nil
        self.password = password
        save!
    end

    private

    def generate_base64_token
        test = SecureRandom.urlsafe_base64
    end
end

#  has_secure_password will provide use with two more virtual fields (password, password_confirmation), which it will use to
#  generate password_digest for a particular user
