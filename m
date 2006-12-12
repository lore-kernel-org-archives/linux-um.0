Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GtzE4-0001zE-Ih for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Dec 2006 20:26:44 -0800
Received: from mail128.messagelabs.com ([216.82.250.131])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GtzE3-0005rx-9o
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Dec 2006 20:26:44 -0800
Received: from az33exr02.mot.com (az33exr02.mot.com [10.64.251.232])
	by motgate5.mot.com (8.12.11/Motorola) with ESMTP id kBC4Qak7018621
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 11 Dec 2006 21:26:36 -0700 (MST)
Received: from ZMY16EXM67.ds.mot.com (zmy16exm67.ap.mot.com [10.179.4.27])
	by az33exr02.mot.com (8.13.1/8.13.0) with ESMTP id kBC4QYmr008816
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 11 Dec 2006 22:26:35 -0600 (CST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 12 Dec 2006 12:26:30 +0800
Message-ID: <0A01463223B8164194908CAC85B66A12012D2AB8@ZMY16EXM67.ds.mot.com>
From: "Krishnappa Abhijith-A21204" <abhijith@motorola.com>
Subject: [uml-devel] Regarding getpid
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1434332997=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1434332997==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C71DA5.B2DDB138"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C71DA5.B2DDB138
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi ,
            "Process system calls must be nullified in the host, and
this is done by converting them into getpid. "
How is system calls  are nullified by converting them to getpid() ?
=20
Pls let me know.
=20
Regards,
Abhi

------_=_NextPart_001_01C71DA5.B2DDB138
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2995" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D561281704-12122006><FONT face=3D"Trebuchet MS" =
size=3D2>Hi=20
,</FONT></SPAN></DIV>
<DIV><SPAN=20
class=3D561281704-12122006>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;=20
</SPAN><SPAN class=3D561281704-12122006>"</SPAN>Process system calls =
must be=20
nullified in the host, and this is done by converting them into=20
getpid.&nbsp;<SPAN class=3D561281704-12122006>"</SPAN></DIV>
<DIV><SPAN class=3D561281704-12122006>How is system calls&nbsp; are =
nullified by=20
converting them to getpid() ?</SPAN></DIV>
<DIV><SPAN class=3D561281704-12122006></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D561281704-12122006><FONT face=3D"Trebuchet MS" =
size=3D2>Pls let me=20
know.</FONT></SPAN></DIV>
<DIV><SPAN class=3D561281704-12122006><FONT face=3D"Trebuchet MS"=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D561281704-12122006><FONT face=3D"Trebuchet MS"=20
size=3D2>Regards,</FONT></SPAN></DIV>
<DIV><SPAN class=3D561281704-12122006><FONT face=3D"Trebuchet MS"=20
size=3D2>Abhi</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C71DA5.B2DDB138--


--===============1434332997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1434332997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1434332997==--
