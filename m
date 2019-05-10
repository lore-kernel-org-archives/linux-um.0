Return-Path: <brgl@bgdev.pl>
MIME-Version: 1.0
References: <20190411094944.12245-1-brgl@bgdev.pl> <20190411094944.12245-5-brgl@bgdev.pl>
 <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com>
 <0e8fbdf3-c40d-e4e8-6235-c744ec7317c3@cambridgegreys.com> <684874198.48863.1557299587958.JavaMail.zimbra@nod.at>
In-Reply-To: <684874198.48863.1557299587958.JavaMail.zimbra@nod.at>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 10 May 2019 11:16:51 +0200
Message-ID: <CAMRc=MdsA7A1DdS1ZJ8NS8xtuCjgc_7WZD1797H3oZ=2w+fOBA@mail.gmail.com>
Subject: Re: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Richard Weinberger <richard@nod.at>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard.weinberger@gmail.com>, Jeff Dike <jdike@addtoit.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-um@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

=C5=9Br., 8 maj 2019 o 09:13 Richard Weinberger <richard@nod.at> napisa=C5=
=82(a):
>
> ----- Urspr=C3=BCngliche Mail -----
> >> Can you please check?
> >> This patch is already queued in -next. So we need to decide whether to
> >> revert or fix it now.
> >>
> > I am looking at it. It passed tests in my case (I did the usual round).
>
> It works here too. That's why I never noticed.
> Yesterday I noticed just because I looked for something else in the kerne=
l logs.
>
> Thanks,
> //richard

Hi,

sorry for the late reply - I just came back from vacation.

I see it here too, I'll check if I can find the culprit and fix it today.

Bart

