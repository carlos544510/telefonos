defmodule Telefonos.UserController do
  use Telefonos.Web, :controller
  alias Telefonos.User

  defp perform_update(conn, user, params) do
    changeset = Telefonos.User.changeset(user, params)
    IO.puts("hola")
    IO.inspect(params)
    IO.puts("se acaba")
    IO.inspect(changeset)
    IO.puts("")
    case Repo.update(changeset) do
      {:ok, user} ->
        json conn |> put_status(:ok), user
      {:error, _result} ->
        json conn |> put_status(:bad_request),
                     %{errors: ["unable to update user"]}
    end
  end

  defp conn_with_status(conn, nil) do
    conn
      |> put_status(:not_found)
  end

  defp conn_with_status(conn, _) do
    conn
      |> put_status(:ok)
  end

  def index(conn, _params) do
    users = Repo.all(Telefonos.User)
    json conn_with_status(conn, users), users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(Telefonos.User, String.to_integer(id))
    json conn_with_status(conn, user), user
  end

  def borrar(conn, %{"id" => id}) do
    user = Repo.get(Telefonos.User, String.to_integer(id))
    Telefonos.Repo.delete(user)
    json conn_with_status(conn, user), user
  end

  def create(conn, params) do
      changeset = Telefonos.User.changeset(
        %Telefonos.User{}, params)
  case Repo.insert(changeset) do
        {:ok, user} ->
          json conn |> put_status(:created), user
        {:error, _changeset} ->
          json conn |> put_status(:bad_request), %{errors: ["unable to create user"] }
      end
    end

    def update(conn, %{"id" => id} = params) do
    user = Repo.get(Telefonos.User, id)
    if user do
      perform_update(conn, user, params)
      #IO.inspect(params)

    else
      json conn |> put_status(:not_found),
                   %{errors: ["invalid user"]}
    end
  end

  def actualizar(conn, %{"id" => id, "params" => params }) do

    user = Repo.get(Telefonos.User, String.to_integer(id))
    changeset =
      user
      |> User.changeset(params)
      |> Repo.update
    json conn, %{ok: "actualizado"}
  end

def crear(conn, %{"params" => params }) do
  changeset =
    %{}
    |> User.changeset(params)
    |> Repo.insert
  json conn, %{ok: "creado"}
end




end
