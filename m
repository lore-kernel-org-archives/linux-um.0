Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ppessolani@hotmail.com>) id 1gwWjx-0002cp-6j
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 20 Feb 2019 18:37:05 +0000
Received: from mail-oln040092002077.outbound.protection.outlook.com
 ([40.92.2.77] helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1gwWju-003d5p-UW for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 20 Feb 2019 18:37:05 +0000
From: Pablo Pessolani <ppessolani@hotmail.com>
Date: Wed, 20 Feb 2019 18:36:56 +0000
Message-ID: <BN6PR20MB1937E3301E14A7C38B26DD6DCF7D0@BN6PR20MB1937.namprd20.prod.outlook.com>
Content-Language: es-AR
MIME-Version: 1.0
Subject: [uml-devel] UML: Access to a host device from UML
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2948405168866707937=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============2948405168866707937==
Content-Language: es-AR
Content-Type: multipart/alternative;
	boundary="_000_BN6PR20MB1937E3301E14A7C38B26DD6DCF7D0BN6PR20MB1937namp_"

--_000_BN6PR20MB1937E3301E14A7C38B26DD6DCF7D0BN6PR20MB1937namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi:
        I wrote an IPC mechanism as a Linux kernel module. The access to th=
eir services is through a dummy character device called /dev/dvk using ioct=
l(). Therefore, only open(), ioctl() and close() system calls are used.
        How can a process running within an UML Guest access the /dev/dvk h=
ost device?  (humfs??)
        The idea is to communicate two o more UML instances through this IP=
C mechanism.
        Thanks in advance.
Regards.
PAP


--_000_BN6PR20MB1937E3301E14A7C38B26DD6DCF7D0BN6PR20MB1937namp_
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
&nbsp; &nbsp; &nbsp; &nbsp; I wrote an IPC mechanism as a Linux kernel modu=
le. The access to their services is through a dummy character device called=
 /dev/dvk using ioctl(). Therefore, only open(), ioctl() and close() system=
 calls are used.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 12pt;">&nbsp; &nbsp; &nbsp; &nbsp; How can a process runni=
ng within an UML Guest access the /dev/dvk host device?&nbsp; (humfs??)</sp=
an></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 12pt;">&nbsp; &nbsp; &nbsp; &nbsp; The idea is to communic=
ate two o more UML instances through this IPC mechanism.</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 12pt;">&nbsp; &nbsp; &nbsp; &nbsp; Thanks in advance.</spa=
n></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 12pt;">Regards.</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 12pt;">PAP</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-s=
erif; font-size: 12pt;"><br>
</span></div>
</body>
</html>

--_000_BN6PR20MB1937E3301E14A7C38B26DD6DCF7D0BN6PR20MB1937namp_--


--===============2948405168866707937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2948405168866707937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2948405168866707937==--


