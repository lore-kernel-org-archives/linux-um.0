Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1As13Q-0001Wo-PS
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 14 Feb 2004 06:46:00 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1As0xJ-0004UV-Ta
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 14 Feb 2004 06:39:42 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] UML (unofficial) patches against vanilla 2.6.2
References: <200402052107.37625.blaisorblade_spam@yahoo.it> <200402130523.i1D5NTgR005420@ccure.user-mode-linux.org>
In-Reply-To: <200402130523.i1D5NTgR005420@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402141545.14765.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 14 Feb 2004 15:45:14 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 06:23, venerd=EC 13 febbraio 2004, Jeff Dike ha scritto:
> blaisorblade_spam@yahoo.it said:
> > I've updated my patches for modules and so on to 2.6.2. Since the main
> > Uml  patch against 2.6.1 needs some easy-but-not-trivial changes to
> > work onto  2.6.2
>
> OK, I'm finishing merging this in.
>
> I don't understand what you're doing with G-02-LinkScriptCleanup.patch.=20
> The stuff you're adding to vmlinux.lds.S is only needed for the final
> binary, which isn't built by this script.

I understand your point, but the "kallsyms" step is done on the vmlinux=20
binary, not on the "linux" one, and it thinks that text symbols are between=
=20
_stext and _etext; so you need at least to set correctly _stext and _etext,=
=20
so the definition of the first must be added and the section .text must be =

put in the middle. If you look at the preprocessed vmlinux.lds.s, you'll se=
e=20
that it means _etext =3D 0. This creates problem for /proc/kallsyms, for th=
e=20
kernel oopses decoding, and possibly other stuff; anyway, I don't see why=20
avoiding the fix.

> The next three hunks are also
> somewhat obscure.

Just cleanups and resyncs with the original linker scripts used by ld (i.e.=
=20
setting the empty space to 0x90=3D NOP)

> The final one is merged.

> I don't like H-01-Pcap_link_fix.patch.  As much as that fixes pcap, we
> really need to find a fix that's local to arch/um/drivers.  I'll merge th=
is
> only as a last-ditch thing if it becomes clear that there is no other way.

*Note*: in that patch, I forgot to un-uncomment pcap-objs in arch/um/driver=
s=20
(I then fixed that, I don't know which version is there).
For this, I hope I can build a more general mechanism to do the same thing.

However that is not easy, since sub makefiles cannot set variables for the =

main Makefile (and in the kbuild process they are used after). Changing thi=
s=20
would be much more crappy.

> H-02-Fixdep-improve.patch is similar, except it's not clear to me what
> you're fixing.  Here also, I don't want to munge the global kbuild with
> UML special cases.

If you change one setting in the .config, every file including=20
arch/um/uml-config.h is marked as needing rebuild (maybe that  even means t=
he=20
whole kernel); since that is like autoconfig.h, with that patch it's treate=
d=20
in the same way. Since uml-config.h basically cannot go away,

> In H-04-Kbuild_cleanup.patch, the skas/Makefile patch isn't obviously an
> improvement over what's already there.
A resync against main Makefile (and more coherency in the output); sadly, t=
hat=20
utility is not put inside Makefile.lib, so I had to duplicate it.

> In arch/um/Makefile, what's that @:
> doing?  A quiet true?
I wanted to specify an empty command list, so I did it as for sys_prepare=20
target.
>  I left out the commented stuff.
That's perfectly ok.=20
>  Send it back in
> when you're sure what you want there.

> As for I-01-Debian_workaround.patch, I had the impression that this was
> caused by a Debian bug.

It's a name change in the kernel headers, in the same way as for hostfs_use=
r.c=20
(and even the fix is the same one).

> If so, they should fix it, and I shouldn't have
> to put workarounds in UML for it.
>
> 				Jeff


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
