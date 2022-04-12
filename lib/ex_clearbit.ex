defmodule ExClearbit do
  use Application
  use HTTPoison.Base

  alias ExClearbit.Model.{Person, Company, NameToDomain, Prospector, Reveal}
  alias ExClearbit.API

  @moduledoc """
  The main module for ExClearbit
  """

  @type error :: {:error, %{code: atom, message: String.t}}


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
    Poison.decode!(body)
  end


  @doc """
  Query the Clearbit Person API by email
  """
  @url "https://person.clearbit.com/v2/people/find"
  @spec person(String.t, Keyword.t) :: {:ok, Person.t} | error
  def person(email, params \\ []) do
    params = [email: email] ++ params

    with {:ok, response} <- API.Base.get(@url, [], params) do
      {:ok, Person.new(response)}
    end
  end


  @doc """
  Query the Clearbit Company API by domain
  """
  @url "https://company.clearbit.com/v2/companies/find"
  @spec company(String.t, Keyword.t) :: {:ok, Company.t} | error
  def company(domain, params \\ []) do
    params = [domain: domain] ++ params

    with {:ok, response} <- API.Base.get(@url, [], params) do
      {:ok, Company.new(response)}
    end
  end


  @doc """
  Query the Clearbit NameToDomain API by name
  """
  @url "https://company.clearbit.com/v1/domains/find"
  @spec name_to_domain(String.t, Keyword.t) :: {:ok, NameToDomain.t} | error
  def name_to_domain(name, params \\ []) do
    params = [name: name] ++ params

    with {:ok, response} <- API.Base.get(@url, [], params) do
      {:ok, NameToDomain.new(response)}
    end
  end


  @doc """
  Query the Clearbit Combined API by email
  """
  @url "https://person.clearbit.com/v2/combined/find"
  @spec combined(String.t, Keyword.t) :: {:ok, %{person: Person.t, company: Company.t}} | error
  def combined(email, params \\ []) do
    params = [email: email] ++ params

    with {:ok, response} <- API.Base.get(@url, [], params) do
      person = Person.new(response["person"])
      company = Company.new(response["company"])

      {:ok, %{person: person, company: company}}
    end
  end


  @doc """
  Query the Clearbit Prospector Search API
  """
  @url "https://prospector.clearbit.com/v1/people/search"
  @spec prospector_search(String.t, Keyword.t) :: {:ok, Prospector.Results.t} | error
  def prospector_search(domain, params \\ []) do
    params = [domain: domain] ++ params

    with {:ok, response} <- API.Base.get(@url, [], params) do
      results =
        response
        |> Prospector.Results.new()
        |> Map.update!(:results, &Enum.map(&1, fn p -> Prospector.Person.new(p) end))

      {:ok, results}
    end
  end


  @doc """
  Query the Clearbit Reveal API
  """
  @url "https://reveal.clearbit.com/v1/companies/find"
  @spec reveal_ip(String.t) :: {:ok, Reveal.t} | error
  def reveal_ip(ip_address) do
    with {:ok, response} <- API.Base.get(@url, [], [ip: ip_address]) do
      result =
        response
        |> Map.put_new("geo_ip", response["geoIP"])
        |> Reveal.new()
        |> Map.update!(:company, fn
          nil -> nil
          %{} = map -> Company.new(map)
        end)

      {:ok, result}
    end
  end

  
  @doc """
  Query the Clearbit Autocomplete API by name
  """
  @url "https://autocomplete.clearbit.com/v1/companies/suggest"
  @spec autocomplete(String.t, Keyword.t) :: {:ok, Company.t} | error
  def autocomplete(query, params \\ []) do
    params = [query: query] ++ params

    with {:ok, response} <- API.Base.get(@url, [], params) do
      {:ok, Enum.map(response, &Company.new/1)}
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
