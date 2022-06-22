defmodule ExClearbit.API.Base do
  @moduledoc """
  Basic functionality for Clearbit API
  """
  alias ExClearbit.Config

  @user_agent "Clearbit Elixir Client/#{ExClearbit.version()}"
  @default_headers [
    Accept: "application/json",
    "Content-Type": "application/json",
    "User-Agent": @user_agent
  ]

  @doc """
  Makes a GET request to the Clearbit API
  """
  def get(path \\ "", headers \\ [], params \\ [], options \\ []) do
    options = options ++ [params: params]

    with {:ok, response} <- request(:get, path, "", headers, options),
         {:ok, body} <- Map.fetch(response, :body),
         :ok <- handle_errors(body) do
      {:ok, body}
    end
  end

  @doc """
  Makes a generic request to the Clearbit API
  """
  def request(method, path, body \\ "", headers \\ [], options \\ []) do
    headers = Keyword.merge(@default_headers, headers)

    Config.get_tuples()
    |> verify_params()
    |> case do
      {:error, message} ->
        {:error, message}

      config ->
        options =
          config
          |> Keyword.merge(options)
          |> Keyword.merge(hackney: [basic_auth: {config[:api_key], nil}])

        ExClearbit.request(method, path, body, headers, options)
    end
  end

  @doc """
  Ensures that the API Key is set (or at least that the parameter list isn't empty)
  """
  def verify_params([%{api_key: _}]) do
    raise ExClearbit.Error,
      code: :no_api_key,
      message: "API Key not set. Call the ExClearbit.configure function to set your api key."
  end

  def verify_params(params), do: params

  # Returns error tuple in case of errors, otherwise returns the response as-is
  defp handle_errors(%{"error" => error}) do
    {:error, %{code: String.to_atom(error["type"]), message: error["message"]}}
  end

  defp handle_errors(%{} = _response), do: :ok
  defp handle_errors([_ | _] = _response), do: :ok
  defp handle_errors([] = _response), do: :ok
end
