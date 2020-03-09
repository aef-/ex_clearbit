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

defmodule ExClearbit.Model.NameToDomain do
  @moduledoc """
    The struct for the NameToDomain data returned from Clearbit
  """
  @derive [Poison.Encoder]
  defstruct [
    :domain,
    :logo,
    :name
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

defmodule ExClearbit.Model.Prospector.Person do
  @moduledoc """
  Struct for each Prospect person result from Clearbit
  """
  @derive [Poison.Encoder]
  defstruct [
    :id,
    :name,
    :title,
    :role,
    :sub_role,
    :seniority,
    :company,
    :email,
    :verified,
    :phone,
  ]

  @type t :: %__MODULE__{}
  use ExConstructor
end

defmodule ExClearbit.Model.Prospector.Results do
  @moduledoc """
  Struct for containing list of prospect results from Clearbit
  """
  @derive [Poison.Encoder]
  defstruct [
    :page,
    :page_size,
    :total,
    :results,
  ]

  @type t :: %__MODULE__{
    page: non_neg_integer,
    page_size: non_neg_integer,
    total: non_neg_integer,
    results: list(ExClearbit.Model.Prospector.Person.t)
  }
  use ExConstructor
end

defmodule ExClearbit.Model.Reveal do
  @moduledoc """
  Struct for company retrieved by the Reveal API
  """
  @derive [Poison.Encoder]
  defstruct [
    :ip,
    :fuzzy,
    :domain,
    :type,
    :company,
    :geo_ip,
  ]

  @type t :: %__MODULE__{
    ip: binary,
    fuzzy: boolean,
    domain: binary | nil,
    type: binary,
    geo_ip: map,
    company: ExClearbit.Model.Company.t | nil,
  }
  use ExConstructor
end
