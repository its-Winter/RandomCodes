import json

with open('settings.json', 'r') as datab:
      jsonsettings = json.load(datab)

class settings:
      token = jsonsettings['token']
      prefix = jsonsettings['prefix']
      ownerid = jsonsettings['ownerid']
