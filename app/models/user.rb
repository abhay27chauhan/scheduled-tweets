class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true
end

#  has_secure_password will provide use with two more virtual fields (password, password_confirmation), which it will use to
#  generate password_digest for a particular user
