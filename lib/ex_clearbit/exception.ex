defmodule ExClearbit.Error do
  defexception [:code, :message]
end

defmodule ExClearbit.ConnectionError do
  defexception [:reason, message: "connection error"]
end
