Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A31Lx-0002gx-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 26 Sep 2003 15:46:21 -0700
Received: from [204.26.87.76] (helo=uswgne22.uswest.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A31Lw-0004yq-MR
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Sep 2003 15:46:20 -0700
Received: from egate-co5.uswc.uswest.com (egate-co5.uswc.uswest.com [151.119.87.232])
	by uswgne22.uswest.com (8/8) with ESMTP id h8QMjTLY016968
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 26 Sep 2003 17:45:29 -0500 (CDT)
Received: from dubntex011.qwest.net (localhost [127.0.0.1])
	by egate-co5.uswc.uswest.com (8.12.10/8.12.10) with ESMTP id h8QMjSWc000613
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 26 Sep 2003 16:45:28 -0600 (MDT)
Message-ID: <2D4B6CD74137D4119A1100104BC6BCBF0BC585FC@dubntex006.qwest.net>
From: "Montgomery, Kendal L" <kendal.montgomery@qwest.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3847F.E0ED31A0"
Subject: [uml-devel] Separate COW patch.
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 26 Sep 2003 18:45:26 -0400
To: "'user-mode-linux-devel@lists.sourceforge.net'" <user-mode-linux-devel@lists.sourceforge.net>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3847F.E0ED31A0
Content-Type: text/plain

Hello,

I was wondering if there was anyone who is trying to use the COW filesystem
in a normal linux kernel?  Is this possible, or is it tied exclusively to
the rest of the UML patch?  How difficult would it be to make a COW only
patch?  I have a certain project that I'm working on that the COW filesystem
(or really, any other "union" filesystem, but I can't find any that are
actively developed or fully cooked) would be perfect for.  I have a
read-only filesystem that, occasionally needs to temoroarily have some
changed made to it, but then the need to be undone.  I've looked into
various ways of doing this from "snapshotting," to user-controlled
transactions on a journalling filesystem (no such thing seems to exist for
ext3 or reiserfs) where I could explicitly begin a transaction, then roll
back the transaction when I'm done (kinda like a database txn), etc.  The
COW filesystem seems like it would be a perfect fit, but before I go trying
to merge things into a non-UML kernel on my own I just want to see if anyone
else has already done this or not.  Is anyone else even interested in such a
thing?

Thanks.

Kendal.

------_=_NextPart_001_01C3847F.E0ED31A0
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>Separate COW patch.</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I was wondering if there was anyone =
who is trying to use the COW filesystem in a normal linux kernel?&nbsp; =
Is this possible, or is it tied exclusively to the rest of the UML =
patch?&nbsp; How difficult would it be to make a COW only patch?&nbsp; =
I have a certain project that I'm working on that the COW filesystem =
(or really, any other &quot;union&quot; filesystem, but I can't find =
any that are actively developed or fully cooked) would be perfect =
for.&nbsp; I have a read-only filesystem that, occasionally needs to =
temoroarily have some changed made to it, but then the need to be =
undone.&nbsp; I've looked into various ways of doing this from =
&quot;snapshotting,&quot; to user-controlled transactions on a =
journalling filesystem (no such thing seems to exist for ext3 or =
reiserfs) where I could explicitly begin a transaction, then roll back =
the transaction when I'm done (kinda like a database txn), etc.&nbsp; =
The COW filesystem seems like it would be a perfect fit, but before I =
go trying to merge things into a non-UML kernel on my own I just want =
to see if anyone else has already done this or not.&nbsp; Is anyone =
else even interested in such a thing?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Kendal.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C3847F.E0ED31A0--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
