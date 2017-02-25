class User < ApplicationRecord
  has_many	:teams

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   ROLES = {0 => :guest, 1 => :player, 2 => :suser, 3 => :admin}

     def is?(requested_role)
   	self.role == requested_role.to_s
   end

end
