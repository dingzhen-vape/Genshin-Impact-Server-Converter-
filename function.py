# 导入requests库和BeautifulSoup库
import os
import zipfile

import requests
from bs4 import BeautifulSoup
import tkinter as tk
from tkinter import filedialog

from tqdm import tqdm


def 查询版本():
    url = "https://ys.mihoyo.com/main/"
    response = requests.get(url)
    soup = BeautifulSoup(response.text, "html.parser")
    title = soup.title.string
    位置 = title.index(".")
    return title[位置-1:位置+2]
def 选择文件():
    root = tk.Tk()
    root.withdraw()
    # 打开文件选择框，并获取所选文件的路径
    file_path = filedialog.askdirectory(title="选择原神本体所在目录")
    return file_path
def 覆盖解压(zippath,OutPutPath,mode):
    replacelist = []
    with zipfile.ZipFile(f'{zippath}', 'r') as zipp:
        # 遍历 zip 中的每个文件
        if mode == "1":
            zipp.extract("YuanShen.exe", OutPutPath)
        elif mode == "2":
            zipp.extract("GenshinImpact.exe", OutPutPath)
        for file in tqdm(zipp.namelist()):
            namepos = file.rfind("/")

            name = file[namepos+1:len(file)+1]
            # 获取文件的完整路径
            for root, dirs, files in os.walk(OutPutPath):
                for j in files:
                    if name == j:
                        file_path = os.path.join(root, name)
                        zipp.extract(file, OutPutPath)
                            # 从 zip 中提取文件到指定路径
