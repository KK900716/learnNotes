1. PyTorch是什么
    1. 使用GPU进行矩阵运算的框架
    2. 其他的深度学习框架
        1. TensorFlow 定义偏多 debug时不方便
        2. Keras 封装了TensorFlow
        3. caffe 更新频率偏低等
    3. 安装可以直接在官网查看安装方法，最好装GPU版本
2. 自动求导机制
    1. 指定参数时指定requires_grad=True，即可求导