require 'faker'
require 'cpf_cnpj'

puts "👥 Criando usuários comuns..."

10.times do
  begin
    raw_phone = Faker::PhoneNumber.cell_phone_in_e164

    # Verifica se é plausível segundo a lib `phony`
    next unless Phony.plausible?(raw_phone)

    normalized_phone = PhonyRails.normalize_number(raw_phone, default_country_code: 'BR')

    User.create!(
      name: Faker::Name.name,
      cpf: CPF.generate(true),
      phone: normalized_phone,
      email: Faker::Internet.unique.email,
      password: "123456",
      password_confirmation: "123456",
      role: :user
    )
  rescue ActiveRecord::RecordInvalid => e
    puts "❌ Erro ao criar usuário comum: #{e.message}"
  end
end

puts "🛡 Criando administradores..."

3.times do
  begin
    raw_phone = Faker::PhoneNumber.cell_phone_in_e164
    next unless Phony.plausible?(raw_phone)

    normalized_phone = PhonyRails.normalize_number(raw_phone, default_country_code: 'BR')

    User.create!(
      name: Faker::Name.name,
      cpf: CPF.generate(true),
      phone: normalized_phone,
      email: Faker::Internet.unique.email,
      password: "admin123",
      password_confirmation: "admin123",
      role: :admin
    )
  rescue ActiveRecord::RecordInvalid => e
    puts "❌ Erro ao criar admin: #{e.message}"
  end
end

puts "✅ Usuários criados com sucesso!"
