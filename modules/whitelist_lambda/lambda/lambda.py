import requests as rq
import os

def handler(event, context):
    url = 'https://prod.gocd.patient-deductions.nhs.uk/go/api/pipelines/prm-deductions-whitelist/schedule'
    if 'AUTHORIZATION_TOKEN' in os.environ:
        token =  os.environ['AUTHORIZATION_TOKEN']
    else:
        token = event['AUTHORIZATION_TOKEN']

    headers = {
        'Authorization': 'bearer ' + token,
        'Accept': 'application/vnd.go.cd.v1+json',
        'Content-Type': 'application/json'
    }

    res = rq.post(url, headers=headers, json={})
    print(res)
    assert res.status_code == 202
