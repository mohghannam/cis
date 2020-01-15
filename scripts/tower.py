#!/usr/bin/python
#

""" 
this script is created to update the invetory and credentials of Redhat Ansible tower.
this script shouldn't be edited without informing its owner 
Moustafa youssef contact: 
moustafayoussef759@gmail.com
moustafa.youssef@linux-plus.com

"""
import httplib2
import base64
import json
import time
import sys
import argparse

#############################################
##############getting a token################
#############################################
params = {
            "username" : "admin", "password" : "password"
           }

new_url='https://172.16.202.148/api/v1/authtoken/'
headers=({'Accept':'application/json','Content-Type':'application/json' })
conn_2=httplib2.Http( disable_ssl_certificate_validation=True)
resp_2, content_2 = conn_2.request(new_url,'POST',json.dumps(params),headers)
result = json.loads(content_2)
token=result['token']


params = {
            "credential_type": 1,
            "organization": 1,
            "name": "Second Best Credential Ever",
            "kind": "ssh",
            "username": "root",
            "password": "iti"
         }
#'Authorization':"Basic %s" % en_cred
headers=({'Authorization': "Bearer %s" % token,'Accept':'application/json','Content-Type':'application/json' })
new_url='https://172.16.202.148/api/v2/credentials/'
resp_2, content_2 = conn_2.request(new_url,'POST',json.dumps(params),headers)
result = json.loads(content_2)
print ("###########")
print result

