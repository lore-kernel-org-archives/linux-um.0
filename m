Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AY5Rc-0007GJ-RA
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 07:24:36 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AY5Rc-0002NV-5h
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 07:24:36 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [UML combo patch] 2.6.0 host-skas kernel & UML kernel patch
References: <Pine.LNX.4.58.0312171735540.8123@earth> <200312191959.27377.blaisorblade_spam@yahoo.it> <20031219211630.GA31977@elte.hu>
In-Reply-To: <20031219211630.GA31977@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312201657.24376.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Sat, 20 Dec 2003 16:57:38 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 22:16, venerd=EC 19 dicembre 2003, Ingo Molnar ha scritto:
> * BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
> > > WARNING: this is an experimental patch, UML kernels compiled with this
> > > patch wont work in skas mode on older host-skas patched kernels.

You mean that they won't work on 2.4 SKAS kernels or on 2.6 skas kernels=20
without your change(i.e. there have been some other ports of Skas to 2.5/2.=
6,=20
which didn't touch the actual code logic)? If I've understood you correctly=
,=20
you must just re-add the MM_COPY_SEGMENTS call in the UML arch, while still=
=20
making its implementation in the i386 arch as a no-op, to make us happy.=20
Right? Could you do this?

> > Does this warning refers to any of the other patches you posted? To
> > which one especially? Is this related to the removal of
> > MM_COPY_SEGMENTS ?
>
> yes, it refers mostly to the removal of MM_COPY_SEGMENTS.

> > Also, if there is any incompatibility, it should be named skas4. But
> > since Jeff Dike's will release skas4, even improving skas3 by breaking
> > compatibility is not useful. And if it is accepted, it should at least
> > be released also for 2.4(the guest 2.4/2.6 choice must be unrelated to
> > the host choice).
>
> skas4 will be nice, and since it will most likely be 2.6 based (?), it
> doesnt have the copy_segments problem.

The patch is very useful, but I think that at least the MM_COPY_SEGMENTS=20
change should be split out, since it is not backward compatible. Anything=20
required to fix a bug can be put inside, but preserving it. So preserve=20
binary compatibility with old host-skas kernels and old guest kernels.

Jeff has already refused patches for skas3(a cleanup actually, the one of=20
renaming do_mmap_pgoff as __do_mmap_pgoff as I said you), which hadn't got =

any problem, just because he wants to release skas4.

Such a speedup could be useful maybe for skas4, but only maybe(i.e. since=20
skas4 will have to be for 2.4 also, I think that MM_COPY_SEGMENTS can be ma=
de=20
a no-op, but the guest must call it).

In fact, I think he planned skas 4 for 2.4; he said also it is almost ready=
,=20
just has some problems with the two new syscall numbers. And UML developmen=
t=20
is still mainly on 2.4; fixes are applied currently on 2.4 tree, and at som=
e=20
moment will appear on the 2.6 one.

However, the one to refer to for such issues is actually Jeff Dike; this is=
=20
only my VERY HUMBLE opinion; I'm answering just because I've been lurking o=
n=20
the ML's from enough time to understand the Jeff's plans.

> Jeff, do you know how the new skas4 syscall API will look like, exactly?
>
> 	Ingo

He mentioned that /proc/mm will be removed, and there will be two new=20
syscalls: one will be to create a new address space, and the second will be=
=20
to use a certain context(i.e. a certain mm_struct) for any syscall from the=
=20
guest to the host(I am not able to find his message, so this is what I=20
remember). This design was agreed on by Jeff and Linus.

Btw: some changes in your patch are just build-generated files(headers, and=
=20
symlinks in the arch/um/sys-i386 dir). Pay attention to making clean(or=20
mrproper) next time before creating the patch. If you get some error from=20
"sh" about SIZE and shell arithmetic, it's already fixed(in a thread from a=
=20
few days ago).

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
