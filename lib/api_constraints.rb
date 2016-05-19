## Constraint to match the desired API version in the routes

class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || req.headers['Accept'].include?("application/vnd.watch-this.v#{@version}")
  end
end
