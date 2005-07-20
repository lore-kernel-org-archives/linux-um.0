Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dv9gq-0000jr-AA	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jul 2005 01:12:28 -0700
Received: from web131873-3.gw.connect.com.au ([210.11.57.5]
	helo=newbushfire.webwombat.com.au)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1Dv9gp-0002qM-Kv	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Jul 2005 01:12:28 -0700
Received: from phill2knb ([10.1.1.60])j6K8CKg19257
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 20 Jul 2005 18:12:20 +1000
Message-ID: <003e01c58d02$c06c6f30$3c01010a@webwombat.com.au>
From: "Phill Wombat" <uml@webwombat.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_003B_01C58D56.920174C0"
Subject: [uml-devel] RE:2.6.12-bs7 hanging after init
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
Date: Wed, 20 Jul 2005 18:12:20 +1000
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_003B_01C58D56.920174C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alessio,

I have precisly what you describe here.

I'm using Fedora Core 4 with SKAS3 on both a twin 686 Dell and also in =
x86_64 mode on an IBM x336.

The UML kernel is 2.6.12 patched with bs7.

When running in tt mode both systems hang at init.

Like you I also can run /bin/sh, /bin/bash, and even init=3D"/bin/ls =
-lsa" and it all works, *until* it needs to start another process.

I have FC4 running in SKAS mode on the dell twin in 32 bit mode. =
However, SKAS3 is not up and running yet (from what I understand) on =
x86_64 hosts, so I only have TT mode available to me for that machine =
architecture (eventhough SKAS3 compiled in ok and is detected).

From what you've done and what I've done (which I posted on the =
user-list) it seems your conclusions are pretty close to the mark from =
my reading.

Everything you describe is happening to me.

Sorry this doesn't help. I think right now your only option is to go =
SKAS3 on a 32 bit host, and SMP works ok. It's also beyond my =
understanding to into the guts of the kernel and figure it out.

Cheers
Phill.
------=_NextPart_000_003B_01C58D56.920174C0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi Alessio,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have precisly what you describe=20
here.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm using Fedora Core 4 with SKAS3 on =
both a twin=20
686 Dell and also in x86_64 mode on an IBM x336.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The UML kernel is 2.6.12 patched with=20
bs7.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>When running in tt mode both systems =
hang at=20
init.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Like you I also can run /bin/sh, =
/bin/bash, and=20
even init=3D"/bin/ls -lsa" and it all works, *until* it needs to start =
another=20
process.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have FC4 running in SKAS mode on the =
dell twin in=20
32 bit mode. However, SKAS3 is not&nbsp;up and running yet (from what I=20
understand) on x86_64 hosts, so I only have TT mode available to me for =
that=20
machine architecture (eventhough&nbsp;SKAS3 compiled in ok and is=20
detected).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>From what you've done and what I've =
done (which I=20
posted on the user-list) it seems your conclusions are pretty close to =
the mark=20
from my reading.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Everything you describe is happening to =

me.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Sorry this doesn't help. I think right =
now your=20
only option is to go SKAS3 on&nbsp;a 32 bit&nbsp;host, and SMP works ok. =
It's=20
also beyond my understanding to into the guts of the kernel and figure =
it=20
out.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Cheers</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Phill.</FONT></DIV></BODY></HTML>

------=_NextPart_000_003B_01C58D56.920174C0--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
