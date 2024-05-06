#!py

import random
import string

def run():
    command_dict = {}
    for num in range(0,101):

        # Create resources
        random_string = ''.join(random.choices(string.ascii_lowercase + string.digits, k=8192))

        command_dict[f"file_{num}"] = {
            "file.managed": [{
                "name": f"/tmp/filez/{ num }",
                "contents": random_string,
            }]
        }

        if grains['os'] == "Windows":
            command_dict[f"file_{num}"]["file.managed"][0]["name"] = f"C:\\{num}"

            command_dict[f"reg_key_{num}"] = {
                "reg.present": [{
                    "name": f"HKEY_CURRENT_USER\\SOFTWARE\\Salt\\{ num }",
                    "vdata": random_string,
                    "vname": num,
                }]
            }

        # Destroy resources
        command_dict[f"file_{num}"] = {
            "file.absent": [{
                "name": f"/tmp/filez/{ num }",
            }]
        }

        if grains['os'] == "Windows":
            command_dict[f"file_{num}"]["file.managed"][0]["name"] = f"C:\\{num}"

            command_dict[f"reg_key_{num}"] = {
                "reg.absent": [{
                    "name": f"HKEY_CURRENT_USER\\SOFTWARE\\Salt\\{ num }",
                    "vname": num,
                }]
            }


    return command_dict
