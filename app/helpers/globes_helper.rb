module GlobesHelper
  def create_localhost_entry(reference)
    # How do we do this for non-Windows environments?
    file = File.open("C:/Windows/System32/drivers/etc/hosts","a+")
    file << "
127.0.0.1                   " + reference + ".lvh.me"
  end
end
