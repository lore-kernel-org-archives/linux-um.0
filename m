Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwQZV-0000T2-Ub for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 10:49:21 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AwQBz-0008GI-JJ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 10:25:03 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Problem: copy_thread : pipe failed, err = 24
References: <20040220092607.GA8007@lain.intern.internetx.de>
In-Reply-To: <20040220092607.GA8007@lain.intern.internetx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402261734.11621.blaisorblade_spam@yahoo.it>
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
Date: Thu, 26 Feb 2004 17:34:11 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sebastian Wiesinger <sw@internetx.de>

Alle 10:26, venerd=EC 20 febbraio 2004, Sebastian Wiesinger ha scritto:
> Hello,
>
> I'm using a host system with 9 UML boxes and keep getting the error
>
> copy_thread : pipe failed, err =3D 24

This is EMFILE. Either you "ulimit"ed your UML's (and one UML needs a lot o=
f=20
filehandles) or you need to increase the filehandle limit where it is=20
happening.

> This error appears first after a few hours of running and the boxes
> with this error is no longer reachable.

*Very* strange. If you mean that you can no longer login / do anything that=
=20
needs to create a new process inside UML, I understand it. Otherwise, there=
=20
is something strange. Please try to watch how many open files UML has (ls=20
/proc/<Umlpid>/fd is your friend) and increase filehandles and process limi=
ts=20
(read man proc and search about /proc/sys/kernel for this).

> The following other errors
> also appear:
>
> flush_thread : new thread failed, errno =3D 1
> copy_thread : clone failed - errno =3D 11
> copy_thread : clone failed - errno =3D 1
> copy_thread : clone failed - errno =3D 1

EPERM (very strange) and EAGAIN (too many processes running). Checking the =

source for sys_clone could be needed to diagnose EPERM (unless you have=20
something as GrSecurity active).

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
