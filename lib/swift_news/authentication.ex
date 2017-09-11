defmodule SwiftNews.Authentication do
    alias Comeonin.Bcrypt
    
    def hash_password(cleartext_password) do
        Bcrypt.hashpwsalt(cleartext_password)
    end
end