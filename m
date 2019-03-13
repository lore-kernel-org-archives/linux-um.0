MIME-Version: 1.0
Date: Wed, 13 Mar 2019 11:11:08 +0100
References: <20190312133047.16201-1-brgl@bgdev.pl>
	<56704758-ee74-0e9b-de1c-1dc94deda8d7@cambridgegreys.com>
	<CAMRc=MdRKvM8ug_KNcwUGHv9J6OLFa1o_WaCbebxWUGyGVZtiw@mail.gmail.com>
In-Reply-To: <CAMRc=MdRKvM8ug_KNcwUGHv9J6OLFa1o_WaCbebxWUGyGVZtiw@mail.gmail.com>
Message-ID: <CAMuHMdXC5QffaOj479j3WCt5_GH2jeQnGrPoCrRPoFkHmFeDfw@mail.gmail.com>
Subject: Re: [PATCH] um: remove uses of variable length arrays
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

Hi Bartosz,

On Wed, Mar 13, 2019 at 10:50 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> =C5=9Br., 13 mar 2019 o 10:45 Anton Ivanov
> <anton.ivanov@cambridgegreys.com> napisa=C5=82(a):
> > PID can be more than 5 digits nowdays.
>
> Do we have a macro in the kernel that yields the minimum size of an
> array to fit a number? I can't find it. I vagely remember seeing
> something like this in systemd tree. If it doesn't exist in the kernel
> then maybe we should copy it over.

1 + const_ilog2(n) / log2(10) =3D 1 + const_ilog2(n) / 3.321928

Using fixed point calculations, that can be approximated as

    1 + 19728 * const_ilog2(n) >> 16
    1 + 77 * const_ilog2(n) >> 8

(the factors might be one off)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

