Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AeJ6C-0006K4-Hr for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jan 2004 11:12:12 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AeJ6B-0006YF-Pq for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jan 2004 11:12:11 -0800
From: BlaisorBlade <blaisorblade_work@yahoo.it>
References: <200312242019.23335.blaisorblade_work@yahoo.it>
	<200401062038.37402.blaisorblade_work@yahoo.it>
	<20040106202145.GA11953@mars.ravnborg.org>
In-Reply-To: <20040106202145.GA11953@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401072012.05007.blaisorblade_work@yahoo.it>
Subject: [uml-devel] Re: [kbuild-devel] Needed help for UML kbuild.
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
Date: Wed, 7 Jan 2004 20:12:04 +0100
Content-Transfer-Encoding: quoted-printable
To: Sam Ravnborg <sam@ravnborg.org>
Cc: kbuild-devel@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Alle 21:21, marted=EC 6 gennaio 2004, hai scritto:
> > I'm posting this as reminder... however the UML naintainer said that the
> > special treatment (which remains the same) must happens for a different
> > file set, i.e. all the files below one folder.
>
> Thanks - and it was needed.
> I have shifted mailer since the first mail.
> Can you please send the patch once more.

Ok, I'm sending them privately to you.
If you want to actually compile UML(the code in mainline is outdated) to de=
bug=20
the Makefiles, here is a patch to apply onto vanilla 2.6.0 to get a working=
=20
UML:

http://web.tiscali.it/no-redirect-tiscali/blaisorblade/linux/archives/UML/v=
8/00-Combo-v8.bz2

In that patch, there is a lot of stuff including *this* patch. If you need =
to=20
back it out, you can find it as H-Makefiles/H-02-User_obj_makefiles.patch(b=
ut=20
to unapply it you must unapply first H-04, then H-03 and finally H-02).

The "main" patch is the core infrastructure, while the "stuff" one is the=20
patch for all Makefiles under arch/um to use the new scheme.

However, this patch is built using the idea of selecting *_user.c + the fil=
es=20
which are explicitly asked. Note that this is what is currently implemented=
=20
inside UML; the current version is however unclean and broken (since it=20
doesn't use the kbuild, it doesn't either do the post-process stage for=20
modversions).

> Also, can you point me to a directory where the different CFLAGS are
> needed. Just to let me browse through what is present in the kernel src
> today.
Currently there is not a single directory, but a set of files. See for=20
instance arch/um/drivers/*_user.c.=20

A clearer rationale: If something inside the UML must, i.e., write to a=20
console, UML must send the request to the host device corresponding to that=
=20
console(an xterm in most cases). So, we have some code which interacts with=
=20
the tty layer on the kernel side(xterm_kern.c in that folder), and then=20
another file (xterm.c in the some folder) which is the userspace part that =

runs on the host, and that will link against the host's userspace header an=
d=20
libc code.

Libc isn't an issue here, but gcc must search /usr/include and not=20
<linuxTree>/include for include files.

Then, the UML maintainer (Jeff Dike) pointed out that as a further cleanup,=
 he=20
wants to move the *_user.c in arch/um/os-Linux, since when UML is compiled =
to=20
run onto another OS as host system (that will happen, a separate port onto =

Win32 exists) a different version of those files will probably be needed. S=
o=20
a separate Makefile could be used.

I agree about moving the files, indeed, BUT there is a problem for modules:

some modules(i.e. hostaudio) are built from a "userspace" (needing the spec=
ial=20
treatment) file and a "kernel" (to be compiled as usual) file. How will=20
kbuild link them together?

I have three workarounds:
- split the module into 2 separate ones, with the kernel one requiring the =

other. BUT a lot of EXPORT_SYMBOLS should be added (one for each function=20
inside the userspace file at least)
- create a symlink from arch/um/drivers/hostaudio_user.c(old place) to=20
arch/um/os/drivers/hostaudio_user.c (new place) and pass the symlink to gcc.
This must be done only when the file will be part of a module.
Note that arch/um/os is a symlink to arch/um/os-{Linux, Win, any OS needed}.
- (worst option) make kbuild link together objects from different folders=20
inside one module. But I don't like this and I guess this would never be=20
accepted (this is against a fundamental kbuild assumption, IIRC).

The idea I currently prefer is the second one, even if the implementation c=
an=20
be a little more intrusive. The UML maintainer was of the idea of a separat=
e=20
Makefile, but I've not yet got an answer about the module issue.

> What I have in mind may be a specific Makefile.uml instead.
> We did that for klibc with success.
>
> [See klic.bkbits.net]
I've given a quick look, but that seems a bit too much unrelated (i.e. that=
=20
doesn't link with the kernel!). However doing a separate Makefile can be ok=
,=20
if that doesn't go changing c_flags or such variables from Makefile.lib=20
(which would be fragile).

Bye and thanks for interest!
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
