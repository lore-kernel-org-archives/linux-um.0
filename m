Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXQbf-0004Ac-6M
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 11:48:15 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AXQbe-0003lE-Ha
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 11:48:14 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH]Modules support in 2.6: reaching the complete fix
References: <200312131828.03645.blaisorblade_spam@yahoo.it> <200312182032.50394.blaisorblade_spam@yahoo.it> <20031218221357.GD4090@ccure.user-mode-linux.org>
In-Reply-To: <20031218221357.GD4090@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312192051.32244.blaisorblade_spam@yahoo.it>
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
Date: Fri, 19 Dec 2003 20:51:32 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 23:13, gioved=EC 18 dicembre 2003, Jeff Dike ha scritto:
> On Thu, Dec 18, 2003 at 08:32:50PM +0100, BlaisorBlade wrote:
> > I'm going to check... the variables are all set with =3D so it should w=
ork,
> > but my problem is that it seems that the arch/um/Makefile is not includ=
ed
> > when it descends in sub-directories.
>
> Hummm, so all the state that's set up by the arch Makefile is made
> available in environment variables to the subdir makes?  That's
> inconvenient.

No, I'm saying the opposite; I haven't had the time to check, but the issue=
=20
I'm afraid of is that the variables I set in the arch/um/Makefile are not=20
visible when used from scripts/Makefile.build(i.e. when descending in=20
subdirs); in that case(i.e. they are not visible) the fix must go into=20
scripts/Makefile.lib.
Note that it's only from a design point of view: I'll have to debug it more=
,=20
since it stopped kernel compilation at the point of compiling=20
scripts/empty.c(which is listed in "always").

> > However, even if it CAN be put there, I think
> > this should NOT happen, and that it should be cleaned enough to be
> > accepted in mainline. Why?
> > I think that it should have to be tuned for each release, and would not
> > be likely to always be tunable(i.e. it could have to be re-engeneered if
> > they change Makefile.lib enough). I don't use in fact an external
> > interface of KBUILD, but I mingle inside its implementation(i.e. I
> > violate encapsulation).
>
> It's UML-specific.  So, if at all possible, it should be in the UML tree,
> not in the generic kbuild.

I'll try, however I still think we should ask to kbuild developers.

To be clean, it must be on arch/um/Makefile for one reason(UML-specific) an=
d=20
scripts/Makefile.lib for another(information hiding-yes, OOP). But=20
cleanlyness means "it can't break"; so actually scripts/Makefile.lib is=20
cleaner IMHO. I'll provide both versions and you decide.

> > I don't agree for "instead". I.e. I think that as the first thing this
> > must be fixed, and then we will go hunting the bug for MODVERSIONS(it
> > needs that we post-process userspace files).
> > After this, then I could do this user space change(I can't promise for
> > now but I hope I'll be able);
>
> When the userspace stuff is all nicely hidden under arch/um/os, then
> whatever fix you have for the build will apply only to that directory.
Yes, I agree on this.
> Maybe it will turn out that it can't be hidden in the arch/um/os Makefile,
> but maybe it can, and that's the right place to put it, if so.
>
> > but it is a bit problematical because KBUILD isn't
> > built to link objects from different directories.
>
> No one is proposing that.
You didn't propose it, but it would be needed (see below).
>
> > Could symlink be accepted as a solution for this(i.e. a symlink from
> > drivers/hostaudio_user.c to some file inside the os/ directory)?
>
> If hostaudio is really Linux-specific, it should just be moved under
> arch/um/os-Linux/drivers along with tuntap and ethertap.

No, hostaudio is OSS-specific, and OSS is portable to many Unices. However =
I=20
don't have experiences of Unices other than Linux.

But that one was just an example.

Let's say I have one module which has one kernel part and one user part(we =

have many examples of this), with a kernel part shared between different=20
OS's. If the kernel part is inside drivers/ and the user part under=20
os/<somewhere>, KBUILD won't work unless we:

1) horribly patch it (what I won't do obviously) to build a module from=20
objects in different folders.

2) create a symlink from drivers/<filename> to os/<filename>. The symlink w=
ill=20
be to os/, not to os-Linux or os-??, so this will work easily. Gcc would be=
=20
called on drivers/<filename>

Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
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
