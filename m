Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ppessolani@hotmail.com>) id 1hLUph-0005QE-Mx
 for user-mode-linux-devel@lists.sourceforge.net;
 Tue, 30 Apr 2019 15:38:14 +0000
Received: from mail-oln040092010043.outbound.protection.outlook.com
 ([40.92.10.43] helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1hLUpd-002qzb-25 for user-mode-linux-devel@lists.sourceforge.net;
 Tue, 30 Apr 2019 15:38:13 +0000
From: Pablo Pessolani <ppessolani@hotmail.com>
Date: Tue, 30 Apr 2019 15:38:01 +0000
Message-ID: <DM5PR2001MB17712DD834B1FE3447F1904ECF3A0@DM5PR2001MB1771.namprd20.prod.outlook.com>
Content-Language: es-AR
MIME-Version: 1.0
Subject: [uml-devel] How to convert UML user-space virtual address into HOST
 user-space virtual address?
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8927548103101859067=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============8927548103101859067==
Content-Language: es-AR
Content-Type: multipart/alternative;
	boundary="_000_DM5PR2001MB17712DD834B1FE3447F1904ECF3A0DM5PR2001MB1771_"

--_000_DM5PR2001MB17712DD834B1FE3447F1904ECF3A0DM5PR2001MB1771_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi:
    I am writing a UML device driver wrapper (uml/drivers),  and I need to =
convert an address of a UML user-space process into an address of UML kerne=
l space.

i.e.

Process_running_within_UML(){
         char uml_usr_buffer[MAXBUF];
         .....
          ret =3D ioctl(dvk_fd,DVK_IOCSDCINIT, (int) uml_usr_buffer);
}

UML ioctl() syscall is translated by UML to os_ioctl_generic<https://elixir=
.bootlin.com/linux/v4.9.88/ident/os_ioctl_generic>()  which then calls host=
 ioctl().

The uml_usr_buffer address is a UML virtual address, not host virtual addre=
ss.
I need to convert this UML user-space virtual address into user-space HOST =
virtual address.

Can I use, virt_to_phys() ??

Thanks in advance.
PAP



--_000_DM5PR2001MB17712DD834B1FE3447F1904ECF3A0DM5PR2001MB1771_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Hi:</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
&nbsp; &nbsp; I am writing a UML device driver wrapper (uml/drivers),&nbsp;=
 and I need to convert&nbsp;an address of a UML user-space process into an =
address of UML kernel space.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
i.e.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Process_running_within_UML(){</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;char uml_usr_buffer[MAXBUF];</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.....</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span> ret =3D ioctl(dvk_fd,DVK_IOCSDCINI=
T, (int) <span style=3D"font-family: Calibri, Helvetica, sans-serif; backgr=
ound-color: rgb(255, 255, 255); display: inline !important">
uml_usr_buffer</span>);<br>
</span><span></span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 12pt;">}</span><br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
UML <b>ioctl()</b> syscall is translated by UML to <a href=3D"https://elixi=
r.bootlin.com/linux/v4.9.88/ident/os_ioctl_generic" style=3D"font-weight: 7=
00; background-color: rgb(244, 246, 255); box-shadow: rgb(244, 246, 255) 0p=
x 0px 0px 1px; border-radius: 0.2em;">
os_ioctl_generic</a>()&nbsp; which then calls host <b>ioctl().</b></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
The <b>uml_usr_buffe</b>r address is a UML virtual address, not host virtua=
l address.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
I need to convert this UML user-space virtual address into <span style=3D"f=
ont-family: Calibri, Helvetica, sans-serif; background-color: rgb(255, 255,=
 255); display: inline !important">
user-space&nbsp;</span>HOST virtual address.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<b><br>
</b></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Can I use, virt_to_phys() ??</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<b><br>
</b></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<b>Thanks in advance.</b></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<b>PAP</b></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<b><br>
</b></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<pre style=3D"font-family: &quot;Ubuntu Mono&quot;, monospace; font-size: 0=
.9em; line-height: 1.2; padding: 1em 0px 4em 1em; margin: 0px; min-height: =
100%; tab-size: 8; hyphens: none"><br></pre>
</div>
</body>
</html>

--_000_DM5PR2001MB17712DD834B1FE3447F1904ECF3A0DM5PR2001MB1771_--


--===============8927548103101859067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8927548103101859067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============8927548103101859067==--


