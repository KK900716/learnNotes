1. 导入Opencv-python、Opencv-contrib-python（要确定版本号一致）
2. 简介

3. 图像基本操作
    1. 位图由像素组成，彩色图像由RGB三个颜色通道构成，灰度图像是单通道构成
    2. 读入图像像素矩阵
    ```
    # opencv读取格式是BGR
    import cv2
    import matplotlib.pyplot as plt
    import numpy as np

    # 读图像
    img = cv2.imread('a.jpg')
    # 三个纬度[h,w,c]
    print(img)
    # 显示图像
    cv2.imshow('image', img)
    # 等待时间，毫秒级，0表示任意键终止
    cv2.waitKey(0)
    cv2.destroyAllWindows()
    # 图像信息
    print(img.shape)


    # 封装上述过程
    def cv_show(name, img):
        cv2.imshow(name, img)
        cv2.waitKey(0)
        cv2.destroyAllWindows()


    # 读取灰度图
    img2=cv2.imread('a.jpg', cv2.IMREAD_GRAYSCALE)
    cv_show('image2',img2)
    # 两个维度
    # 图像保存
    cv2.imwrite('my-cat.png',img2)
    # 图像大小（像素点个数）
    print(img2.size)
    # 图像类型
    print(img2.dtype)
    ```
    3. 读入视频
    