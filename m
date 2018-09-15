Return-Path: <keescook@chromium.org>
MIME-Version: 1.0
In-Reply-To: <1533358023-5801-2-git-send-email-yamada.masahiro@socionext.com>
References: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com> <1533358023-5801-2-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 15 Sep 2018 11:47:07 -0700
Message-ID: <CAGXu5jK4aNuZ+RR4eC80yUQ2zxSoU9=ioaJBtt=VaX=_oZC=ew@mail.gmail.com>
Subject: Re: [PATCH 1/3] um: fix parallel building with O= option
Content-Type: text/plain; charset="UTF-8"
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Marek <michal.lkml@markovi.net>, Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Fri, Aug 3, 2018 at 9:47 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Randy Dunlap reports UML occasionally fails to build with -j<N> and
> O=<builddir> options.

With v4.19-rc2 I'm still seeing a failure (for any parallelism) under ARCH=um

$ make -j8 ARCH=um O=/tmp/foo
...
/home/kees/src/linux-build/um/Makefile:1185: *** Headers not
exportable for the um architecture.  Stop.

Am I missing something?

-Kees

-- 
Kees Cook
Pixel Security

