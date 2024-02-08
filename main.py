import os
import json
import sys
import time

from function import 查询版本
from function import 选择文件
from function import 覆盖解压
#预设
if not os.path.exists("config.json"):
    config = {"path":""}
    path = 选择文件()
    if path == "":
        sys.exit()
    else:
        with open("config.json", "w+", encoding="UTF-8") as f:
            config["path"] = path
            json.dump(config, f)
            f.seek(0)
            json.dump(config,f)
else:
    with open("config.json", "r+", encoding="UTF-8") as f:
        path = json.load(f)["path"]
print("正在查找转服包")
if os.path.exists(f".\\f\\[{查询版本()}]原神国服转国际服.zip"):
    if os.path.exists(fr"{path}\GenshinImpact_Data"):
        print("当前为国际服")
        mode = "1"
    else:
        print("当前为国服")
        mode = "2"
    print("找到转服包")
    print("国际服转国服id=1\n"
          "国服转国际服id=2")
    input(f"防误触，回车继续,当前id为{mode}")
    if mode == "1":
        os.rename(fr"{path}\GenshinImpact_Data",fr"{path}\YuanShen_Data")
        os.remove(os.path.join(path,"GenshinImpact.exe"))
        覆盖解压(f".\\f\\[{查询版本()}]原神国际服转国服.zip",path,mode)
        print("转服成功！enjoy!")
        time.sleep(5)
        sys.exit()
    elif mode == "2":
        os.rename(fr"{path}\YuanShen_Data",fr"{path}\GenshinImpact_Data")
        os.remove(os.path.join(path, "YuanShen.exe"))
        覆盖解压(f".\\f\\[{查询版本()}]原神国服转国际服.zip", path, mode)
        print("转服成功！enjoy!")
        time.sleep(5)
        sys.exit()
#未找到
if not os.path.exists(fr".\f\[v0.2.0]NIzip_Maker.bat"):
    print("未找到[v0.2.0]NIzip Maker.bat（转服包制作器），请自行到https://www.bilibili.com/read/cv21924484/?from=search&spm_id_from=333.337.0.0，进行下载\n"
          "并且将[v0.2.0]NIzip Maker.bat放入本程序文件夹中\n"
          "如果已经下载并放入本程序目录下名为[f]文件夹中，请检查文件名是否为[v0.2.0]NIzip_Maker.bat\n"
          "若不是，请将[v0.2.0]NIzip Maker.bat改名为[v0.2.0]NIzip_Maker.bat\n"
          "并重新运行本程序")
    time.sleep(5)
    input("回车结束程序")
    sys.exit()
else:
    print("未找到转服包\n"
          "正在尝试制作转服包\n"
          "将会打开[v0.2.0]NIzip Maker，请等待")
    os.system(fr"cd {os.getcwd()}\f&&[v0.2.0]NIzip_Maker.bat")
    # print(rf"cd {os.getcwd()}\f")

    print("请在制作完成后重新打开本程序")
    input("回车关闭程序")
    sys.exit()


