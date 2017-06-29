defmodule ExClearbit.Model.Person do
  @moduledoc """
    The struct for the Person data returned from Clearbit
  """
  @derive [Poison.Encoder]
  defstruct [
    :aboutme,
    :angellist,
    :avatar,
    :bio,
    :email_provider,
    :employment,
    :facebook,
    :fuzzy,
    :gender,
    :geo,
    :github,
    :googleplus,
    :gravatar,
    :id,
    :indexed_at,
    :linkedin,
    :location,
    :name,
    :site,
    :time_zone,
    :twitter,
    :utc_offset
  ]

  @type t :: %__MODULE__{}
  use ExConstructor
end

defmodule ExClearbit.Model.Company do
  @moduledoc """
  The struct for the Company data returned from Clearbit
  """
  @derive [Poison.Encoder]
  defstruct [
    :angel_list,
    :category,
    :crunchbase,
    :description,
    :domain,
    :domain_aliases,
    :email_provider,
    :facebook,
    :founded_year,
    :geo,
    :id,
    :indexed_at,
    :legal_name,
    :linkedin,
    :location,
    :logo,
    :metrics,
    :name,
    :phone,
    :site,
    :tags,
    :tech,
    :time_zone,
    :twitter,
    :type,
    :utc_offset
 ]

  @type t :: %__MODULE__{}
  use ExConstructor
end
