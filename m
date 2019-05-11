Return-Path: <brgl@bgdev.pl>
MIME-Version: 1.0
References: <20190411094944.12245-1-brgl@bgdev.pl> <20190411094944.12245-5-brgl@bgdev.pl>
 <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com>
 <0e8fbdf3-c40d-e4e8-6235-c744ec7317c3@cambridgegreys.com> <684874198.48863.1557299587958.JavaMail.zimbra@nod.at>
 <CAMRc=MdsA7A1DdS1ZJ8NS8xtuCjgc_7WZD1797H3oZ=2w+fOBA@mail.gmail.com>
 <CAMRc=McCxvwHgk-3wYE0e+qxJNoHK0AmpJWjNsOZBmGF2yFT6Q@mail.gmail.com> <c5918fa9-ec37-9636-5230-57260f7e8427@cambridgegreys.com>
In-Reply-To: <c5918fa9-ec37-9636-5230-57260f7e8427@cambridgegreys.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 11 May 2019 14:48:58 +0200
Message-ID: <CAMRc=MeOHr0bKJYGgOrhHq4dYFwCnpYvuFAL3jZerwCPvQgC3Q@mail.gmail.com>
Subject: Re: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Richard Weinberger <richard@nod.at>, Richard Weinberger <richard.weinberger@gmail.com>, Jeff Dike <jdike@addtoit.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-um@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

pt., 10 maj 2019 o 18:22 Anton Ivanov
<anton.ivanov@cambridgegreys.com> napisa=C5=82(a):
>
>
> On 10/05/2019 17:20, Bartosz Golaszewski wrote:
> > pt., 10 maj 2019 o 11:16 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
> >> =C5=9Br., 8 maj 2019 o 09:13 Richard Weinberger <richard@nod.at> napis=
a=C5=82(a):
> >>> ----- Urspr=C3=BCngliche Mail -----
> >>>>> Can you please check?
> >>>>> This patch is already queued in -next. So we need to decide whether=
 to
> >>>>> revert or fix it now.
> >>>>>
> >>>> I am looking at it. It passed tests in my case (I did the usual roun=
d).
> >>> It works here too. That's why I never noticed.
> >>> Yesterday I noticed just because I looked for something else in the k=
ernel logs.
> >>>
> >>> Thanks,
> >>> //richard
> >> Hi,
> >>
> >> sorry for the late reply - I just came back from vacation.
> >>
> >> I see it here too, I'll check if I can find the culprit and fix it tod=
ay.
> >>
> >> Bart
> > Hi Richard, Anton,
> >
> > I'm not sure yet what this is caused by. It doesn't seem to break
> > anything for me but since it's a new error message I guess it's best
> > to revert this patch (others are good) and revisit it for v5.3.
>
> Can you send me your command line and .config so I can try to reproduce i=
t.
>

Sure,

the command line is:

./linux rootfstype=3Dhostfs rootflags=3D<path to a regular buildroot
rootfs> rw mem=3D48M

The config is the regular x86_64_defconfig from arch/um.

Bart

