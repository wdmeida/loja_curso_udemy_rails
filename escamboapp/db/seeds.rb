# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cadastrando as CATEGORIAS..."
categories = [ 	"Animais e acessórios",
			   	"Esportes",
			   	"Para a sua casa",
			   	"Eletrônicos e celulares",
			   	"Música e hobbies",
			   	"Bebês e crianças",
			   	"Moda e beleza",
				"Veículos e barcos",
				"Imóveis",
				"Empregos e negócios" ]

categories.each do |category|  
	Category.friendly.find_or_create_by!(description: category)
end

puts "CATEGORIAS cadastradas com sucesso!!!"

###############################################333

puts "Cadastrando o ADMINISTRADOR padrão"

adm = Admin.create!(
	name: "Administrador Geral",			
	email: "admin@admin.com", 
	password: "123456", 
	password_confirmation: "123456"
)

adm.add_role(Role.availables[0])
adm.add_role(Role.availables[1])

puts "ADMINISTRADOR cadastrado com sucesso!!!"

###############################################333

puts "Cadastrando o MEMBRO padrão"

member = Member.new(			
	email: "membro@membro.com", 
	password: "123456", 
	password_confirmation: "123456"
)

member.build_profile_member
member.profile_member.first_name = Faker::Name.first_name
member.profile_member.second_name = Faker::Name.last_name

member.save!

puts "MEMBRO cadastrado com sucesso!!!"