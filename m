Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HT7lO-0001uF-Hj for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Mar 2007 19:38:23 -0700
Received: from mail153.messagelabs.com ([216.82.253.51])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HT7lN-0004tr-0X
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Mar 2007 19:38:22 -0700
Received: from il06exr02.mot.com (il06exr02.mot.com [129.188.137.132])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id l2J2cJNF019375
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 Mar 2007 19:38:19 -0700 (MST)
Received: from ZMY16EXM67.ds.mot.com (zmy16exm67.ap.mot.com [10.179.4.27])
	by il06exr02.mot.com (8.13.1/8.13.0) with ESMTP id l2J2cHoJ017836
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 Mar 2007 21:38:18 -0500 (CDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Mon, 19 Mar 2007 10:38:27 +0800
Message-ID: <0A01463223B8164194908CAC85B66A1201AD3E2E@ZMY16EXM67.ds.mot.com>
From: "Krishnappa Abhijith-A21204" <abhijith@motorola.com>
Subject: [uml-devel] Regarding System call virtualization
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1118191339=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1118191339==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C769CF.A514CAF8"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C769CF.A514CAF8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
        Is the below flow correct for UML (TT mode)
=20
1. UML process wants to execute a sys call say open().
2. UML TT comes to know this annuls with getpid(), and UML TT executes
open() on behalf of UML process.
3. UML process executes the getpid() and returns and signals TT.
4. By this time UML TT has finished executing the system call open and
has returned back, so TT fills in the registers of UML process.
5. Now UML process executes normally with the open file descriptor.
=20
If the above steps are correct, then How does UML protects host kernel.
because even here TT will ask for host kernel services which may corrupt
host kernel ?=20
Is there any method by which it is prevented ?
=20
Thanks a lot.
Abhi

------_=_NextPart_001_01C769CF.A514CAF8
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3059" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D145253302-19032007><FONT face=3D"Trebuchet MS"=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN =
class=3D145253302-19032007>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<FONT face=3D"Trebuchet MS" size=3D2>Is the below flow correct for UML =
(TT=20
mode)</FONT></SPAN></DIV>
<DIV><SPAN class=3D145253302-19032007><FONT face=3D"Trebuchet MS"=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D145253302-19032007><FONT face=3D"Trebuchet MS" =
size=3D2>1. UML=20
process wants to execute a sys call say open().</FONT></SPAN></DIV>
<DIV><SPAN class=3D145253302-19032007><FONT face=3D"Trebuchet MS" =
size=3D2>2. UML TT=20
comes to know this annuls with getpid(), and UML TT executes open() on =
behalf of=20
UML process.</FONT></SPAN></DIV>
<DIV><SPAN class=3D145253302-19032007><FONT face=3D"Trebuchet MS" =
size=3D2>3. UML=20
process executes the getpid() and returns and signals =
TT.</FONT></SPAN></DIV>
<DIV><SPAN class=3D145253302-19032007><FONT face=3D"Trebuchet MS" =
size=3D2>4. By this=20
time UML TT has finished executing the system call open and has returned =
back,=20
so TT fills in the registers of UML process.</FONT></SPAN></DIV>
<DIV><SPAN class=3D145253302-19032007><FONT face=3D"Trebuchet MS" =
size=3D2>5. Now UML=20
process executes normally with the open file =
descriptor.</FONT></SPAN></DIV>
<DIV><SPAN class=3D145253302-19032007><FONT face=3D"Trebuchet MS"=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D145253302-19032007><FONT face=3D"Trebuchet MS" =
size=3D2>If the=20
above steps are correct, then How does UML protects host=20
kernel.</FONT></SPAN></DIV>
<DIV><SPAN class=3D145253302-19032007><FONT face=3D"Trebuchet MS" =
size=3D2>because=20
even here TT will ask for host kernel services which may corrupt host =
kernel ?=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D145253302-19032007><FONT face=3D"Trebuchet MS" =
size=3D2>Is there=20
any method by which it is prevented ?</FONT></SPAN></DIV>
<DIV><SPAN class=3D145253302-19032007><FONT face=3D"Trebuchet MS"=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D145253302-19032007><FONT face=3D"Trebuchet MS" =
size=3D2>Thanks a=20
lot.</FONT></SPAN></DIV>
<DIV><SPAN class=3D145253302-19032007><FONT face=3D"Trebuchet MS"=20
size=3D2>Abhi</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C769CF.A514CAF8--


--===============1118191339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1118191339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1118191339==--
