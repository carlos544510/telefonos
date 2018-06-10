# web/models/user.ex
defmodule Telefonos.User do
  use Telefonos.Web, :model

  schema "users" do
    field :name, :string
    field :telephone, :string
    
  end
end
