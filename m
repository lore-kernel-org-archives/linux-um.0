MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <546F3EDD.1000007@gmx.de>
References: <546CCE10.4010007@gmx.de>
	<CAFLxGvzYBRM3gos1OwkPfihCc_GPUuPs=Quu42rBd6NnrfFKEQ@mail.gmail.com>
	<546F3EDD.1000007@gmx.de>
Date: Fri, 21 Nov 2014 15:20:06 +0100
Message-ID: <CAMuHMdUX29aKAgH5Qy7OF16c2ChWtgg_vDrdcfmAjBgaZ9GR1A@mail.gmail.com>
Subject: Re: [uml-devel] starting an UML image sometimes failed, next
 (identical) attempt works
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, UML devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Nov 21, 2014 at 2:32 PM, Toralf F=C3=B6rster <toralf.foerster@gmx.d=
e> wrote:
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index e8ab93c..22390f9 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -508,19 +508,25 @@ static inline int ubd_file_size(struct ubd *ubd_dev=
, __u64 *size_out)
>         int sector_size;
>         int bitmap_offset;
>
> +printk(KERN_INFO "ubd_file_size 0");
>         if (ubd_dev->file && ubd_dev->cow.file) {
>                 file =3D ubd_dev->cow.file;
> +printk(KERN_INFO "ubd_file_size 1");
>
>                 goto out;
>         }
>
>         fd =3D os_open_file(ubd_dev->file, of_read(OPENFLAGS()), 0);
> +printk(KERN_INFO "ubd_file_size 2");
>         if (fd < 0)
>                 return fd;
> +printk(KERN_INFO "ubd_file_size 3");

Not really on-topic, but it's faster to add lines like

    pr_info("%s:%u\n", __func__, __LINE__);

They're identical (i.e. copy-'n-paste), but give unique output depending
on context.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

