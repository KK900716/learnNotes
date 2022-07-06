## ***添加鼠标右键新建项***

对应单击**桌面空白处**，新建菜单中的项目对应注册表中的位置 ：

```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Discardable\PostSetup\ShellNew
```

## ***鼠标单击桌面***

**桌面空白处**点击右键菜单对应注册表位置：

```
HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers
```

## ***右键单击文件***

**鼠标右键文件**，弹出的菜单项对应注册表中的位置：

```
HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers
```

## ***右键单击文件夹***

**鼠标右键文件夹**，弹出的菜单项对应注册表中的位置：

```
HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers
```