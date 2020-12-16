
# how to hit button then scrape page

from selenium import webdriver
from bs4 import BeautifulSoup
from requests import get

url = "https://www.4devs.com.br/gerador_de_cpf"

def open_browser():
    driver = webdriver.Chrome("/home/felipe/Downloads/chromedriver")
    driver.get(url)
    driver.find_element_by_id('bt_gerar_cpf').click()

def get_cpf():
    response = get(url)

    page_with_cpf = BeautifulSoup(response.text, 'html.parser')

    cpf = page_with_cpf.find("div", {"id": "texto_cpf"}).text

    print("The value is: " + cpf)


open_browser()
get_cpf()