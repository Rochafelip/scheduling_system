class User < ApplicationRecord
  require 'cpf_cnpj'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :reservations, dependent: :destroy

  enum :role, { user: 0, admin: 1 }

  phony_normalize :phone, default_country_code: 'BR'

  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validate :cpf_must_be_valid
  validates :phone, phony_plausible: true 

  private

  def cpf_must_be_valid
    unless CPF.valid?(cpf)
      errors.add(:cpf, "inválido")
    end
  end
end
