defmodule ExClearbit.Config do
  def current_scope do
     if Process.get(:_ex_clearbit_config, nil), do: :process, else: :global
   end
  @doc """
    Set config values
  """
  def set(value), do: set(current_scope(), value)
  def set(:global, value), do: Application.put_env(:ex_clearbit, :config, value)
  def set(:process, value) do
    Process.put(:_ex_clearbit_config, value)
    :ok
  end

  def set_option(key, value) do
    get() |> Keyword.put(key, value) |> set
  end

  @doc """
    Get config map
  """
  def get, do: get(current_scope())
  def get(:global) do
    Application.get_env(:ex_clearbit, :config, %{})
  end

  def get(:process) do
    Process.get(:_ex_clearbit_config, %{})
  end

  def retrieve(key, default \\ nil, scope \\ current_scope()) do
    scope
    |> get
    |> Keyword.get(key, default)
  end

  def get_tuples do
    case ExClearbit.Config.get do
      nil -> []
      tuples -> tuples |> Enum.map(fn {k,v} -> {k, to_string(v)} end)
    end
  end
end
