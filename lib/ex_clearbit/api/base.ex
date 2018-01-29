defmodule ExClearbit.API.Base do
  @moduledoc """
  Basic functionality for Clearbit API
  """
  alias ExClearbit.Config

  @user_agent "Clearbit Elixir Client/#{ExClearbit.version}"

  @doc """
  Makes a GET request to the Clearbit API
  """
  def get(path \\ "", headers \\ [], params \\ [], options \\ []) do
    options = options ++ [params: params]
    :get |> request(path, "", headers, options) |> Map.get(:body)
  end


  @doc """
  Makes a generic request to the Clearbit API
  """
  def request(method, path, body \\ "", headers \\ [], options \\ []) do
    headers = Keyword.merge(default_headers(), headers)
    case Config.get_tuples |> verify_params do
      {:error, message} ->
        {:error, message}
      config ->
        options =
          Keyword.merge(config, options) ++ [hackney: [basic_auth: {config[:api_key], nil}]]
        ExClearbit.request!(method, path, body, headers, options)
    end
  end


  defp default_headers do
    ["Accept": "application/json", "Content-Type": "application/json", "User-Agent": @user_agent]
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
end
