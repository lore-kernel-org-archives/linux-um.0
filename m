Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJ4PW-0004hy-3M for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Mar 2006 23:57:42 -0800
Received: from motgate8.mot.com ([129.188.136.8])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FJ4PV-0003WF-1a
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Mar 2006 23:57:42 -0800
Received: from il06exr03.mot.com (il06exr03.mot.com [129.188.137.133])
	by motgate8.mot.com (8.12.11/Motgate7) with ESMTP id k2E8D5Nh008324
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 14 Mar 2006 01:13:10 -0700 (MST)
Received: from zmy16exm63.ds.mot.com (zmy16exm63.ap.mot.com [10.179.4.34])
	by il06exr03.mot.com (8.13.1/8.13.0) with ESMTP id k2E8D8O1005737
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 14 Mar 2006 02:13:09 -0600 (CST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6473C.EDD0ABBC"
Message-ID: <565F40B9893580489B94B8D324460AF4572AA4@zmy16exm63.ds.mot.com>
From: "Wang LianWei-A22439" <lian-wei.wang@motorola.com>
Subject: [uml-devel] mount hostfs problem
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 14 Mar 2006 15:57:11 +0800
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6473C.EDD0ABBC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

After launch the uml with hostfs mounted, I run the find command in '/'
directory,then the host system crash.
=20
as below procedure:
=20
       cd /
       find .
then the host crash.
=20
My UML kernel version is 2.6.10.
=20
Best Regards,
Wang Lianwei
[X]  General Business Information
=20
=20

------_=_NextPart_001_01C6473C.EDD0ABBC
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D665254707-14032006><FONT size=3D2>After&nbsp;launch =
the uml with=20
hostfs mounted, I run the find command in '/' directory,then the host =
system=20
crash.</FONT></SPAN></DIV>
<DIV><SPAN class=3D665254707-14032006><FONT =
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D665254707-14032006><FONT size=3D2>as below=20
procedure:</FONT></SPAN></DIV>
<DIV><SPAN class=3D665254707-14032006><FONT =
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D665254707-14032006><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cd /</FONT></SPAN></DIV>
<DIV><SPAN class=3D665254707-14032006><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; find .</FONT></SPAN></DIV>
<DIV><SPAN class=3D665254707-14032006><FONT size=3D2>then the host=20
crash.</FONT></SPAN></DIV>
<DIV><SPAN class=3D665254707-14032006><FONT =
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D665254707-14032006><FONT size=3D2>My UML kernel =
version is=20
2.6.10.</FONT></SPAN></DIV>
<DIV><SPAN class=3D665254707-14032006><FONT =
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV align=3Dleft><FONT size=3D2>Best Regards,<BR>Wang =
Lianwei</FONT><FONT=20
size=3D2><BR>[X]&nbsp; General Business Information</FONT></DIV>
<DIV align=3Dleft><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C6473C.EDD0ABBC--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
