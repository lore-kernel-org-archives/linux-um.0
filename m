Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuHvz-0002nh-EL for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 13:11:43 -0800
Received: from [69.93.28.254] (helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AuHpw-0002NJ-J4 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 13:05:28 -0800
Subject: Re: [uml-devel] [PATCH] skas3 for x86_64 arch
From: Matt Ayres <matta@tektonic.net>
In-Reply-To: <200402202155.44773.blaisorblade_spam@yahoo.it>
References: <1077305069.8412.62.camel@wopr.tektonic.net>
	<200402202155.44773.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <1077311125.8412.78.camel@wopr.tektonic.net>
Mime-Version: 1.0
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
Date: Fri, 20 Feb 2004 16:05:26 -0500
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 2004-02-20 at 15:55, BlaisorBlade wrote:
> Alle 20:24, venerd=EC 20 febbraio 2004, Matt Ayres ha scritto:
> > Hi,
> >
> > I just did a quick port of the skas3 patch to the x86_64 architecture.
> > Everything seems very straightforward except for the do_mmap2 function.
>=20
> Sorry, but you've changed the prototype of sys32_mmap2 by adding the mm=20
> parameter (which goes only on do_mmap2). So it cannot possibly compile.

That area confuses me, I can't find anything in the kernel that actually
uses sys32_mmap2.  I've changed it for compatibility, but i'm not sure
how it will work.  do_mmap2 doesn't exist for x86_64.  do_mmap2 did
exist in kernel 2.4.20 and I simply copied the code from there.  I've
uploaded a new patch,
https://www.tektonic.net/public/linux-2.4.25-x86_64-skas3.patch.  I
wasn't using the updated skas patch for 2.4.25 so it wouldn't have
worked anyway.  The main problem I think is that skas changes the
do_mmap_pgoff function, so I had to update the arch/x86_64/sys_x86_64.c
file also where I don't even think it will actually touch any code in
that file as UML will be running in 32-bit mode.



>=20
> Have you tried a cross build with make ARCH=3Dx86_64 ? I'm not sure if th=
at can=20
> work or requires cross-compilators, but maybe not.

Yes, I tried that and got an error very early saying it can't be done.=20
The x86_64 emulator seems to cost money.  I'll have to see if i'm using
a cross compiler or not, I always thought gcc had that enabled by
default.

--=20
Matt Ayres <matta@tektonic.net>
TekTonic



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=3D1356&alloc_id=3D3438&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
