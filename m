Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HTyum-0005Af-Hx for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Mar 2007 04:23:36 -0700
Received: from mail153.messagelabs.com ([216.82.253.51])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HTyul-0003Q0-5j
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Mar 2007 04:23:36 -0700
Received: from az33exr04.mot.com ([10.64.251.234])
	by ftpbox.mot.com (8.12.11/Motorola) with ESMTP id l2LBNWks005711
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Mar 2007 06:23:32 -0500 (CDT)
Received: from az10vts01 (az10vts01.mot.com [10.64.251.242])
	by az33exr04.mot.com (8.13.1/Vontu) with SMTP id l2LBNW59005924
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Mar 2007 06:23:32 -0500 (CDT)
Received: from ZMY16EXM67.ds.mot.com (zmy16exm67.ap.mot.com [10.179.4.27])
	by az33exr04.mot.com (8.13.1/8.13.0) with ESMTP id l2LBNUd8005916
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Mar 2007 06:23:31 -0500 (CDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 21 Mar 2007 19:23:28 +0800
Message-ID: <0A01463223B8164194908CAC85B66A1201B0EFE5@ZMY16EXM67.ds.mot.com>
From: "Krishnappa Abhijith-A21204" <abhijith@motorola.com>
Subject: [uml-devel] Regarding VM in UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0359644991=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0359644991==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C76BAB.55701584"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C76BAB.55701584
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
        Regarding VM in UML (tracing thread mode).
Why we need a seprate VM for UML as we create a new process in host for
every process that created in UML and the new HOST address space is
provided by Host kernel itself ?
=20
Thanks,
Abhi
=20

------_=_NextPart_001_01C76BAB.55701584
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
class=3D920062211-21032007>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D920062211-21032007>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Regarding VM=20
in UML (tracing thread mode).</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN =
class=3D920062211-21032007>Why we need=20
a seprate VM for UML as we create a new process in host for every =
process that=20
created in UML and the new HOST address space is provided by Host kernel =
itself=20
?</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D920062211-21032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D920062211-21032007>Thanks,</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D920062211-21032007>Abhi</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2><SPAN=20
class=3D920062211-21032007></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C76BAB.55701584--


--===============0359644991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0359644991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0359644991==--
