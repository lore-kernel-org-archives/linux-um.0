Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hP2qq-0006EN-Fj
 for linux-um@lists.infradead.org; Fri, 10 May 2019 10:34:05 +0000
Received: by mail-oi1-x241.google.com with SMTP id l203so4186230oia.3
 for <linux-um@lists.infradead.org>; Fri, 10 May 2019 03:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-7-brendanhiggins@google.com>
 <CAK7LNAQ+SRMn8UFjW1dZv_TrL0qjD2v2S=rXgtUpiA-urr1DDA@mail.gmail.com>
 <CAFd5g47BNZ0gRz4SXb37XjyXF_LyNZrSmoqDbzaaCUrTg3O7Yg@mail.gmail.com>
 <CAK7LNAR3DW5UxtsTNtW6mtQic8cukJwJ18=KitC2HX+jO5eo4g@mail.gmail.com>
In-Reply-To: <CAK7LNAR3DW5UxtsTNtW6mtQic8cukJwJ18=KitC2HX+jO5eo4g@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 10 May 2019 03:33:52 -0700
Message-ID: <CAFd5g46dE78f3bx33Sv-CPNx9i8VV=v0Ezwytp8eiQU1MzWbbQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] kbuild: enable building KUnit
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "Cc: Shuah Khan" <shuah@kernel.org>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, DTML <devicetree@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Tim Bird <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Kevin Hilman <khilman@baylibre.com>

> On Fri, May 10, 2019 at 7:27 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > > On Thu, May 2, 2019 at 8:03 AM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > > >
> > > > Add KUnit to root Kconfig and Makefile allowing it to actually be built.
> > > >
> > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > >
> > > You need to make sure
> > > to not break git-bisect'abililty.
> > >
> > >
> > > With this commit, I see build error.
> > >
> > >   CC      kunit/test.o
> > > kunit/test.c:11:10: fatal error: os.h: No such file or directory
> > >  #include <os.h>
> > >           ^~~~~~
> > > compilation terminated.
> > > make[1]: *** [scripts/Makefile.build;279: kunit/test.o] Error 1
> > > make: *** [Makefile;1763: kunit/] Error 2
> >
> > Nice catch! That header shouldn't even be in there.
> >
> > Sorry about that. I will have it fixed in the next revision.
>
>
> BTW, I applied whole of this series
> to my kernel.org repository.
>
> 0day bot started to report issues.
> I hope several reports reached you,
> and they are useful to fix your code.

Yep, I have received several. They are very helpful.

I greatly appreciate it.

Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

