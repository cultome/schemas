class Schemas::RootDefinition < JSON::Schema::Draft4
  def initialize
    super

    @uri = JSON::Util::URI.parse("http://alephri.com/root_definition.json")
    @names = ["http://alephri.com/root_definition.json"]
  end

  JSON::Validator.register_validator(self.new)
end
