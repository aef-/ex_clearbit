defmodule ExClearbit do
  @moduledoc """
  The base module for ExClearbit
  """
  use Application
  use HTTPoison.Base
  alias ExClearbit.Model.{Person, Company}
  @version Mix.Project.config[:version]
  def version, do: @version

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    children = [
      # Starts a worker by calling: ExClearbit.Worker.start_link(arg1, arg2, arg3)
      # worker(ExClearbit.Worker, [arg1, arg2, arg3]),
    ]
    opts = [strategy: :one_for_one, name: ExClearbit.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def process_response_body(body) do
    body |> Poison.decode!
  end

  @doc """
  Query the Clearbit Person API by email
  """
  @spec person(String.t, Keyword.t) :: Person.t
  def person(email, params \\ []) do
    url = "https://person.clearbit.com/v2/people/find"
    params = [email: email] ++ params
    response = ExClearbit.API.Base.get(url, [], params)
    if Map.has_key?(response, "error") do
      message = response["error"]["message"]
      type = response["error"]["type"] |> String.to_atom
      {:error, %{code: type, message: message}}
    else
      response |> Person.new
    end
  end

  @doc """
  Query the Clearbit Company API by domain
  """
  @spec company(String.t, Keyword.t) :: Company.t
  def company(domain, params \\ []) do
    url = "https://company.clearbit.com/v2/companies/find"
    params = [domain: domain] ++ params
    response = ExClearbit.API.Base.get(url, [], params)
    if Map.has_key?(response, "error") do
      message = response["error"]["message"]
      type = response["error"]["type"] |> String.to_atom
      {:error, %{code: type, message: message}}
    else
      response |> Company.new
    end
  end

  @doc """
  Query the Clearbit Combined API by email
  """
  def combined(email, params \\ []) do
    url = "https://person.clearbit.com/v2/combined/find"
    params = [email: email] ++ params
    response = ExClearbit.API.Base.get(url, [], params)
    if Map.has_key?(response, "error") do
      message = response["error"]["message"]
      type = response["error"]["type"] |> String.to_atom
      {:error, %{code: type, message: message}}
    else
      person = response["person"] |> Person.new
      company = response["company"] |> Company.new
      %{person: person, company: company}
    end
  end

  @doc """
  Set ExClearbit configuration settings. This configuration will be applied gobally
  """
  defdelegate configure(config), to: ExClearbit.Config, as: :set

  @doc """
  Set ExClearbit configuration settings. This configure will only be applied
  for each individual process
  """
  defdelegate configure(scope, config), to: ExClearbit.Config, as: :set

  @doc """
  Retrieve current configuration values for ExClearbit
  """
  defdelegate configuration, to: ExClearbit.Config, as: :get

  @doc """
  Set a specific option manually in the ExClearbit configuration settings
  """
  defdelegate set_option(key, value), to: ExClearbit.Config
end
