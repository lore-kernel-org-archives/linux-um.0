Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hMPx5-0002vb-82
 for linux-um@lists.infradead.org; Fri, 03 May 2019 04:37:40 +0000
Received: by mail-ot1-x343.google.com with SMTP id a5so624573otb.11
 for <linux-um@lists.infradead.org>; Thu, 02 May 2019 21:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-4-brendanhiggins@google.com>
 <1befe456-d981-d726-44f9-ebe3702ee51d@kernel.org>
In-Reply-To: <1befe456-d981-d726-44f9-ebe3702ee51d@kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 2 May 2019 21:37:26 -0700
Message-ID: <CAFd5g46Ok5rtXUyeHdyoujsdYPq4qwaZwdu3CxY50Gq_iq7B6A@mail.gmail.com>
Subject: Re: [PATCH v2 03/17] kunit: test: add string_stream a std::stream
 like string builder
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
To: shuah <shuah@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, linux-kbuild@vger.kernel.org, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, skhan@linuxfoundation.org, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>

On Thu, May 2, 2019 at 6:26 PM shuah <shuah@kernel.org> wrote:
>
> On 5/1/19 5:01 PM, Brendan Higgins wrote:
< snip >
> > diff --git a/kunit/Makefile b/kunit/Makefile
> > index 5efdc4dea2c08..275b565a0e81f 100644
> > --- a/kunit/Makefile
> > +++ b/kunit/Makefile
> > @@ -1 +1,2 @@
> > -obj-$(CONFIG_KUNIT) +=                       test.o
> > +obj-$(CONFIG_KUNIT) +=                       test.o \
> > +                                     string-stream.o
> > diff --git a/kunit/string-stream.c b/kunit/string-stream.c
> > new file mode 100644
> > index 0000000000000..7018194ecf2fa
> > --- /dev/null
> > +++ b/kunit/string-stream.c
> > @@ -0,0 +1,144 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * C++ stream style string builder used in KUnit for building messages.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#include <linux/list.h>
> > +#include <linux/slab.h>
> > +#include <kunit/string-stream.h>
> > +
> > +int string_stream_vadd(struct string_stream *this,
> > +                    const char *fmt,
> > +                    va_list args)
> > +{
> > +     struct string_stream_fragment *fragment;
>
> Since there is field with the same name, please use a different
> name. Using the same name for the struct which contains a field
> of the same name get very confusing and will hard to maintain
> the code.
>
> > +     int len;
> > +     va_list args_for_counting;
> > +     unsigned long flags;
> > +
> > +     /* Make a copy because `vsnprintf` could change it */
> > +     va_copy(args_for_counting, args);
> > +
> > +     /* Need space for null byte. */
> > +     len = vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
> > +
> > +     va_end(args_for_counting);
> > +
> > +     fragment = kmalloc(sizeof(*fragment), GFP_KERNEL);
> > +     if (!fragment)
> > +             return -ENOMEM;
> > +
> > +     fragment->fragment = kmalloc(len, GFP_KERNEL);
>
> This is confusing. See above comment.

Good point. Will fix in the next revision.

< snip >

Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

