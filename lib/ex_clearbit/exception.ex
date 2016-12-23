defmodule ExClearbit.Error do
  @moduledoc """
  Generic error thrown by the application
  """
  defexception [:code, :message]
end
