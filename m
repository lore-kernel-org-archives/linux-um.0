Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B9XeJ-0006yc-TR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Apr 2004 15:00:31 -0800
Received: from picton.eecg.toronto.edu ([128.100.10.141])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B9XeJ-0001uC-G1 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Apr 2004 15:00:31 -0800
Received: from OnoSendai (lie@isis.eecg.toronto.edu [128.100.10.128])
	by picton.eecg.toronto.edu (8.12.10/8.12.10) with SMTP id
	i32N0Od2009172 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 2 Apr 2004 18:00:24 -0500 (EST)
Message-ID: <000801c4191f$81064990$0700a8c0@OnoSendai>
From: "David Lie" <lie@eecg.toronto.edu>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0005_01C418DC.71467090"
Subject: [uml-devel] Measuring Performance in UML
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
Date: Fri, 2 Apr 2004 18:00:54 -0800
To: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C418DC.71467090
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all:

I'm part of a research group at the University of Toronto doing research =
using UML.  I'd like to measure the performance of applications running =
in UML vs. on Native Linux.  Since the implementation of sys_time seems =
to end up being a call to gettimeofday on the host system, it would =
appear that a clock tick in UML is the same as a clock tick on the host =
system. =20

Thus my question is would using gettimeofday in UML be a good way =
comparing performance in UML to performance on the host?  Are there any =
better ways of measuring how long something takes in UML?

Thanks in advance,

David Lie
------=_NextPart_000_0005_01C418DC.71467090
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello all:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm part of a research group at the =
University of=20
Toronto doing research using UML.&nbsp; </FONT><FONT face=3DArial =
size=3D2>I'd like=20
to measure the performance of applications running in UML vs. on Native=20
Linux.&nbsp; Since the implementation of sys_time seems to end up being =
a call=20
to gettimeofday on the host system, it would appear that a clock tick in =
UML is=20
the same as a clock tick on the host system.&nbsp; </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thus my question is would using =
gettimeofday in UML=20
be a good way comparing performance in UML to performance on the =
host?&nbsp; Are=20
there any better ways of measuring how long something takes in =
UML?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks in advance,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>David Lie</FONT></DIV></BODY></HTML>

------=_NextPart_000_0005_01C418DC.71467090--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
