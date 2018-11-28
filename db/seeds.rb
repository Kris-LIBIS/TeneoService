# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user_teneo = User.create username: 'teneo', email: 'teneo.libis@gmail.com', password: 'abc123'
user_admin = User.create username: 'admin', email: 'admin@libis.be', password: 'abc123'
user_libis = User.create username: 'libis', email: 'info@libis.be', password: 'abc123'
group_teneo = Group.create name: 'Teneo'
group_libis = Group.create name: 'Libis'
role_admin = Role.create code: 'admin', name: 'Administration', description: 'Administer the groups, users and code tables'
role_ingest = Role.create code: 'ingest', name: 'Ingests', description: 'Work on ingests'
role_config = Role.create code: 'config', name: 'Configuration', description: 'Configure the ingests'
Membership.create user: user_teneo, group: group_teneo, role: role_admin
Membership.create user: user_admin, group: group_libis, role: role_config
Membership.create user: user_libis, group: group_libis, role: role_ingest