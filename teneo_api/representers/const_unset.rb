Object.module_eval do
  def self.const_unset(const)
    self.instance_eval { remove_const(const)}
  end
end
