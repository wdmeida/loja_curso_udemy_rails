namespace :utils do

  desc "Cria Administradores Fake"
  task generate_admins: :environment do

    puts "Cadastrando ADMINISTRADORES..."

    10.times do
      Admin.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: "123456",
        password_confirmation: "123456",
        role: [0, 0, 1, 1, 1].sample
      )
    end

    puts "ADMINISTRADORES cadastrados com sucesso!"
  end

  ######################################################333

  desc "Cria Membros Fake"
  task generate_members: :environment do

    puts "Cadastrando MEMBROS..."

    10.times do
      Member.create!(
        email: Faker::Internet.email,
        password: "123456",
        password_confirmation: "123456"
      )
    end

    puts "MEMBROS cadastrados com sucesso!"
  end

  ###########################################################3

  desc "Cria Anúncios Fake"
  task generate_ads: :environment do

    puts "Cadastrando ANÚNCIOS..."

    100.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: LeroleroGenerator.paragraph(Random.rand(3)),
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}"
      )
    end

    puts "ANÚNCIOS cadastrados com sucesso!"
  end

end
