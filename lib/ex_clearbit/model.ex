defmodule ExClearbit.Model.Person do
  @moduledoc """
    The struct for the Person data returned from Clearbit
  """
  @derive [Poison.Encoder]
  defstruct [:id, :name, :gender, :location, :time_zone, :utc_offset, :geo, :bio, :site, :avatar,
             :employment, :github, :facebook, :twitter, :linkedin, :googleplus, :angellist,
             :aboutme, :gravatar, :fuzzy]

  @type t :: %__MODULE__{}
  use ExConstructor
end

defmodule ExClearbit.Model.Company do
  @moduledoc """
  The struct for the Company data returned from Clearbit
  """
  @derive [Poison.Encoder]
  defstruct [:id, :name, :legal_name, :domain, :domain_aliases, :site, :tags, :category, :category,
             :description, :founded_year, :location, :time_zone, :utc_offset, :geo, :metrics,
             :facebook, :twitter, :angel_list, :crunchbase, :logo, :email_provider, :type,
             :phone, :tech, :indexedAt]

  @type t :: %__MODULE__{}
  use ExConstructor
end
