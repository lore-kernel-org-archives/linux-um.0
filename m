MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <201010181043.14253.toralf.foerster@gmx.de>
References: <201010131328.06465.toralf.foerster@gmx.de>
	<201010171555.40453.toralf.foerster@gmx.de>
	<20101017201837.GA16458@lst.de>
	<201010181043.14253.toralf.foerster@gmx.de>
Date: Mon, 18 Oct 2010 11:08:11 +0200
Message-ID: <AANLkTin8v5bKFSDkYqwBk6+id3tyucotBz+amvEdtf+8@mail.gmail.com>
Subject: Re: Fwd: Re: UML kernel crash of v2.6.36-rcX kernel
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: Christoph Hellwig <hch@lst.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2010/10/18 Toralf F=C3=B6rster <toralf.foerster@gmx.de>:
>
> Christoph Hellwig wrote at 22:18:37
>> I really can't see any relation to the patch. =C2=A0Can you try the some
>> things in the following order, please:
> ...
>> =C2=A0(4) re-apply the include/linux/statfs.h changes and see if it stil=
l
>> =C2=A0 =C2=A0 =C2=A0 boots
>
> The first half of step 4 was it (I did not apply the "Definitions for the=
 flag
> in f_flag.") :
>
> diff --git a/include/linux/statfs.h b/include/linux/statfs.h
> index b34cc82..0166d32 100644
> --- a/include/linux/statfs.h
> +++ b/include/linux/statfs.h
> @@ -2,7 +2,6 @@
> =C2=A0#define _LINUX_STATFS_H
>
> =C2=A0#include <linux/types.h>
> -
> =C2=A0#include <asm/statfs.h>
>
> =C2=A0struct kstatfs {
> @@ -16,7 +15,29 @@ struct kstatfs {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__kernel_fsid_t f_fsid;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0long f_namelen;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0long f_frsize;
> - =C2=A0 long f_spare[5];
> + long f_flags;
> + long f_spare[4];
> =C2=A0};

That should only matter for code that accesses the former fifth
element of f_spare[].
fs/compat.c:put_compat_statfs(struct compat_statfs __user *ubuf,
struct kstatfs *kbuf) does that:

            __put_user(0, &ubuf->f_spare[0]) ||
            __put_user(0, &ubuf->f_spare[1]) ||
            __put_user(0, &ubuf->f_spare[2]) ||
            __put_user(0, &ubuf->f_spare[3]) ||
            __put_user(0, &ubuf->f_spare[4]))

Seems struct compat_statfs* may have 4, 5, or 6 elements in the f_spare[] a=
rray,
depending on the architecture.

> FWIW the uml kernel boots fine even with that commit however it crashed a=
fter
> a special http request : $> wget http://n22_uml/phpsysinfo/

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds

