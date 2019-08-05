defmodule HamRadio.Grid do
  @moduledoc """
  Converts between coordinates and Maidenhead grid locators.
  """

  @alphabet ~w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
  @regex ~r/[A-R]{2}[0-9]{2}($|([a-x]{2}$))/i

  @type coord :: {lat :: float, lon :: float}
  @type coord_bounds ::
          {{lat_min :: float, lat_max :: float}, {lon_min :: float, lon_max :: float}}

  @type grid_length :: 4 | 6

  @doc """
  Converts a coordinate pair into a grid square.

  The `length` can be `4` (default) or `6`, returning grids like `"FN32"` or `"FN32ab"`, respectively.
  """
  @spec encode(coord, grid_length) :: {:ok, String.t()} | :error
  def encode(coord, length \\ 4)

  def encode({lat, lon}, length)
      when length in [4, 6] and lat >= -90.0 and lat <= 90 and lon >= -180 and lon <= 180 do
    # Normalize from (-90, -180) to (0, 0)
    lon = lon + 180.0
    lat = lat + 90.0

    # Map lon from 0 to 17 (A to R)
    lon_index_1 = trunc(lon / 20.0)
    lat_index_1 = trunc(lat / 10.0)

    # 20 degrees lon per grid
    lon = lon - lon_index_1 * 20.0
    # 10 degrees lat per grid
    lat = lat - lat_index_1 * 10.0

    # Map from 0 to 9
    lon_index_2 = trunc(lon / 2.0)
    lat_index_2 = trunc(lat)

    # Convert to string
    grid =
      "#{Enum.at(@alphabet, lon_index_1)}#{Enum.at(@alphabet, lat_index_1)}#{lon_index_2}#{
        lat_index_2
      }"

    if length == 6 do
      # Now 2 degrees lon per grid remaining
      lon = lon - lon_index_2 * 2.0
      # Now 1 degree lon per grid remaining
      lat = lat - lat_index_2

      # Map from 0 to 23 (a to x)
      lon_index_3 = trunc(lon / (2.0 / 24.0))
      lat_index_3 = trunc(lat / (1.0 / 24.0))

      # Return 6-letter grid
      {
        :ok,
        "#{grid}#{String.downcase(Enum.at(@alphabet, lon_index_3))}#{
          String.downcase(Enum.at(@alphabet, lat_index_3))
        }"
      }
    else
      # Return 4-letter grid
      {:ok, grid}
    end
  end

  def encode(_, _), do: :error

  @doc """
  Converts a coordinate pair into a grid square.

  Raises `ArgumentError` if the coordinates are invalid.
  """
  @spec encode!(coord, grid_length) :: String.t() | no_return
  def encode!(coord, length \\ 4) do
    case encode(coord, length) do
      {:ok, grid} -> grid
      :error -> raise ArgumentError, "Invalid coordinate or grid length"
    end
  end

  @doc """
  Converts a grid square into a coordinate pair.

  The coordinate is located at the center of the grid square.

  Returns `:error` if the grid is invalid.
  """
  @spec decode(String.t()) :: {:ok, coord} | :error
  def decode(grid) when is_binary(grid) do
    if valid?(grid) do
      {:ok, decode_valid!(grid)}
    else
      :error
    end
  end

  def decode(_), do: :error

  @doc """
  Converts a grid square into a coordinate pair.

  Raises `ArgumentError` if the grid is invalid.
  """
  @spec decode!(String.t()) :: coord | no_return
  def decode!(grid) do
    case decode(grid) do
      {:ok, coord} -> coord
      :error -> raise ArgumentError, "Invalid grid #{inspect(grid)}"
    end
  end

  @doc """
  Converts a grid square into the boundaries of its enclosing rectangle.

  Returns `:error` if the grid is invalid.
  """
  @spec decode_bounds(String.t()) :: {:ok, coord_bounds} | :error
  def decode_bounds(grid) do
    with {:ok, {lat, lon}} <- decode(grid) do
      {lat_offset, lon_offset} =
        if String.length(grid) == 4,
          do: {0.5, 1.0},
          else: {0.05, 0.1}

      {:ok,
       {
         {lat - lat_offset, lat + lat_offset},
         {lon - lon_offset, lon + lon_offset}
       }}
    end
  end

  @doc """
  Converts a grid square into the boundaries of its enclosing rectangle.

  Raises `ArgumentError` if the grid is invalid.
  """
  @spec decode_bounds!(String.t()) :: coord_bounds | no_return
  def decode_bounds!(grid) do
    case decode_bounds(grid) do
      {:ok, bounds} -> bounds
      :error -> raise ArgumentError, "Invalid grid #{inspect(grid)}"
    end
  end

  @doc """
  Determines if a grid square is legit.
  """
  @spec valid?(String.t()) :: boolean
  def valid?(grid) do
    Regex.match?(@regex, grid)
  end

  @doc """
  Normalizes the string casing of a grid square.

      iex> HamRadio.Grid.format("fn32ab")
      "FN32ab"
  """
  @spec format(String.t()) :: String.t()
  def format(grid) do
    {a, b} = String.split_at(grid, 2)
    String.upcase(a) <> b
  end

  # PRIVATE

  defp decode_valid!(grid) do
    lon = -180.0
    lat = -90.0

    lon_ord_1 =
      Enum.find_index(@alphabet, fn letter -> String.upcase(String.at(grid, 0)) == letter end)

    lat_ord_1 =
      Enum.find_index(@alphabet, fn letter -> String.upcase(String.at(grid, 1)) == letter end)

    lon_ord_2 = grid |> String.at(2) |> String.to_integer()
    lat_ord_2 = grid |> String.at(3) |> String.to_integer()

    lon = lon + 360.0 / 18.0 * lon_ord_1 + 360.0 / 18.0 / 10.0 * lon_ord_2
    lat = lat + 180.0 / 18.0 * lat_ord_1 + 180.0 / 18.0 / 10.0 * lat_ord_2

    case String.length(grid) do
      4 ->
        lon = lon + 360.0 / 18.0 / 10.0 / 2.0
        lat = lat + 180.0 / 18.0 / 10.0 / 2.0

        {lat, lon}

      6 ->
        lon_ord_3 =
          Enum.find_index(@alphabet, fn letter -> String.upcase(String.at(grid, 4)) == letter end)

        lat_ord_3 =
          Enum.find_index(@alphabet, fn letter -> String.upcase(String.at(grid, 5)) == letter end)

        lon = lon + 360.0 / 18.0 / 10.0 / 24.0 * (lon_ord_3 + 0.5)
        lat = lat + 180.0 / 18.0 / 10.0 / 24.0 * (lat_ord_3 + 0.5)

        {lat, lon}

      _ ->
        raise "Invalid grid passed validation check: '#{grid}'"
    end
  end
end
