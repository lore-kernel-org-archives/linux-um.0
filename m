Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iulNY-0000aT-D4
 for linux-um@lists.infradead.org; Thu, 23 Jan 2020 22:55:13 +0000
Received: by mail-pj1-x1041.google.com with SMTP id s7so166156pjc.0
 for <linux-um@lists.infradead.org>; Thu, 23 Jan 2020 14:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20191216220555.245089-4-brendanhiggins@google.com>
 <20191217080408.0E805207FF@mail.kernel.org>
In-Reply-To: <20191217080408.0E805207FF@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 23 Jan 2020 14:54:55 -0800
Message-ID: <CAFd5g44Wh9kwXsY_M4GfMp0+wzN_3HhVfa360J-tF48aQ_KADg@mail.gmail.com>
Subject: Re: [RFC v1 3/6] kunit: test: create a single centralized executor
 for all tests
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
Cc: linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Knut Omang <knut.omang@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>, rppt@linux.ibm.com, linux-um <linux-um@lists.infradead.org>, Logan Gunthorpe <logang@deltatee.com>, KUnit Development <kunit-dev@googlegroups.com>, David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Iurii Zaikin <yzaikin@google.com>, Alan Maguire <alan.maguire@oracle.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Tue, Dec 17, 2019 at 12:04 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-12-16 14:05:52)
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index dba48304b3bd3..c070798ebb765 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -217,11 +217,8 @@ int kunit_run_tests(struct kunit_suite *suite);
> >   * everything else is definitely initialized.
> >   */
> >  #define kunit_test_suite(suite)                                                       \
> > -       static int kunit_suite_init##suite(void)                               \
>
> Oh this should have been __init before.

No, the stuff in this patch shouldn't be init. With the work that Alan
has been doing (adding support for modules, debugfs); the test code
can run after booting, so init in any of this code is incorrect.

> > -       {                                                                      \
> > -               return kunit_run_tests(&suite);                                \
> > -       }                                                                      \
> > -       late_initcall(kunit_suite_init##suite)
> > +       static struct kunit_suite *__kunit_suite_##suite                       \
> > +       __used __aligned(8) __section(.kunit_test_suites) = &suite
> >
> >  /*
> >   * Like kunit_alloc_resource() below, but returns the struct kunit_resource
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > new file mode 100644
> > index 0000000000000..978086cfd257d
> > --- /dev/null
> > +++ b/lib/kunit/executor.c
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Base unit test (KUnit) API.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/printk.h>
> > +#include <kunit/test.h>
> > +
> > +/*
> > + * These symbols point to the .kunit_test_suites section and are defined in
> > + * include/asm-generic/vmlinux.lds.h, and consequently must be extern.
> > + */
> > +extern struct kunit_suite *__kunit_suites_start[];
> > +extern struct kunit_suite *__kunit_suites_end[];
> > +
> > +static bool kunit_run_all_tests(void)
>
> Should be __init?

It could be, I think. Alan's code doesn't call this, so for now we
might as well make it __init.

> > +{
> > +       struct kunit_suite **suite;
>
> Can this be const? And the linker references above too?

Good catch. Will fix.

> > +       bool has_test_failed = false;
> > +
> > +       for (suite = __kunit_suites_start;
> > +            suite < __kunit_suites_end;
> > +            ++suite) {
> > +               if (kunit_run_tests(*suite))
> > +                       has_test_failed = true;
> > +       }
> > +
> > +       return !has_test_failed;
> > +}
> > +
> > +static int kunit_executor_init(void)
>
> Should be __init?

Will do.

> > +{
> > +       if (kunit_run_all_tests())
> > +               return 0;
> > +       else
> > +               return -EFAULT;
>
> Why two functions instead of just one that is the target of the
> late_initcall? Nitpick: deindent that last return and take it out of the
> else.

Yeah, it probably makes more sense to just call kunit_run_all_tests
and have it return an int.

> > +}
> > +
> > +late_initcall(kunit_executor_init);

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

