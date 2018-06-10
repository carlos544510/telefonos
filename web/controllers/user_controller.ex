defmodule Telefonos.UserController do
  use Telefonos.Web, :controller

  def index(conn, _params) do
    users = Repo.all(Telefonos.User)
    json conn, users
  end
  
  def show(conn, %{"id" => id}) do
    user = Repo.get(Telefonos.User, String.to_integer(id))
    json conn, user
  end
end
