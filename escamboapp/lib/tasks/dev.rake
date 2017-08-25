namespace :dev do

  desc "Setup Development"
  task setup: :environment do
    images_path = Rails.root.join('public', 'system')
    
    puts "Executando o setup para desenvolvimento..."
    puts "APAGANDO DB... #{%x(rake db:drop)}"
    puts "APAGANDO IMAGENS DE public/system... #{%x(rm -rf #{images_path})}"
    puts "CRIANDO DB... #{%x(rake db:create)}"
    %x(rake db:migrate)
    puts "CRIANDO CONFIGURAÇÕES PADRÃO DA APLICAÇÃO... #{%x(rake db:seed)}"
    %x(rake dev:generate_admins)
    %x(rake dev:generate_members)
    %x(rake dev:generate_ads)
    %x(rake dev:generate_comments)

    puts "Setup completado com sucesso!"
  end

  ######################################################333

  desc "Cria Administradores Fake"
  task generate_admins: :environment do

    puts "Cadastrando ADMINISTRADORES..."

    10.times do
      Admin.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: "123456",
        password_confirmation: "123456"
      )
    end

    puts "ADMINISTRADORES cadastrados com sucesso!"
  end

  ######################################################333

  desc "Cria Membros Fake"
  task generate_members: :environment do

    puts "Cadastrando MEMBROS..."

    100.times do
      member = Member.new(
        email: Faker::Internet.email,
        password: "123456",
        password_confirmation: "123456"
      )
      member.build_profile_member
      member.profile_member.first_name = Faker::Name.first_name
      member.profile_member.second_name = Faker::Name.last_name

      member.save!
    end

    puts "MEMBROS cadastrados com sucesso!"
  end

  ###########################################################3

  desc "Cria Anúncios Fake"
  task generate_ads: :environment do

    puts "Cadastrando ANÚNCIOS..."

    5.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_md: markdown_fake,
        description_short: Faker::Lorem.sentence([2,3].sample),
        member: Member.first,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
      )
    end

    100.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_md: markdown_fake,
        description_short: Faker::Lorem.sentence([2,3].sample),
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
      )
    end

    puts "ANÚNCIOS cadastrados com sucesso!"
  end

  def markdown_fake
    %x(ruby -e "require 'doctor_ipsum'; puts DoctorIpsum::Markdown.entry")
  end

  desc "Cria Comentários Fake"
  task generate_comments: :environment do
    puts "Cadastrando COMENTÁRIOS..."

      Ad.all.each do |ad|
        (Random.rand(3)).times do
          Comment.create!(
            body: Faker::Lorem.paragraph([1,2,3].sample),
            member: Member.all.sample,
            ad: ad
          )
        end
      end

    puts "COMENTÁRIOS cadastrados com sucesso!"    
  end
end
