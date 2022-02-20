I/O流
1. 分类
    a.按流向
        输入流
        输出流
    b.按数据传输单位分
        字节流 Reader Writer
        字符流 InputStream OutputStream
2. ile
```
        File file=new File("a.txt");
        //1.创建文件
        file.createNewFile();
        //2.创建目录
        file.mkdir();
        //3.判断文件是否存在
        System.out.println(file.exists());
        //4.判断是否是文件
        System.out.println(file.isFile());
        //5.判断是否是目录
        System.out.println(file.isDirectory());
        //6.返回目录下所有内容
        System.out.println(Arrays.toString(file.list()));
        //7.获取文件绝对路径
        System.out.println(file.getAbsoluteFile());
        //8.删除文件
        file.delete();
        //9.重命名
        file.renameTo(new File("a.txt"));
```
3. 字节输入流
```
        File file=new File("a.txt");
        //字节输入流FileInputStream
        FileInputStream fis=null;
        try {
            fis=new FileInputStream(file);
            //1.获取文件长度
            fis.available();
            //2.读取文件并返回读取到的位置，读取结束返回-1
            fis.read();
            //3.读文件
            byte[] buffer=new byte[1024];
            int len=fis.read(buffer);
            while(len != -1){
                System.out.println(buffer.toString());
                len=fis.read(buffer);
            }
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            try{
                fis.close();
            } catch (Exception e){
                e.printStackTrace();
            }
        }
```
4. 字符输入流
```
        File file=new File("a.txt");
        //字符输入流FileReader
        FileReader fr=null;
        try {
            //读文件
            char[] buffer=new char[1024];
            int len=fr.read(buffer);
            while(len != -1){
                System.out.println(buffer.toString());
                len=fr.read(buffer);
            }
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            try{
                fr.close();
            } catch (Exception e){
                e.printStackTrace();
            }
        }
```
5. 字节输出流
```
        //字节输出流
        String s="hello java!";
        FileOutputStream fos=null;
        try{
            fos=new FileOutputStream("a.txt",true);//默认覆盖写入
            byte[] buffer=s.getBytes();
            fos.write(buffer,0,buffer.length);
            //清空缓冲数据，并强制写入
            fos.flush();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            fos.close();
        }
```
6. 字符输出流
```
        //字符输出流
        String s="hello java!";
        FileWriter fw=null;
        try{
            fw=new FileWriter("a.txt",true);//默认覆盖写入
            fw.write(s,0,s.length());
            //清空缓冲数据，并强制写入
            fw.flush();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            fw.close();
        }
```
7. 缓冲流
```
        //缓冲流
        File file=new File("a.txt");
        BufferedReader br=null;
        BufferedWriter bw=null;
        try{
            br=new BufferedReader(new FileReader(file));
            bw=new BufferedWriter(new FileWriter("b.txt"));
            //逐行读取
            String str=br.readLine();
            while(str!=null){
                bw.write(str);
                bw.write("/n");
                bw.flush();
                str=br.readLine();
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            br.close();
            bw.close();
        }
```
8. 打印流
```
        //1.打印到控制台
        String s="hello java!";
        PrintWriter pw=new PrintWriter(System.out);
        pw.println(s);
        pw.close();
        //2.打印到文件
            PrintWriter pw2=null;
        try {
            pw2=new PrintWriter(new FileWriter("a.txt",true));
            pw2.write(s);
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            pw.close();
        }
```
9. 对象输入、输出流
    需要实现Serializable接口即序列化
    ```
            //ObjectOutputStream对象流
            Student student=new Student();
            ArrayList<Student> arrayList = new ArrayList<Student>();
            arrayList.add(student);
            ObjectOutput objectOutput=null;
            try {
                objectOutput=new ObjectOutputStream(new FileOutputStream("a.txt"));
                objectOutput.writeObject(arrayList);
                objectOutput.flush();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    objectOutput.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            ObjectInput objectInput=null;
            try {
                objectInput=new ObjectInputStream(new FileInputStream("a.txt"));
                ArrayList<Student> arrayList1=(ArrayList<Student>) objectInput.readObject();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    objectInput.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
    ```
10. StringBuilder和String
    1. StringBuilder线程不安全
        1. appden 连接任意类型数据
        2. reverse 反转
    2. toString可以转换成String