Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HT8MD-0005pE-JU for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Mar 2007 20:16:25 -0700
Received: from mail153.messagelabs.com ([216.82.253.51])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HT8MD-0008Du-9D
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Mar 2007 20:16:25 -0700
Received: from il06exr02.mot.com (il06exr02.mot.com [129.188.137.132])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id l2J3GNS6026088
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 Mar 2007 20:16:23 -0700 (MST)
Received: from ZMY16EXM67.ds.mot.com (zmy16exm67.ap.mot.com [10.179.4.27])
	by il06exr02.mot.com (8.13.1/8.13.0) with ESMTP id l2J3GMdn028523
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 Mar 2007 22:16:23 -0500 (CDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Mon, 19 Mar 2007 11:16:38 +0800
Message-ID: <0A01463223B8164194908CAC85B66A1201AD3E65@ZMY16EXM67.ds.mot.com>
From: "Krishnappa Abhijith-A21204" <abhijith@motorola.com>
Subject: [uml-devel] Regarding Kernel mode in UML process.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0000731827=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0000731827==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C769D4.F7F339C5"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C769D4.F7F339C5
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
        Regarding Kernel mode in UML process. This question is on UML TT
mode
A UML process wil be in Kernel mode only for executing the getpid(), and
also some signals is a UML specified stack.
Is there any other way that UML process executes in kernel mode. ?
Also when UML process enters the KERNEL by the means described above the
tracing is turned off, this is done for performance issues only right ?
=20
=20
Thanks,
Abhi

------_=_NextPart_001_01C769D4.F7F339C5
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
class=3D206151303-19032007>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D206151303-19032007>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Regarding=20
Kernel mode in UML process. This question is on UML TT =
mode</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN =
class=3D206151303-19032007>A UML=20
process wil be in Kernel mode only for executing the getpid(), and also =
some=20
signals is a UML specified stack.</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN =
class=3D206151303-19032007>Is there=20
any other way that UML process executes in kernel mode. =
?</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN =
class=3D206151303-19032007>Also when=20
UML process enters the KERNEL by the means described above the tracing =
is turned=20
off, this is&nbsp;done for performance issues only right =
?</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D206151303-19032007>&nbsp;</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D206151303-19032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D206151303-19032007>Thanks,</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D206151303-19032007>Abhi</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C769D4.F7F339C5--


--===============0000731827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0000731827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0000731827==--
