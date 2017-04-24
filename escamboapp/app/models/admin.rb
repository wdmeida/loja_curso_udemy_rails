class Admin < ApplicationRecord
  
  #:full_access => 0, :restricted_access => 1
  enum :role => [:full_access, :restricted_access]

  # Scope  
  scope :with_full_access, -> { where(role: :full_access) }
  scope :with_restricted_access, -> { where(role: :restricted_access) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
