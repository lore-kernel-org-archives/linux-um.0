Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adwpm-0003Im-UY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 11:25:46 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Adwpm-0005nN-9I for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 11:25:46 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: 2.6-specific UML patches (modules, modversions,
	various other stuff)
References: <200401061921.00054.blaisorblade_spam@yahoo.it>
	<200401061909.i06J9ctd003026@ccure.user-mode-linux.org>
In-Reply-To: <200401061909.i06J9ctd003026@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401062024.28475.blaisorblade_spam@yahoo.it>
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
Date: Tue, 6 Jan 2004 20:24:28 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:09, marted=EC 6 gennaio 2004, Jeff Dike ha scritto:
> blaisorblade_spam@yahoo.it said:
> > There you will find a number of patches for UML 2.6. Some are mine and
> > some  come from Ingo and M A Young; I've included everything Ingo
> > posted minus the  speedup - breakage for 2.4 host. That is,
> > MM_COPY_SEGMENTS is still called by  UML but if the host is a 2.6 that
> > is a no-op.
>
> There's a lot of old stuff in that patch.  It would be more useful to me =
if
> it were against a recent UML patch, like the 2.6.0 patch that I'm working
> on at the moment.  That has all the recent 2.4 changes pulled in as well =
as
> updating to 2.6.0.  A patch containing the stuff that you have that I don=
't
> would be useful.

I've not got your patch, as I'm not a wizard :-), but the split patches sho=
uld=20
be ok(also you can choose only what you like easily). Just don't take neith=
er=20
the combo nor the A-* patches (they just contain the stuff from the -test9 =

patch). And remove the changes I pointed out as A-03 and A-04 in the origin=
al=20
message.

Did you read my question about the change inside mm/memory.c you did?

> Some more specific things -
> 	I'm not going to update the skas3 patch again, but I'm glad people are
> cleaning it up and updating it.
Ok, that is inside E* and F* patches. I've worked on split-up because anywa=
y=20
those bit couldn't go in mainline (while I hope that Andrew Morton will soo=
n=20
accept the UML patch...)

> 	I don't like the UML_USER_OBJS thing - feel free to work on it, but
> I'm not going to merge it unless I'm desperate.  I continue to think that
> the right way to go is to move all the userspace stuff under os-Linux, th=
en
> fiddle the build rules there.

Just note that without that CONFIG_MODVERSIONS maybe doesn't work (kbuilds =

postprocess the files with modversions, see scripts/Makefile.lib, but not=20
without that rule). Actually, I've fixed the link scripts too before=20
obtaining success with modversions (I didn't test before), and maybe so tha=
t=20
is not needed. Also, nothing need that patch apart H-03 - another kbuild=20
cleanup, much less intrusive; most of it makes still sense, but it will hav=
e=20
too much rejects; I'll later post a more up-to-date version of it. H-04 (th=
e=20
Pcap fix) should apply anyhow.

About your idea: that is meaningful, but hostfs and other stuff can be buil=
t=20
as modules. Then is what you get in that way:

1) hostfs_user goes into os-Linux
2) hostfs_kern remains inside fs/hostfs
3) kbuild will refuse to link together hostfs_user and hostfs_kern inside a=
=20
module.
However, this can be solved by making 2 separate modules... (and playing wi=
th=20
exports between modules if needed).

Also, that doesn't remove the need for fiddling with main kbuild=20
infrastructure, since otherwise:
1) either you duplicate a lot of stuff from main Makefiles for .c -> .o rule
2) or you change the c_flags variables from arch/um/os-Linux makefile,=20
fiddling with, but that is fragile as that is an undocumented interface.

Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
