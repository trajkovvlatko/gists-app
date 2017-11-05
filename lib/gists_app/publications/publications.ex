defmodule GistsApp.Publications do
  @moduledoc """
  The Publications context.
  """

  import Ecto
  import Ecto.Query, warn: false
  alias GistsApp.Repo

  alias GistsApp.Publications.Gist

  @doc """
  Returns the list of gists for the current user.

  ## Examples

      iex> list_gists(user)
      [%Gist{}, ...]

  """
  def list_gists(user) do
    Repo.all(from g in Gist,
             where: g.user_id == ^user.id,
             order_by: [desc: g.inserted_at])
  end

  @doc """
  Returns one public gist.

  ## Examples

      iex> public_gist!(123)
      %Gist{}

      iex> public_gist!(456)
      ** (Ecto.NoResultsError)

  """
  def public_gist(id) do
    Repo.get_by!(Gist, public: true, id: id)
  end

  @doc """
  Returns the list of public gists.

  ## Examples

      iex> public_gists()
      [%Gist{}, ...]

  """
  def public_gists() do
    from g in Gist,
      where: [public: true],
      join: u in assoc(g, :user),
      order_by: [desc: g.inserted_at]
  end

  @doc """
  Returns the list of public gists by search term
  ## Examples

      iex> public_gists("term")
      [%Gist{}, ...]

  """
  def public_gists(term) do
    term = "%#{term}%"
    from g in Gist,
      where: [public: true],
      where: (like(g.name, ^term) or like(g.code, ^term)),
      join: u in assoc(g, :user),
      order_by: [desc: g.inserted_at]
  end

  @doc """
  Gets a single gist.

  Raises `Ecto.NoResultsError` if the Gist does not exist.

  ## Examples

      iex> get_gist!(user, 123)
      %Gist{}

      iex> get_gist!(user, 456)
      ** (Ecto.NoResultsError)

  """
  def get_gist!(user, id) do
    assoc(user, :gists) |> Repo.get!(id)
  end

  @doc """
  Creates a gist.

  ## Examples

      iex> create_gist(%{field: value})
      {:ok, %Gist{}}

      iex> create_gist(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gist(attrs \\ %{}) do
    %Gist{}
    |> Gist.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gist.

  ## Examples

      iex> update_gist(gist, %{field: new_value})
      {:ok, %Gist{}}

      iex> update_gist(gist, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gist(%Gist{} = gist, attrs) do
    gist
    |> Gist.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Gist.

  ## Examples

      iex> delete_gist(gist)
      {:ok, %Gist{}}

      iex> delete_gist(gist)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gist(%Gist{} = gist) do
    Repo.delete(gist)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gist changes.

  ## Examples

      iex> change_gist(gist)
      %Ecto.Changeset{source: %Gist{}}

  """
  def change_gist(%Gist{} = gist) do
    Gist.changeset(gist, %{})
  end
end
