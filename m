Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HRpip-0000gu-Kg for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Mar 2007 06:10:23 -0700
Received: from mail119.messagelabs.com ([216.82.241.179])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HRpio-0003G1-49
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Mar 2007 06:10:23 -0700
Received: from az33exr01.mot.com (az33exr01.mot.com [10.64.251.231])
	by motgate2.mot.com (8.12.11/Motorola) with ESMTP id l2FDAJKv011265
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Mar 2007 06:10:19 -0700 (MST)
Received: from az10vts04 (az10vts04.mot.com [10.64.251.245])
	by az33exr01.mot.com (8.13.1/Vontu) with SMTP id l2FDAILD012304
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Mar 2007 08:10:18 -0500 (CDT)
Received: from ZMY16EXM67.ds.mot.com (zmy16exm67.ap.mot.com [10.179.4.27])
	by az33exr01.mot.com (8.13.1/8.13.0) with ESMTP id l2FDAGil012266
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Mar 2007 08:10:17 -0500 (CDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Thu, 15 Mar 2007 21:10:05 +0800
Message-ID: <0A01463223B8164194908CAC85B66A1201A974B0@ZMY16EXM67.ds.mot.com>
From: "Krishnappa Abhijith-A21204" <abhijith@motorola.com>
Subject: [uml-devel] Regarding UML system call implementation
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0049262638=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0049262638==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C76703.40584BC5"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C76703.40584BC5
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
            I have a question regarding system call implementation on
Linux
=20
In order to execute the system call in user space, the process is made
to execute the system call switch on its kernel stack=20
Why this is done... ?
=20
Also UML queues a signal ( SIGUSR ) to the process in order to make it
run on its kernel stack... is this the only reason why UML queue system
call ?
=20
I think by ptracing itself UML will come to know when the system ended
so that it can fill in the system_ call retrun value to the process
context.
=20
=20
Please let me know...
Thanks a lot.
=20
Thanks,
Abhi
=20

------_=_NextPart_001_01C76703.40584BC5
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3059" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D145370613-15032007><FONT face=3D"Trebuchet MS"=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN=20
class=3D145370613-15032007>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;=20
<FONT face=3D"Trebuchet MS" size=3D2>I have a question regarding system =
call=20
implementation on Linux</FONT></SPAN></DIV>
<DIV><SPAN class=3D145370613-15032007><FONT face=3D"Trebuchet MS"=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D145370613-15032007>In order to execute the system =
call in user=20
space, the process is made to execute the system call switch on its =
kernel stack=20
</SPAN></DIV>
<DIV><SPAN class=3D145370613-15032007>Why this is done... ?</SPAN></DIV>
<DIV><SPAN class=3D145370613-15032007></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D145370613-15032007><FONT face=3D"Trebuchet MS" =
size=3D2>Also <FONT=20
face=3D"Times New Roman" size=3D3>UML queues a signal ( SIGUSR ) to the =
process in=20
order to make it run on its kernel stack... is this the only reason why =
UML=20
queue system call ?</FONT></FONT></SPAN></DIV>
<DIV><SPAN class=3D145370613-15032007></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D145370613-15032007><FONT face=3D"Trebuchet MS" =
size=3D2>I think by=20
ptracing itself UML will come to know when the system ended so that it =
can fill=20
in the system_ call retrun value to the process =
context.</FONT></SPAN></DIV>
<DIV><SPAN class=3D145370613-15032007><FONT face=3D"Trebuchet MS"=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D145370613-15032007><FONT face=3D"Trebuchet MS"=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D145370613-15032007><FONT face=3D"Trebuchet MS" =
size=3D2>Please let=20
me know...</FONT></SPAN></DIV>
<DIV><SPAN class=3D145370613-15032007><FONT face=3D"Trebuchet MS" =
size=3D2>Thanks a=20
lot.</FONT></SPAN></DIV>
<DIV><SPAN class=3D145370613-15032007><FONT face=3D"Trebuchet MS"=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D145370613-15032007><FONT face=3D"Trebuchet MS"=20
size=3D2>Thanks,</FONT></SPAN></DIV>
<DIV><SPAN class=3D145370613-15032007><FONT face=3D"Trebuchet MS"=20
size=3D2>Abhi</FONT></SPAN></DIV>
<DIV><SPAN class=3D145370613-15032007></SPAN>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C76703.40584BC5--


--===============0049262638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0049262638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0049262638==--
