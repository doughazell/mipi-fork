# 31/7/13 DH: Necessary to load the Engine Yard allocated IP address, as staging to correcting an invalid subdomain.
EY_CONFIG = YAML.load_file("#{Rails.root}/config/ey.yml")[Rails.env]