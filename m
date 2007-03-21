Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HTzLz-00084p-Q1 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Mar 2007 04:51:44 -0700
Received: from mail119.messagelabs.com ([216.82.241.179])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HTzLy-0005Z8-B8
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Mar 2007 04:51:43 -0700
Received: from il06exr01.mot.com (il06exr01.mot.com [129.188.137.131])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id l2LBpeUs018445
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Mar 2007 04:51:40 -0700 (MST)
Received: from ZMY16EXM67.ds.mot.com (zmy16exm67.ap.mot.com [10.179.4.27])
	by il06exr01.mot.com (8.13.5/8.13.0) with ESMTP id l2LBpcCw025890
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Mar 2007 06:51:39 -0500 (CDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 21 Mar 2007 19:51:44 +0800
Message-ID: <0A01463223B8164194908CAC85B66A1201B0F01D@ZMY16EXM67.ds.mot.com>
From: "Krishnappa Abhijith-A21204" <abhijith@motorola.com>
Subject: [uml-devel] Regarding Process creation in UML tracing thread mode
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1435481706=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1435481706==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C76BAF.480FCE57"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C76BAF.480FCE57
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
             Regarding fork() implementation UML in tracing thread (tt)
mode
Whenever we call fork in UML the following happens:
=20
2 process gets created=20
1 on UML say U_1 and 1 on HOST say H_1
=20
Process in host gets created by tracing thread but how does a process in
UML gets created ?
=20
Also whenever a UML process makes a system call UML uses the
corresponding Host process for execution of system call is that true ?
=20
Also, How does UML process communicates to irts corresponding host
process
=20
=20
=20
Thanks a lot for all the help.
=20
Regards,
Abhi
=20

=20

------_=_NextPart_001_01C76BAF.480FCE57
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3059" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3D"Trebuchet MS" size=3D2>Hi,<BR>&nbsp;<SPAN=20
class=3D717115111-21032007>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;=20
</SPAN>Regarding fork() implementation UML in tracing thread (tt)=20
mode<BR>Whenever we call fork in UML the following happens:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2>2 process gets created <BR>1 =
on UML say=20
U_1 and 1 on HOST say H_1</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2>Process in host gets created =
by tracing=20
thread but how does a process in UML gets created ?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2>Also whenever a UML process =
makes a system=20
call UML uses the corresponding Host process for execution of system =
call is=20
that true ?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2>Also, How does UML process =
communicates to=20
irts corresponding host process</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" size=3D2>Thanks a lot for all the=20
help.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS"=20
size=3D2>Regards,<BR>Abhi<BR>&nbsp;<BR></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" =
size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C76BAF.480FCE57--


--===============1435481706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1435481706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1435481706==--
