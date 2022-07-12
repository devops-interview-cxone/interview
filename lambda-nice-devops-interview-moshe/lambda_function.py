import base64
import requests

def get_string_from_github_file(event=None, context=None):
        
    url = 'https://api.github.com/repos/MosheGabayDev/NICE/contents/parse_me.txt'
    req = requests.get(url)
    if req.status_code == requests.codes.ok:
        req = req.json()
        string = base64.decodebytes(bytes(req['content'], encoding='utf-8')).decode("utf-8").replace("00", " ")
        return string
    else:
        print('Content was not found.')

