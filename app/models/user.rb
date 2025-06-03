class User < ApplicationRecord
  has_many :reservations, dependent: :destroy
  
  enum role: {user: 0, admin: 1}
  # Validações
  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true, format: { with: /\A\d{11}\z/, message: "deve conter 11 dígitos" }
  validates :role, presence: true
  validates :admin, inclusion: { in: [true, false] }
end
