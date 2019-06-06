Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ppessolani@hotmail.com>) id 1hZ1nF-0005wS-LL
 for user-mode-linux-devel@lists.sourceforge.net;
 Thu, 06 Jun 2019 23:27:38 +0000
Received: from mail-oln040092012026.outbound.protection.outlook.com
 ([40.92.12.26] helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1hZ1nD-006tYM-DY for user-mode-linux-devel@lists.sourceforge.net;
 Thu, 06 Jun 2019 23:27:37 +0000
From: Pablo Pessolani <ppessolani@hotmail.com>
Date: Thu, 6 Jun 2019 23:27:28 +0000
Message-ID: <MN2PR20MB283115FDE610524A87F975BECF170@MN2PR20MB2831.namprd20.prod.outlook.com>
Content-Language: es-AR
MIME-Version: 1.0
Subject: [uml-devel] Running functions in SKAS
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1570981087610280238=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============1570981087610280238==
Content-Language: es-AR
Content-Type: multipart/alternative;
	boundary="_000_MN2PR20MB283115FDE610524A87F975BECF170MN2PR20MB2831namp_"

--_000_MN2PR20MB283115FDE610524A87F975BECF170MN2PR20MB2831namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi:
     I need to run a custom (host-OS) system call  from a user-space proces=
s of a running UML (without been ptraced)
     The system call considers the host-OS task_struct, nor UML kernel allo=
cated task_struct for the process.
     So as not to break the UML operating mode, I think that could I do it =
running a function located in the process' SKAS stub and invoked from the U=
ML Kernel (such as stub_clone_handler())
     I there any way to do that? Can I define global/static variables in th=
e process' SKAS stub?
Regards.
PAP



--_000_MN2PR20MB283115FDE610524A87F975BECF170MN2PR20MB2831namp_
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
&nbsp; &nbsp; &nbsp;I need to run a custom <span style=3D"font-family: Cali=
bri, Helvetica, sans-serif; background-color: rgb(255, 255, 255); display: =
inline !important">
(host-OS)&nbsp;</span>system call&nbsp; from a user-space process of a runn=
ing UML (without been ptraced)</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;The system call considers the host-OS <i><b>task_struct=
</b></i>, nor UML kernel
<span style=3D"font-family: Calibri, Helvetica, sans-serif; background-colo=
r: rgb(255, 255, 255); display: inline !important">
allocated<span>&nbsp;</span></span><i><b>task_struct</b></i> for the proces=
s.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;So as not to break the UML operating mode, I think that=
 could I do it running a function located in the process'&nbsp;<span style=
=3D"font-family: Calibri, Helvetica, sans-serif; background-color: rgb(255,=
 255, 255); display: inline !important">SKAS stub and
</span>invoked from the UML Kernel (such as&nbsp;<i><b>stub_clone_handler</=
b></i>())</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;I there any way to do that? Can I define global/static =
variables in the process' SKAS stub?</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Regards.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
PAP</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
&nbsp; &nbsp;</div>
</body>
</html>

--_000_MN2PR20MB283115FDE610524A87F975BECF170MN2PR20MB2831namp_--


--===============1570981087610280238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1570981087610280238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1570981087610280238==--


