Return-Path: <richard@nod.at>
Date: Wed, 8 May 2019 09:13:07 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <684874198.48863.1557299587958.JavaMail.zimbra@nod.at>
In-Reply-To: <0e8fbdf3-c40d-e4e8-6235-c744ec7317c3@cambridgegreys.com>
References: <20190411094944.12245-1-brgl@bgdev.pl> <20190411094944.12245-5-brgl@bgdev.pl> <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com> <0e8fbdf3-c40d-e4e8-6235-c744ec7317c3@cambridgegreys.com>
Subject: Re: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: anton ivanov <anton.ivanov@cambridgegreys.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Jeff Dike <jdike@addtoit.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-um@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

----- Urspr=C3=BCngliche Mail -----
>> Can you please check?
>> This patch is already queued in -next. So we need to decide whether to
>> revert or fix it now.
>>=20
> I am looking at it. It passed tests in my case (I did the usual round).

It works here too. That's why I never noticed.
Yesterday I noticed just because I looked for something else in the kernel =
logs.

Thanks,
//richard

