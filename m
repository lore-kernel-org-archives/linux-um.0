Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aw4Rk-0001k4-9p for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 11:11:52 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Aw45d-0004wM-T8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 10:49:02 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: skas and vserver on 2.4.25 (Re: [uml-devel] new skas3 patch ready
	for 2.4.25)
References: <40338C1B.1070800@meisterwerk.net>
	<200402202125.58574.blaisorblade_spam@yahoo.it>
	<20040223063021.GC31430@woodcut.kpac.co.nz>
In-Reply-To: <20040223063021.GC31430@woodcut.kpac.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402251654.39366.blaisorblade_spam@yahoo.it>
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
Date: Wed, 25 Feb 2004 16:54:39 +0100
Content-Transfer-Encoding: quoted-printable
To: Nicholas Lee <nic-lists@plumtree.co.nz>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 07:30, luned=EC 23 febbraio 2004, Nicholas Lee ha scritto:
> On Fri, Feb 20, 2004 at 09:25:57PM +0100, BlaisorBlade wrote:
> > Yes, it went away, so a new skas patch must be built. I have one (teste=
d)
> > at http://www.user-mode-linux.org/~blaisorblade/
>
> Using this patch against against 2.4.25 with evmns, libata and the
> vserver patch, I get the following compilation error:-

You mean libata for Serial ATA support, EVMS from IBM as a LVM+RAID, right?=
=20
But what is vserver?

>
> nic@stateless:/usr/src/linux-2.4.25-vs1.3.7/mm$ gcc -D__KERNEL__
> -I/usr/src/linux-2.4.25-vs1.3.7/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
> -pipe -mpreferred-stack-boundary=3D2 -march=3Di686   -nostdinc -iwithpref=
ix
> include -DKBUILD_BASENAME=3Dproc_mm  -c -o proc_mm.o proc_mm.c proc_mm.c:=
 In
> function `open_proc_mm':
> proc_mm.c:109: error: too few arguments to function `mm_alloc'
>
>
> mm_alloc seems to come from:
>
> <linux/sched.h>
> ...
> extern struct mm_struct * mm_alloc(struct vx_info *);
>
>
> vx_info is defined in <linux/vserver/context.h>
>
>
> Looks like vserver has redefined:-
>
> -extern struct mm_struct * mm_alloc(void);
> +extern struct mm_struct * mm_alloc(struct vx_info *);
>
>
> I don't know the kernel well enough to add the appropiate call to:
>
> static int open_proc_mm(struct inode *inode, struct file *file)
> {
>         struct mm_struct *mm =3D mm_alloc();
>
> I'm guessing it might be something like
>
>                mm_alloc(current->vx_info);

If you want to try yourself: "current" type is struct task_struct *, which =
is=20
defined in linux/sched.h; check if a such member is defined in that struct,=
=20
and if it is so you can try doing what you suggest and running the resultin=
g=20
kernel. But you could also "learn by samples": look in the "vserver" patch =

how the new mm_alloc is used, and what vx_info stands for (i.e. - what fiel=
ds=20
it contains and when mm_alloc is passed something different than=20
current->vx_info).

However, if you want something reliable enough, post a pointer to the exact=
=20
patch file that you applied for "vserver", and a description of what it doe=
s=20
(an URL describing it or the "vserver" project homepage could suffice for t=
he=20
description). If I have time I could answer you saying what you do, i.e. if=
 a=20
such change can suffice or if the two patches interfere too much.

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
