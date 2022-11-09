#!/usr/bin/env python3
"""Configure 7 days to die server configuration with environment variables"""

from os         import environ
from xmltodict  import (
        parse   as xml_parse ,
        unparse as xml_unparse
        )

SERVER_PATH="/root/Steam/steamapps/common/7 Days to Die Dedicated Server"
CONFIG_FILE="serverconfig.xml"

if __name__ == "__main__":
    # Load the config and parse xml
    config_path = f"{SERVER_PATH}/{CONFIG_FILE}"
    with open( config_path , "r" ) as config_file:
        config = xml_parse(
            config_file.read()
            )
    server_settings = config[ "ServerSettings" ][ "property" ]

    # Replace attribute if mathced in environ
    for num , setting in enumerate( server_settings ):
        setting_name = setting.get( "@name" )
        setting_value = environ.get( setting_name )
        if setting_value is not None:
            print( f"Server Config: Setting {setting_name} to {setting_value}" )
            server_settings[ num ] = {
                "@name": setting_name,
                "@value": setting_value,
                }

    # unparse config and save
    config = xml_unparse( config , pretty = True )
    with open( config_path , "w" ) as config_file:
        config_file.write( config )