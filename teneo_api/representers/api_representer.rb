require 'grape/roar/decorator'
require 'roar/json'

class ApiRepresenter < Grape::Roar::Decorator
  include Roar::JSON

end