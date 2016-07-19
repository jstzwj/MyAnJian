[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=0
EnableWindow=
MacroID=f43755de-2073-43e4-95d8-8ec1e3cb2869
Description=智能射击
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
DimEnv OldColor
DimEnv OldEdgeColor
//以下为常量设定
//小地图
DimEnv lmapltx
DimEnv lmaprbx
DimEnv lmaplty
DimEnv lmaprby
DimEnv lmapcenterx
DimEnv lmapcentery
//view
DimEnv viewltx
DimEnv viewlty
DimEnv viewrbx
DimEnv viewrby
//颜色
DimEnv squareColor
DimEnv ourColor
DimEnv yourColor
DimEnv lmapyourColor
//分辨率
DimEnv srcx
DimEnv srcy

//导航
DimEnv guideh
DimEnv guidel
DimEnv guider

//获取分辨率
srcx = Plugin.Sys.GetScRX()
srcy = Plugin.Sys.GetScRY()
//分配参数
viewltx = srcx * 250 / 1366
viewlty = srcy * 250 / 768
viewrbx =srcx * 1080 / 1366
viewrby = srcy * 400 / 768

squareColor=""
ourColor="d69d2a"
yourColor="6B84FE"
lmapyourColor="6B84FE"
//1155,63 1300,215
//1118,34 1331,241
lmapltx=srcx *1155/ 1366
lmaprbx=srcx *1300/ 1366
lmaplty=srcy *63/ 768
lmaprby=srcy *215/ 768
lmapcenterx=srcx *1229/ 1366
lmapcentery=srcy *140/ 768
//漫游检测线
guideh=srcy *370/ 768
guidel=srcx *455/ 1366
guider = srcx * 910 / 1366
//线程共享变量
Dimenv myX, myY
Dimenv otherX, otherY
DimEnv squareX,squareY
/*
0 寻找敌人
1 硬扛
2 转着打
3 逃跑
4 追击
5 死亡
6 撞墙
7 受伤
8 结伴
9 站点
10 游戏结束
*/
DimEnv state
state=0

//两点颜色相似度
Function colorsimi(colora, colorb)
	
	ag = CInt(Mid(colora,1,2))
	bg = CInt(Mid(colorb,1,2))
	
	ab = CInt(Mid(colora,3,2))
	bb = CInt(Mid(colorb,3,2))
	
	ar = CInt(Mid(colora,5,2))
	br = CInt(Mid(colorb,5,2))
	
	colorsimi=sqr((ar-br)*(ar-br)+(ag-bg)*(ag-bg)+(ab-bb)*(ab-bb))
End Function

//视野目标寻找函数
Function view(mycolor)
	FindColorEx viewltx, viewlty, viewrbx, viewrby, mycolor, 1, 0.6, intX, intY
	If intX > 0 And intY > 0 Then 
		view=1
	Else 
		view=0
	End If
	
End Function
//自动漫游
Function walk()
	//MessageBox "漫游"
	//第一版本
	/*
	FindColorEx 1277, 658, 1297, 678, OldEdgeColor, 1, 1, intX, intY
	If intX > 0 And intY > 0 Then 
		KeyDown "s", 1
    	Delay 500
    	KeyUp "s", 1
    	
		KeyDown "a", 1
    	Delay 1000
    	KeyUp "a", 1
	Else 
		KeyDown "w", 1
    	Delay 1000
    	KeyUp "w", 1
	End If
	OldEdgeColor = GetPixelColor(1277, 658)
	*/
	walk=WallGuide()
End Function

//跟踪
Function follow(a, b)
	If a>1212 and b<1250 Then
		If b < 140 Then 
			follow="w"
		Else 
			KeyDown "a", 1
			Delay 3000
			KeyUp "a",1
			follow="s"
		End If
    		
    Else 
    	If a < 1229 Then 
    		follow = "a"
    	Else 
    		follow = "d"
    	End If
	End If
End Function

//撞墙导航
Function WallGuide()
	Dim i
	Dim distance
	
	i = 0
	temp=CLng(0)
	For srcx / 300
		temp = colorsimi(GetPixelColor(i, guideh), "99918d") + temp
		i=i+100
	Next
	
	avr1 = temp / srcx * 300
	//MessageBox srcx
	
	temp=0
	For srcx / 300
		temp=colorsimi(GetPixelColor(i,guideh),"99918d")+temp
		i=i+100
	Next
	avr2 = temp / srcx * 300
	temp=0
	For srcx / 300
		temp=colorsimi(GetPixelColor(i,guideh),"99918d")+temp
		i=i+100
	Next
	avr3 = temp / srcx * 300
	
	
	
	If avr2 < avr1 and avr2 < avr3 Then 
		//MessageBox "qianj"
		WallGuide="w"
	ElseIf avr1 < avr3 Then
		//MessageBox "zuo"
		WallGuide="a"
	Else 
		//MessageBox "you"
		WallGuide="d"
	End If
	
End Function



//开启多线程
BeginThread getState
BeginThread handleState
//主函数
While state <> 10
	Delay 10000
Wend


Sub getState
While state <> 10

	//状态检测
	state = 0
	
	
	
	
	
	
	//小地图寻找敌方坦克
	FindColorEx lmapltx,lmaplty,lmaprbx,lmaprby,yourColor,1,0.8,intX,intY
	otherX =intX
	otherY=intY
	If otherX > 0 And otherY > 0 Then 
		state = 4
		//MessageBox "找到敌方坦克"
	End If
	
	
	//寻找队友
	FindColorEx lmapltx, lmaplty, lmaprbx, lmaprby, ourColor, 1, 1, intX, intY
	myX = intX
	myY = intY
	If myX > 0 And myY > 0 and state<>9 and state<>4 Then 
		state = 8
		//MessageBox "找到队友"
	End If
	
	//开炮
	If 1=view(yourColor) Then
		state = 1
		//MessageBox "开火"
	End If
	
	//寻找广场(30)
	FindPic lmapltx+30, lmaplty+30, lmaprbx-30, lmaprby-30, "Attachment:\square.bmp", 0.9, intX,intY
	squareX=intX
	squareY=intY
	If squareX > 0 And squareY > 0 and state<>9 Then 
		state = 9
		//MessageBox "寻找广场"
	End If
	
	//撞墙检测(v1.0)
    FindColorEx 663,364,683,384,OldColor,1,	1,intX,intY
	If intX > 0 And intY > 0 Then 
		state = 6
		//MessageBox "撞墙了"
	End If
	OldColor = GetPixelColor(683, 384)
	
	
	
	//1229,140
	//1232,119
		
	Delay 1000
Wend
MessageBox "脚本结束！"
End Sub


Sub handleState
While state <> 10

	//状态决策
	If state = 0 Then 
		Dim c
		c = walk()
		If c = "w" Then 
			KeyDown "w",1
			Delay 500
			KeyUp "w",1
		Else 
			KeyDown "w",1
			KeyDown c, 1
			Delay 500
			KeyUp c, 1
			KeyUp "w",1
		End If
		
		//MessageBox "自动走"
	ElseIf state=1 Then
		//硬扛
		If view(yourColor)=1 Then
			//开火
			KeyDown "Space", 1
			Delay 500
			KeyUp "Space", 1
		End If
		//开火
		KeyDown "Space", 1
		Delay 500
		KeyUp "Space", 1
		/*
		KeyDown "w", 1
		Delay 2000
		KeyUp "w", 1
		*/
	ElseIf state=2 Then
	
	ElseIf state = 3 Then
	
	ElseIf state = 4 Then
		c = follow(otherX, otherY)
		If c = "s" Then 
			KeyDown c, 1
    		Delay 1000
    		KeyUp c, 1
		ElseIf c = "w" Then
			KeyDown c, 1
    		Delay 1000
    		KeyUp c, 1
		Else
			KeyDown "w",1
			KeyDown c, 1
    		Delay 500
    		KeyUp c, 1
    		KeyUp "w",1
		End If
		
		//使准心对正
		Delay 1000
		
	ElseIf state = 5 Then
		
	ElseIf state = 6 Then
		KeyDown "S", 1
		Delay 3000
		KeyUp "S", 1
		If int(Rnd() * 2)=0 Then 
			KeyDown "A", 1
			Delay 500
			KeyUp "A", 1
		Else 
			KeyDown "d", 1
			Delay 500
			KeyUp "d", 1
		End If
		//KeyDown "d",1
		KeyDown "w", 1
		Delay 4000
		KeyUp "w", 1
		//KeyUp "d",1
		//MessageBox "撞墙了"
	ElseIf state = 7 Then
		
	ElseIf state = 8 Then
		c = follow(myX, myY)
		If c = "s" Then 
			KeyDown c, 1
    		Delay 1000
    		KeyUp c, 1
		ElseIf c = "w" Then
			KeyDown c, 1
    		Delay 1000
    		KeyUp c, 1
		Else
			KeyDown "w",1
			KeyDown c, 1
    		Delay 500
    		KeyUp c, 1
    		KeyUp "w", 1
    		//MessageBox c
		End If
		//使准心对正
		Delay 1000
	ElseIf state = 9 Then
		//MessageBox "站点"
		If x>lmapcenterx-70 and x<lmapcenterx+70  Then
			If y < lmapcentery Then 
				c="w"
			Else 
				c="s"
			End If	
    	Else 
    		If x < lmapcenterx Then 
    			c="a"
    		Else 
    			c="d"
    		End If
		End If
		KeyDown c, 1
    	Delay 1000
    	KeyUp c, 1
	Else 
	
	End If
		
	
Wend
MessageBox "脚本结束！"
End Sub




/*
KeyDown "Space", 1
Delay 500
KeyUp "Space", 1
	
		
		
		
		
		
		
		//KeyPress "S", 5
		//前进
		
    	KeyDown "W", 1
    	Delay 3000
    	KeyUp "W", 1
    	
    	
    	//前面
	FindColorEx 1230, 115, 1232, 119, "f1eeee", 1, 0.6, M, N
	FindColorEx 1230, 115, 1232, 119, "9cebec", 1, 0.6, X, Y
	
	If M > 0 or X > 0 Then 
		intX = 1
	Else 
		intX=-1
	End If
	
	If intX > 0  Then 
		walk="w"
	Else 
		//左边
		FindColorEx 1215, 140, 1218, 143, "f1eeee", 1, 0.6, M, N
		
		FindColorEx 1230, 115, 1232, 119, "9cebec", 1, 0.6, X, Y
		If M > 0 or X > 0 Then 
			intX = 1
		Else 
			intX=-1
		End If
		
		If intX > 0  Then 
			walk="a"
		End If
		//右边
		FindColorEx 1242, 142, 1245, 145, "f1eeee", 1, 0.6, M, N
		FindColorEx 1230, 115, 1232, 119, "9cebec", 1, 0.6, X, Y
		
		If M > 0 or X > 0 Then 
			intX = 1
		Else 
			intX=-1
		End If
		
		If intX > 0  Then 
			walk="d"
		End If
		//后退
		walk="s"
	End If
	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	FindColorEx 1277, 658, 1280, 660, OldEdgeColor, 1, 0.9, intX, intY
	If intX > 0 And intY > 0 Then 
		KeyDown "s", 1
    	Delay 500
    	KeyUp "s", 1
    	
		KeyDown "a", 1
    	Delay 1000
    	KeyUp "a", 1
	Else 
		KeyDown "w", 1
    	Delay 1000
    	KeyUp "w", 1
	End If
	*/
