class Member < ApplicationRecord
  
  # RatyRate gem
  ratyrate_rater

  # Associations
  has_many :ads
  has_one :profile_member
  accepts_nested_attributes_for :profile_member

  # Validations
  validate :nested_attributes
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

    def nested_attributes
      if nested_attributes_blank?
        errors.add(:base, 'Os campos Nome e Sobrenome são obrigatórios.')
      end
    end

    def nested_attributes_blank?
      profile_member.first_name.blank? || profile_member.second_name.blank?
    end
end
