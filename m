Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HT87n-0004Il-Ov for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Mar 2007 20:01:31 -0700
Received: from mail119.messagelabs.com ([216.82.241.179])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HT87m-0004zs-6N
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Mar 2007 20:01:31 -0700
Received: from il06exr01.mot.com (il06exr01.mot.com [129.188.137.131])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id l2J31RHh023534
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 Mar 2007 20:01:27 -0700 (MST)
Received: from ZMY16EXM67.ds.mot.com (zmy16exm67.ap.mot.com [10.179.4.27])
	by il06exr01.mot.com (8.13.5/8.13.0) with ESMTP id l2J31QqX020403
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 18 Mar 2007 22:01:27 -0500 (CDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Mon, 19 Mar 2007 11:01:40 +0800
Message-ID: <0A01463223B8164194908CAC85B66A1201AD3E57@ZMY16EXM67.ds.mot.com>
From: "Krishnappa Abhijith-A21204" <abhijith@motorola.com>
Subject: [uml-devel] Regarding context switching in UML.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1070763183=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1070763183==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C769D2.E1B17B35"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C769D2.E1B17B35
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
        Regarding Context switching in UML.
Each process running in UML will have corresponding process in HOST.
So when the context switching in HOST happens, UML has to switch the
corresponding UML process by saving context etc...
will this be done by tracing thread.... Also how does process running in
HOST notifies UML to switch ?
=20
Also I've read in one of the article that UML schedules its process by
itself..? How this is done ?
=20
=20
thanks a lot for all the help.
Abhi

------_=_NextPart_001_01C769D2.E1B17B35
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3059" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D123474002-19032007><FONT face=3D"Trebuchet MS"=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN =
class=3D123474002-19032007>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<FONT face=3D"Trebuchet MS" size=3D2>Regarding Context switching in=20
UML.</FONT></SPAN></DIV>
<DIV><SPAN class=3D123474002-19032007><FONT face=3D"Trebuchet MS" =
size=3D2>Each=20
process running in UML will have corresponding process in=20
HOST.</FONT></SPAN></DIV>
<DIV><SPAN class=3D123474002-19032007><FONT face=3D"Trebuchet MS" =
size=3D2>So when the=20
context switching in HOST happens, UML has to switch the corresponding =
UML=20
process by saving context etc...</FONT></SPAN></DIV>
<DIV><SPAN class=3D123474002-19032007><FONT face=3D"Trebuchet MS" =
size=3D2>will this=20
be done by tracing thread.... Also how does process running in HOST =
notifies UML=20
to switch ?</FONT></SPAN></DIV>
<DIV><SPAN class=3D123474002-19032007><FONT face=3D"Trebuchet MS"=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D123474002-19032007><FONT face=3D"Trebuchet MS" =
size=3D2>Also I've=20
read in one of the article that UML schedules its process by itself..? =
How=20
this&nbsp;is done ?</FONT></SPAN></DIV>
<DIV><SPAN class=3D123474002-19032007><FONT face=3D"Trebuchet MS"=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D123474002-19032007><FONT face=3D"Trebuchet MS"=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D123474002-19032007><FONT face=3D"Trebuchet MS" =
size=3D2>thanks a=20
lot for all the help.</FONT></SPAN></DIV>
<DIV><SPAN class=3D123474002-19032007><FONT face=3D"Trebuchet MS"=20
size=3D2>Abhi</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C769D2.E1B17B35--


--===============1070763183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1070763183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1070763183==--
