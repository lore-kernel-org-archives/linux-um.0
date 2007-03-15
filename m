Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HRqxZ-0000Wg-32 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Mar 2007 07:29:41 -0700
Received: from mail119.messagelabs.com ([216.82.241.179])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HRqxX-0004e6-Kx
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Mar 2007 07:29:41 -0700
Received: from il06exr03.mot.com (il06exr03.mot.com [129.188.137.133])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id l2FETVeZ013063
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Mar 2007 07:29:31 -0700 (MST)
Received: from ZMY16EXM67.ds.mot.com (zmy16exm67.ap.mot.com [10.179.4.27])
	by il06exr03.mot.com (8.13.1/8.13.0) with ESMTP id l2FETUZ8013405
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 15 Mar 2007 09:29:31 -0500 (CDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Thu, 15 Mar 2007 22:29:28 +0800
Message-ID: <0A01463223B8164194908CAC85B66A1201A9750B@ZMY16EXM67.ds.mot.com>
From: "Krishnappa Abhijith-A21204" <abhijith@motorola.com>
Subject: [uml-devel] Regarding fork() implementation in UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1484365919=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1484365919==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7670E.56C6EADD"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7670E.56C6EADD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
            SORRY for bugging you guys so much...
 Regarding fork() implementation in UML
=20
I was going through the below code=20
=20
long sys_fork(void)
{
 long ret;
=20
 current->thread.forking =3D 1;
 ret =3D do_fork(SIGCHLD, UPT_SP(&current->thread.regs.regs),
        &current->thread.regs, 0, NULL, NULL);
 current->thread.forking =3D 0;
 return(ret);
}
=20
Can pls let me know why current->thread.forking =3D 1 was done before
calling do_fork() and then reset after that ?
=20
Regards,
Abhi


------_=_NextPart_001_01C7670E.56C6EADD
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3059" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3D"Trebuchet MS" color=3D#0000ff =
size=3D2><SPAN=20
class=3D961412714-15032007>Hi,</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D"Trebuchet MS" color=3D#0000ff =
size=3D2><SPAN=20
class=3D961412714-15032007>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;=20
SORRY for bugging you guys so much...</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D"Trebuchet MS" color=3D#0000ff =
size=3D2><SPAN=20
class=3D961412714-15032007>&nbsp;Regarding fork() implementation in=20
UML</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D"Trebuchet MS" color=3D#0000ff =
size=3D2><SPAN=20
class=3D961412714-15032007></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D"Trebuchet MS" color=3D#0000ff =
size=3D2><SPAN=20
class=3D961412714-15032007>I was going through the below code =
</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D"Trebuchet MS" color=3D#0000ff =
size=3D2><SPAN=20
class=3D961412714-15032007></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D"Trebuchet MS" color=3D#0000ff =
size=3D2><SPAN=20
class=3D961412714-15032007>long sys_fork(void)<BR>{<BR>&nbsp;long=20
ret;</SPAN></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D"Trebuchet MS" color=3D#0000ff =
size=3D2><SPAN=20
class=3D961412714-15032007><STRONG>&nbsp;current-&gt;thread.forking =3D=20
1;</STRONG><BR>&nbsp;ret =3D do_fork(SIGCHLD,=20
UPT_SP(&amp;current-&gt;thread.regs.regs),<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;=20
&amp;current-&gt;thread.regs, 0, NULL,=20
NULL);<BR><STRONG>&nbsp;current-&gt;thread.forking =3D=20
0;</STRONG><BR>&nbsp;return(ret);<BR>}</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#0000ff size=3D2><SPAN=20
class=3D961412714-15032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#0000ff size=3D2><SPAN=20
class=3D961412714-15032007>Can pls let me know why =
current-&gt;thread.forking =3D 1=20
was done before calling do_fork() and then reset after that=20
?</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#0000ff size=3D2><SPAN=20
class=3D961412714-15032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#0000ff size=3D2><SPAN=20
class=3D961412714-15032007>Regards,</SPAN></FONT></DIV>
<DIV><FONT face=3D"Trebuchet MS" color=3D#0000ff size=3D2><SPAN=20
class=3D961412714-15032007>Abhi</DIV>
<DIV dir=3Dltr align=3Dleft><BR></DIV></SPAN></FONT></BODY></HTML>

------_=_NextPart_001_01C7670E.56C6EADD--


--===============1484365919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1484365919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1484365919==--
