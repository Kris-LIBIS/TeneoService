# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# user_teneo = User.create username: 'teneo', email: 'teneo.libis@gmail.com', password: 'abc123'
# user_admin = User.create username: 'admin', email: 'admin@libis.be', password: 'abc123'
# user_libis = User.create username: 'libis', email: 'info@libis.be', password: 'abc123'
# organization_teneo = Organization.create name: 'Teneo'
# organization_libis = Organization.create name: 'Libis'
# role_admin = Role.create code: 'admin', name: 'Administration', description: 'Administer the organizations, users and code tables'
# role_ingest = Role.create code: 'ingest', name: 'Ingests', description: 'Work on ingests'
# role_config = Role.create code: 'config', name: 'Configuration', description: 'Configure the ingests'
# Membership.create user: user_teneo, organization: organization_teneo, role: role_admin
# Membership.create user: user_admin, organization: organization_libis, role: role_config
# Membership.create user: user_libis, organization: organization_libis, role: role_ingest

require 'tty-prompt'
require 'tty-spinner'

class SeedLoader
  attr_reader :base_dir, :prompt

  def initialize(base_dir)
    @base_dir = base_dir
    @prompt = TTY::Prompt.new
    load
  end

  private

  def load
    load_data :admin_user
    load_data :access_right
    load_data :retention_policy
    load_data :producer
    load_data :material_flow
    load_data :representation_type
    load_data :role
    load_data :organization
    load_data :user
    load_data :ingest_model
    load_data :format
  end

  def load_data(klass_name)
    klass = "#{klass_name.to_s.classify}".constantize
    spinner = TTY::Spinner::new("[:spinner] Loading #{klass_name}(s) :file :name", interval: 4)
    spinner.auto_spin
    spinner.update(file: '...', name: '')
    spinner.start
    Dir.children(base_dir).select {|f| f =~ /\.#{klass_name}\.yml$/}.sort.each do |filename|
      spinner.update(file: "from '#{filename}'")
      path = File.join(base_dir, filename)
      data = YAML.load_file(path)
      case data
      when Array
        data.each do |x|
          (n = x[:name] || x['name']) && spinner.update(name: "object '#{n}'")
          klass.from_hash(x)
          spinner.update(name: '')
        end
      when Hash
        klass.from_hash(data)
      else
        prompt.error "Illegal file content: 'path' - either Array or Hash expected."
      end
      spinner.update(file: '...')
    end
    spinner.update(file: '- Done', name: '!')
    spinner.success
  end

end

dir = File.dirname __FILE__
SeedLoader.new(dir)
# SeedLoader.new(File.join dir, '..', 'data', 'seed')AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?