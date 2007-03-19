Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HT8Iv-0005RW-JY for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Mar 2007 20:13:01 -0700
Received: from mail153.messagelabs.com ([216.82.253.51])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HT8Iu-00044U-3v
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Mar 2007 20:13:01 -0700
Received: from az33exr01.mot.com (az33exr01.mot.com [10.64.251.231])
	by motgate.mot.com (8.12.11/Motorola) with ESMTP id l2J3CwJ4016525
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 Mar 2007 20:12:58 -0700 (MST)
Received: from az10vts01 (az10vts01.mot.com [10.64.251.242])
	by az33exr01.mot.com (8.13.1/Vontu) with SMTP id l2J3CvqT018284
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 Mar 2007 22:12:57 -0500 (CDT)
Received: from ZMY16EXM67.ds.mot.com (zmy16exm67.ap.mot.com [10.179.4.27])
	by az33exr01.mot.com (8.13.1/8.13.0) with ESMTP id l2J3CtQ6018266
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 Mar 2007 22:12:56 -0500 (CDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Mon, 19 Mar 2007 11:13:11 +0800
Message-ID: <0A01463223B8164194908CAC85B66A1201AD3E5C@ZMY16EXM67.ds.mot.com>
From: "Krishnappa Abhijith-A21204" <abhijith@motorola.com>
Subject: [uml-devel] Regarding Virtual Memory Emulation in UML.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0128424601=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0128424601==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C769D4.7CE09D1D"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C769D4.7CE09D1D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
        Regarding Virtual Memory Emulation in UML (TT mode).
UML will create a file of Physical mem size and it allocates memory to
UML process by mmap() ing it.
=20
Also in Jeff's article I read that Kernel's text and Data are located in
the process address space....
Why the kernels text and data will be in UML Process address space ?
Normaly kernel is a seprate entity right ?
So basically process and kernel address space co-exist.. May I know why?
=20
Thanks,
Abhi

------_=_NextPart_001_01C769D4.7CE09D1D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3059" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D793450103-19032007>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D793450103-19032007>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Regarding=20
Virtual Memory Emulation in UML (TT mode).</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN =
class=3D793450103-19032007>UML will=20
create a file of Physical mem size and it allocates memory to UML =
process by=20
mmap() ing it.</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D793450103-19032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN =
class=3D793450103-19032007>Also in=20
Jeff's article I read that Kernel's text and Data are located in the =
process=20
address space....</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN =
class=3D793450103-19032007>Why the=20
kernels text and data will be in UML Process address space ? Normaly =
kernel is a=20
seprate entity right ?</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN =
class=3D793450103-19032007>So=20
basically process and kernel address space co-exist.. May I know=20
why?</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D793450103-19032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D793450103-19032007>Thanks,</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D793450103-19032007>Abhi</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C769D4.7CE09D1D--


--===============0128424601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0128424601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0128424601==--
