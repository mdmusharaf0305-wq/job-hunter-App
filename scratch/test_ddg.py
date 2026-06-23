import urllib.request
from urllib.parse import quote

def test():
    query = "React Developer jobs in Bangalore site:naukri.com"
    url = f'https://html.duckduckgo.com/html/?q={quote(query)}'
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36'})
    try:
        with urllib.request.urlopen(req) as response:
            body = response.read().decode('utf-8')
            with open('scratch/ddg_body.html', 'w', encoding='utf-8') as f:
                f.write(body)
            print("Wrote body to scratch/ddg_body.html. Length:", len(body))
    except Exception as e:
        print("Error:", e)

if __name__ == '__main__':
    test()
