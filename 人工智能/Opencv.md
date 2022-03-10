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
    ```
    import cv2
    import matplotlib.pyplot as plt
    import numpy as np

    vc=cv2.VideoCapture('b.mp4')
    # 检查是否打开正确
    if vc.isOpened():
        open,frame=vc.read()
    else:
        open=False

    while open:
        ret,frame=vc.read()
        if frame is None:
            break
        if ret == True:
            gray =cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)
            cv2.imshow('result',gray)
            if cv2.waitKey(1) & 0xFF == 27:
                break
    vc.release()
    cv2.destroyAllWindows()
    ```
    4. 宽高及填充
    ```
    import cv2
    import matplotlib.pyplot as plt
    import numpy as np
    import Untils.untils as Ut

    img = cv2.imread('a.jpg')
    # 截取高/宽
    cat = img[0:200, 0:200]
    # Ut.cv_show('cat', cat)

    # 颜色通道提取
    # b,g,r=cv2.split(img)
    # # 颜色通道混合
    # img = cv2.merge((b,g,r))
    # cur_img=img.copy()
    # cur_img[:,:,0]=0
    # cur_img[:,:,1]=0
    # Ut.cv_show('R',cur_img)
    # cur_img[:,:,0]=0
    # cur_img[:,:,2]=0
    # # Ut.cv_show('G',cur_img)
    # cur_img[:,:,1]=0
    # cur_img[:,:,2]=0
    # Ut.cv_show('B',cur_img)

    # 边界填充
    top_size,bottom_size,left_size,right_size=(50,50,50,50)
    # 复制法，复制边缘像素
    replicate=cv2.copyMakeBorder(img,top_size,bottom_size,left_size,right_size,borderType=cv2.BORDER_REPLICATE)
    # 反射法
    reflect=cv2.copyMakeBorder(img,top_size,bottom_size,left_size,right_size,borderType=cv2.BORDER_REFLECT)
    # 反射法
    reflect101=cv2.copyMakeBorder(img,top_size,bottom_size,left_size,right_size,borderType=cv2.BORDER_REFLECT_101)
    # 外包装法
    wrap=cv2.copyMakeBorder(img,top_size,bottom_size,left_size,right_size,borderType=cv2.BORDER_WRAP)
    # 常量法
    constant=cv2.copyMakeBorder(img,top_size,bottom_size,left_size,right_size,borderType=cv2.BORDER_CONSTANT)
    plt.subplot(231),plt.imshow(img,'gray'),plt.title('ORIGINAL')
    plt.subplot(232),plt.imshow(replicate,'gray'),plt.title('replicate')
    plt.subplot(233),plt.imshow(reflect,'gray'),plt.title('reflect')
    plt.subplot(234),plt.imshow(reflect101,'gray'),plt.title('reflect101')
    plt.subplot(235),plt.imshow(wrap,'gray'),plt.title('wrap')
    plt.subplot(236),plt.imshow(constant,'gray'),plt.title('constant')
    plt.show()
    ```
    5. 数值计算
    ```
    import cv2
    import matplotlib.pyplot as plt
    import numpy as np
    import Untils.untils as Ut

    # 数值计算
    img = cv2.imread('a.jpg')
    img2 = img + 10
    img3 = img + img
    img4 = cv2.add(img, img)
    Ut.cv_show('img', img4)
    # 图像融合
    # 首先要进行resize保证图像大小相同
    # cv.resize还可以指定(img,(0,0),fx=1,fy=3)
    img5 = cv2.resize(img, (500, 500))
    png = cv2.imread('c.jpg')
    png2 = cv2.resize(png, (500, 500))
    # R=ax1+bx2+c
    res=cv2.addWeighted(img5,0.5,png2,0.5,0)
    Ut.cv_show('img',res)
    ```
    6. 图像阈值
    ```
    import cv2
    import matplotlib.pyplot as plt
    import numpy as np
    import Untils.untils as Ut

    # 图像阈值 ret,dst=cv2.threshold(src,thresh,maxval,type)
    # src：输入图
    # dst：输出图
    # thresh：阈值
    # maxval：当像素超过了阈值（或者小于阈值，根据type来决定），所赋予的值
    # type：二值化操作的类型
    # 超过阈值部分取maxval（最大值），否则取0
    cv2.THRESH_BINARY
    # 上述方法的反转
    cv2.THRESH_BINARY_INV
    # 大于阈值部分设为阈值，否则不变
    cv2.THRESH_TRUNC
    # 大于阈值部分不变，否则置零
    cv2.THRESH_TOZERO
    # 上述方法反转
    cv2.THRESH_TOZERO_INV
    ```
    7. 平滑处理
    ```
    import cv2
    import matplotlib.pyplot as plt
    import numpy as np
    import Untils.untils as Ut

    # 平滑处理
    # 均值滤波
    # 简单平均卷积操作
    img=cv2.imread('a.jpg')
    # Ut.cv_show('img',img)
    blur=cv2.blur(img,(3,3))
    # Ut.cv_show('blur',blur)
    # 方框滤波 第二个参数代表与原图通道数一致,最后一个参数代表归一化，即越界处理False容易越界
    box=cv2.boxFilter(img,-1,(3,3),normalize=False)
    # Ut.cv_show('box',box)
    # 高斯滤波
    aussian=cv2.GaussianBlur(img,(5,5),1)
    # Ut.cv_show('aussian',aussian)
    # 中值滤波 相当于中值替代,如果图片中有噪音点，采用中值滤波较好
    median=cv2.medianBlur(img,5)
    # Ut.cv_show('median',median)
    # 连接图像
    # res=np.vstack()
    res=np.hstack((img,blur,box,aussian,median))
    Ut.cv_show('res',res)
    ```
    7. 形态学-腐蚀操作、膨胀操作（通常二值进行腐蚀操作比较常见）
    ```
    # 腐蚀操作
    img=cv2.imread('a.jpg')
    kernel=np.ones((5,5),np.uint8)
    erosion=cv2.erode(img,kernel,iterations=1)
    # 膨胀操作
    dige_dilate=cv2.dilate(img,kernel,iterations=1)
    res=np.hstack((img,erosion,dige_dilate))
    Ut.cv_show('res',res)
    ```
    8. 开运算和闭运算
    ```
    # 开运算和闭运算
    # 开，先腐蚀后膨胀
    img=cv2.imread('a.jpg')
    kernal=np.ones((5,5),np.uint8)
    opening=cv2.morphologyEx(img,cv2.MORPH_OPEN,kernal)
    # 闭，先膨胀再腐蚀
    closing=cv2.morphologyEx(img,cv2.MORPH_CLOSE,kernal)
    res=np.hstack((img,opening,closing))
    Ut.cv_show('res',res)
    ```
    9. 梯度运算=膨胀-腐蚀
    ```
    # 梯度计算
    # 先进行5次腐蚀和膨胀，相减，可以计算出轮廓
    img=cv2.imread('a.jpg')
    kernel=np.ones((7,7),np.uint8)
    dilate=cv2.dilate(img,kernel,iterations=5)
    erosion=cv2.erode(img,kernel,iterations=5)
    gradient=cv2.morphologyEx(img,cv2.MORPH_GRADIENT,kernel)


    # 礼帽和黑帽
    # 礼帽=原始输入-开运算结果
    tophat=cv2.morphologyEx(img,cv2.MORPH_TOPHAT,kernel)
    # 黑帽=闭运算-原始输入
    blackhat=cv2.morphologyEx(img,cv2.MORPH_BLACKHAT,kernel)
    res=np.hstack((img,dilate,erosion,gradient,tophat,blackhat))
    Ut.cv_show('res',res)
    ```
    10. 图像梯度
        1. Sobel算子
        ```
        # 图像梯度，Sobel算子
        # gx=[-1 0 +1
        #     -2 0 +2
        #     -1 0 +1]*A
        # gy=[-1 -2 -1
        #     0  0  0
        #     +1 +2 +1]*A
        img=cv2.imread('a.jpg',cv2.IMREAD_GRAYSCALE)
        # (图像，深度（通常-1，表示输入输出深度一样,会截断），dx，dy（表示水平或垂直方向），ksize（卷积核大小，通常为3*3）），
        soblex=cv2.Sobel(img,cv2.CV_64F,1,0,ksize=3)
        sobley=cv2.Sobel(img,cv2.CV_64F,0,1,ksize=3)
        # 为了避免截断处理负数取其绝对值
        sobelx=cv2.convertScaleAbs(soblex)
        sobely=cv2.convertScaleAbs(sobley)
        # 一般算出G可以求其和
        sobelxy=cv2.addWeighted(sobelx,0.5,sobely,0.5,0)
        # 不建议dx和dy都设为1
        res=np.hstack((soblex,sobley,sobelxy))
        Ut.cv_show('res',res)
        ```
        2. Scharr算子
        ```
        # 图像梯度，Scharr算子，该算子更敏感
        # gx=[-3 0 +3
        #     -10 0 +10
        #     -3 0 +3]*A
        # gy=[-3 -10 -3
        #     0  0  0
        #     +3 +10 +3]*A
        img=cv2.imread('a.jpg',cv2.IMREAD_GRAYSCALE)
        # (图像，深度（通常-1，表示输入输出深度一样,会截断），dx，dy（表示水平或垂直方向），ksize（卷积核大小，通常为3*3）），
        Scharrx=cv2.Scharr(img, cv2.CV_64F, 1, 0)
        Scharry=cv2.Scharr(img, cv2.CV_64F, 0, 1)
        # 为了避免截断处理负数取其绝对值
        Scharrx=cv2.convertScaleAbs(Scharrx)
        Scharry=cv2.convertScaleAbs(Scharry)
        # 一般算出G可以求其和
        Scharrxy=cv2.addWeighted(Scharrx,0.5,Scharry,0.5,0)
        # 不建议dx和dy都设为1



        # laplacian算子
        # G=[0 1 0
        #   1 -4 1
        #   0 1 0]
        # 对变化更敏感，但对噪音点也更敏感，原理是二阶导
        laplacian=cv2.Laplacian(img,cv2.CV_64F)
        laplacian=cv2.convertScaleAbs(laplacian)
        res=np.hstack((Scharrx,Scharry,Scharrxy,laplacian))
        Ut.cv_show('res',res)
        ```
        3. Canny边缘检测算法
        