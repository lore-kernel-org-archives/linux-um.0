Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FEXYi-0001T2-Ss for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Mar 2006 12:04:28 -0800
Received: from zrtps0kp.nortel.com ([47.140.192.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FEXYi-0008U2-Hp
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Mar 2006 12:04:28 -0800
Received: from zrc2hxm2.corp.nortel.com (zrc2hxm2.corp.nortel.com
	[47.103.123.73])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id
	k21K4Ji29029 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 1 Mar 2006 15:04:20 -0500 (EST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C63D6B.52F412C4"
Message-ID: <6FC4416DDE56C44DA0AEE67BC7CA43710D313E2A@zrc2hxm2.corp.nortel.com>
From: "John Dykstra" <jdykstra@nortel.com>
Subject: [uml-devel] Unknown symbol vsyscall_end when loading external module
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
Date: Wed, 1 Mar 2006 14:04:18 -0600
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C63D6B.52F412C4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm getting this when loading an externally built module:

infinity: Unknown symbol vsyscall_end
infinity: Unknown symbol vsyscall_ehdr

The module uses copy_from_user().  When ARCH=3Dum, copy_from_user() is
defined as inline, and uses FIXADDR_USER_END.  That macro is defined as
VSYSCALL_END, which in turn is defined as vsyscall_end.  However,
there's no EXPORT_SYMBOL(vsyscall_end).

This is in linux-2.6.16-rc4, with Jeff's patch set from last week.

TIA.

  --  John

------_=_NextPart_001_01C63D6B.52F412C4
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
<TITLE>Unknown symbol vsyscall_end when loading external module</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">I'm getting this when loading an =
externally built module:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">infinity: Unknown symbol =
vsyscall_end</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">infinity: Unknown symbol =
vsyscall_ehdr</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">The module uses copy_from_user().&nbsp; =
When ARCH=3Dum, copy_from_user() is defined as inline, and uses =
FIXADDR_USER_END.&nbsp; That macro is defined as VSYSCALL_END, which in =
turn is defined as vsyscall_end.&nbsp; However, there's no =
EXPORT_SYMBOL(vsyscall_end).</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">This is in linux-2.6.16-rc4, with =
Jeff's patch set from last week.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">TIA.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; --&nbsp; John</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C63D6B.52F412C4--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
