MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <201010181105.17077.toralf.foerster@gmx.de>
References: <201010131328.06465.toralf.foerster@gmx.de>
	<201010171555.40453.toralf.foerster@gmx.de>
	<20101017201837.GA16458@lst.de>
	<201010181105.17077.toralf.foerster@gmx.de>
Date: Mon, 18 Oct 2010 11:09:50 +0200
Message-ID: <AANLkTik0dP0hs-a6ofna_UFk8dbzfqzPwD5OzDVhPGBV@mail.gmail.com>
Subject: Re: [uml-devel] Fwd: Re: UML kernel crash of v2.6.36-rcX kernel
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: Christoph Hellwig <hch@lst.de>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2010/10/18 Toralf F=C3=B6rster <toralf.foerster@gmx.de>:
> Well, in addition to my last mail the following patch isn't a fix, but it
> might point to the culprit.
> If I apply this patch against latest tree, then the crash doesn't occur :
>
> diff --git a/include/linux/statfs.h b/include/linux/statfs.h
> index 0166d32..e336e70 100644
> --- a/include/linux/statfs.h
> +++ b/include/linux/statfs.h
> @@ -15,8 +15,8 @@ struct kstatfs {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__kernel_fsid_t f_fsid;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0long f_namelen;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0long f_frsize;
> - =C2=A0 long f_flags;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0long f_spare[4];
> + long f_flags;
> =C2=A0};

So it probably is accessing f_spare[4] somewhere...

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

