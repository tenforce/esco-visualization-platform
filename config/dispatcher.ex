defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch
	match "/sessions/*path" do
		Proxy.forward conn, path, "http://login/sessions/"
	end

  match "/concepts/*path" do
    Proxy.forward conn, path, "http://resource/concepts/"
  end

  match "/mappings/*path" do
    Proxy.forward conn, path, "http://resource/mappings/"
  end

  match "/suggestions/*path" do
    Proxy.forward conn, path, "http://resource/suggestions/"
  end

  match "/taxonomies/*path" do
    Proxy.forward conn, path, "http://resource/taxonomies/"
  end

  match "/concept-schemes/*path" do
    Proxy.forward conn, path, "http://resource/concept-schemes/"
  end

  match "/segments/*path" do
    Proxy.forward conn, path, "http://resource/segments/"
  end

  match "/hierarchies/*path" do
    Proxy.forward conn, path, "http://resource/hierarchies/"
  end

  match "/hierarchy/*path" do
    Proxy.forward conn, path, "http://hierarchyapi/hierarchies/"
  end

  match "/concept-relations/*path" do
    Proxy.forward conn, path, "http://resource/concept-relations/"
  end

  match "/concept-labels/*path" do
      Proxy.forward conn, path, "http://resource/concept-labels/"
  end

  match "/mapping-efforts/*path" do
      Proxy.forward conn, path, "http://resource/mapping-efforts/"
  end

  match "/accounts/*path" do
    Proxy.forward conn, path, "http://resource/accounts/"
  end

  match "/users/*path" do
    Proxy.forward conn, path, "http://resource/users/"
  end

  match "/pdf*path" do
    Proxy.forward conn, path, "http://html2pdf:8080/"
  end
  match "/indexer/*path" do
    Proxy.forward conn, path, "http://indexer:8080/indexer/"
  end
  match "/clear-cache-requests/*path" do
    Proxy.forward conn, path, "http://resource/clear-cache-requests/"
  end
  match "/cache/*path" do
    Proxy.forward conn, path, "http://resource/"
  end

end
