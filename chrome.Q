[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=c390cb48-fe44-40fe-8057-4170d64c44bb
Description=chrome
Enable=0
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
Dim dis
dis = 479
/*
颜色： 
"535353"
"ACACAC"
*/

While 1
	//变色
	MostColor=GetPixelColor(300,225)
	//发现障碍
	GetColor1 = GetPixelColor(dis, 227)
	GetColor2 = GetPixelColor(dis+5, 227)
	GetColor3 = GetPixelColor(dis+10, 227)
	If GetColor1<>MostColor OR GetColor2<>MostColor OR GetColor3<>MostColor Then 
		KeyDown "Space", 1
		Delay 300
		KeyUp "Space", 1
		dis=dis+1
		//MessageBox dis
	End If
	GetColor1 = GetPixelColor(dis, 246)
	GetColor2 = GetPixelColor(dis+5, 246)
	GetColor3 = GetPixelColor(dis+10, 246)
	If GetColor1<>MostColor OR GetColor2<>MostColor OR GetColor3<>MostColor Then 
		KeyDown "Space", 1
		Delay 200
		KeyUp "Space", 1
		dis=dis+1
		//MessageBox dis
	End If
Wend
/*
Sub A()
While 1
	//变色
	MostColor=GetPixelColor(300,225)
	//发现障碍
	GetColor = GetPixelColor(dis, 238)
	If GetColor<>MostColor Then 
		KeyDown "Space", 1
		Delay 300
		KeyUp "Space", 1
		dis=dis+1
		//MessageBox dis
	End If
	GetColor = GetPixelColor(dis, 246)
	If GetColor<>MostColor Then 
		KeyDown "Space", 1
		Delay 100
		KeyUp "Space", 1
		dis=dis+1
		//MessageBox dis
	End If
Wend
End sub

Sub B()
While 1
	//变色
	MostColor=GetPixelColor(300,225)
	//发现障碍
	GetColor = GetPixelColor(dis, 238)
	If GetColor<>MostColor Then 
		KeyDown "Space", 1
		Delay 300
		KeyUp "Space", 1
		dis=dis+1
		//MessageBox dis
	End If
	GetColor = GetPixelColor(dis, 246)
	If GetColor<>MostColor Then 
		KeyDown "Space", 1
		Delay 100
		KeyUp "Space", 1
		dis=dis+1
		//MessageBox dis
	End If
Wend
End sub



Sub c()
While 1
	//变色
	MostColor=GetPixelColor(300,225)
	//发现障碍
	GetColor = GetPixelColor(dis, 238)
	If GetColor<>MostColor Then 
		KeyDown "Space", 1
		Delay 300
		KeyUp "Space", 1
		dis=dis+1
		//MessageBox dis
	End If
	GetColor = GetPixelColor(dis, 246)
	If GetColor<>MostColor Then 
		KeyDown "Space", 1
		Delay 100
		KeyUp "Space", 1
		dis=dis+1
		//MessageBox dis
	End If
Wend
End sub
*/
	//飞鸟
	GetColor=GetPixelColor(dis+30,218)
	If GetColor<>MostColor Then 
		KeyDown "Space", 1
		Delay 300
		KeyUp "Space", 1
		//dis=dis+1
	End If
	

//发现障碍
	FindColorEx 455,226,dis,240,"535353",0,1.0,intX,intY
	If intX > 0 And intY > 0 Then 
		KeyDown "Space", 1
		Delay 300
		KeyUp "Space", 1
		dis=dis+1
		//MessageBox dis
	End If
	FindColorEx 455,226,dis,240,"ACACAC",0,0.8,intX,intY
	If intX > 0 And intY > 0 Then 
		KeyDown "Space", 1
		Delay 300
		KeyUp "Space", 1
		dis=dis+1
		//MessageBox dis
	End If
	//飞鸟
	FindColorEx 470,214,dis+30,218,"535353",0,1.0,intX,intY
	If intX > 0 And intY > 0 Then 
		KeyDown "Space", 1
		Delay 300
		KeyUp "Space", 1
		//dis=dis+1
	End If
	FindColorEx 470,214,dis+30,218,"ACACAC",0,0.8,intX,intY
	If intX > 0 And intY > 0 Then 
		KeyDown "Space", 1
		Delay 300
		KeyUp "Space", 1
		//dis=dis+1
	End If
