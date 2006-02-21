Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FBdZk-0002fM-2q for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Feb 2006 11:53:32 -0800
Received: from zcars04f.nortel.com ([47.129.242.57])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FBdZj-0002RE-TV
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Feb 2006 11:53:32 -0800
Received: from zrc2hxm2.corp.nortel.com (zrc2hxm2.corp.nortel.com
	[47.103.123.73])
	by zcars04f.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id
	k1LJrOX22693 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 21 Feb 2006 14:53:24 -0500 (EST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C63720.778AC031"
Message-ID: <6FC4416DDE56C44DA0AEE67BC7CA43710D0A76F9@zrc2hxm2.corp.nortel.com>
From: "John Dykstra" <jdykstra@nortel.com>
Subject: [uml-devel] Build error in arch/um/os-Linux/aio.c with today's
	2.6.16-rc4 patch set
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
Date: Tue, 21 Feb 2006 13:53:20 -0600
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C63720.778AC031
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

It appears to me that the kernel tree will not build with the 2.6.16-rc4
patch set I downloaded today, if HAVE_AIO_ABI is not defined. =20

finish_aio_26() is referenced in arch/um/os-Linux/aio.c, but is not
defined.  It looks like a stub was omitted.

Sorry for the mistaken posting to the user list.

  --  John

------_=_NextPart_001_01C63720.778AC031
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7233.28">
<TITLE>Build error in arch/um/os-Linux/aio.c with today's 2.6.16-rc4 =
patch set</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">It appears to me that the kernel tree =
will not build with the 2.6.16-rc4 patch set I downloaded today, if =
HAVE_AIO_ABI is not defined.&nbsp; </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">finish_aio_26() is referenced in =
arch/um/os-Linux/aio.c, but is not defined.&nbsp; It looks like a stub =
was omitted.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Sorry for the mistaken posting to the =
user list.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; --&nbsp; John</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C63720.778AC031--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
