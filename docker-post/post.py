import wykop
import os

if __name__ == "__main__":
  appkey = os.environ['APPKEY']
  secret = os.environ['SECRET']
  account_key = os.environ['ACCOUNT_KEY']

  with open("/results/combined.png", "rb") as statsImage:
    with open("/results/resultText.txt", "r") as resultTextFile:
      body = resultTextFile.read()
      api = wykop.WykopAPI(appkey, secret)
      api.authenticate(account_key)
      result = api.entry_add(body, file=statsImage)
      print(result)
