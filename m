Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hn8Tu-0006cF-3i
 for linux-um@lists.infradead.org; Mon, 15 Jul 2019 21:25:59 +0000
Received: by mail-pf1-x441.google.com with SMTP id g2so8029192pfq.0
 for <linux-um@lists.infradead.org>; Mon, 15 Jul 2019 14:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-2-brendanhiggins@google.com>
 <20190715201054.C69AA2086C@mail.kernel.org>
In-Reply-To: <20190715201054.C69AA2086C@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 15 Jul 2019 14:25:45 -0700
Message-ID: <CAFd5g44kWHYceo85qxL98JKH2FYBwVLFuLzqNR+APpMC1aKWUQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/18] kunit: test: add KUnit test runner core
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
To: Stephen Boyd <sboyd@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Kevin Hilman <khilman@baylibre.com>

On Mon, Jul 15, 2019 at 1:10 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-12 01:17:27)
> > Add core facilities for defining unit tests; this provides a common way
> > to define test cases, functions that execute code which is under test
> > and determine whether the code under test behaves as expected; this also
> > provides a way to group together related test cases in test suites (here
> > we call them test_modules).
> >
> > Just define test cases and how to execute them for now; setting
> > expectations on code will be defined later.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>
> Minor nits below.
>
> > diff --git a/kunit/test.c b/kunit/test.c
> > new file mode 100644
> > index 0000000000000..571e4c65deb5c
> > --- /dev/null
> > +++ b/kunit/test.c
> > @@ -0,0 +1,189 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Base unit test (KUnit) API.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <kunit/test.h>
> > +
> > +static void kunit_set_failure(struct kunit *test)
> > +{
> > +       WRITE_ONCE(test->success, false);
> > +}
> > +
> [...]
> > +
> > +void kunit_init_test(struct kunit *test, const char *name)
> > +{
> > +       test->name = name;
> > +       test->success = true;
> > +}
> > +
> > +/*
> > + * Performs all logic to run a test case.
> > + */
> > +static void kunit_run_case(struct kunit_suite *suite,
> > +                          struct kunit_case *test_case)
> > +{
> > +       struct kunit test;
> > +       int ret = 0;
> > +
> > +       kunit_init_test(&test, test_case->name);
> > +
> > +       if (suite->init) {
> > +               ret = suite->init(&test);
>
> Can you push the ret definition into this if scope? That way we can
> avoid default initialize to 0 for it.

Sure! I would actually prefer that from a cosmetic standpoint. I just
thought that mixing declarations and code was against the style guide.

> > +               if (ret) {
> > +                       kunit_err(&test, "failed to initialize: %d\n", ret);
> > +                       kunit_set_failure(&test);
>
> Do we need to 'test_case->success = test.success' here too? Or is the
> test failure extracted somewhere else?

Er, yes. That's kind of embarrassing. Good catch.

> > +                       return;
> > +               }
> > +       }
> > +
> > +       test_case->run_case(&test);
> > +
> > +       if (suite->exit)
> > +               suite->exit(&test);
> > +
> > +       test_case->success = test.success;

Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

