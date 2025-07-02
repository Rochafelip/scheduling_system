class ReservationPolicy < ApplicationPolicy
  # Apenas admins podem ver a lista de todas as reservas
  def index?
    user&.admin?
  end

  # Admins podem ver qualquer reserva; usuários só podem ver as suas
  def show?
    user&.admin? || record.user_id == user&.id
  end

  # Qualquer visitante pode criar reserva (ex: não precisa estar logado)
  def create?
    true
  end

  # Apenas admins podem atualizar
  def update?
    user&.admin?
  end

  # Apenas admins podem destruir
  def destroy?
    user&.admin?
  end
end
