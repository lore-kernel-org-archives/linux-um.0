Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ih7pw-0004J5-Ep
 for linux-um@lists.infradead.org; Tue, 17 Dec 2019 08:04:09 +0000
MIME-Version: 1.0
In-Reply-To: <20191216220555.245089-4-brendanhiggins@google.com>
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20191216220555.245089-4-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v1 3/6] kunit: test: create a single centralized executor
 for all tests
Date: Tue, 17 Dec 2019 00:04:07 -0800
Message-Id: <20191217080408.0E805207FF@mail.kernel.org>
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
To: Brendan Higgins <brendanhiggins@google.com>, akpm@linux-foundation.org, alan.maguire@oracle.com, anton.ivanov@cambridgegreys.com, arnd@arndb.de, davidgow@google.com, jdike@addtoit.com, keescook@chromium.org, richard@nod.at, rppt@linux.ibm.com, skhan@linuxfoundation.org, yzaikin@google.com
Cc: linux-arch@vger.kernel.org, knut.omang@oracle.com, gregkh@linuxfoundation.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, linux-kselftest@vger.kernel.org, logang@deltatee.com, Brendan Higgins <brendanhiggins@google.com>, kunit-dev@googlegroups.com

Quoting Brendan Higgins (2019-12-16 14:05:52)
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index dba48304b3bd3..c070798ebb765 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -217,11 +217,8 @@ int kunit_run_tests(struct kunit_suite *suite);
>   * everything else is definitely initialized.
>   */
>  #define kunit_test_suite(suite)                                                       \
> -       static int kunit_suite_init##suite(void)                               \

Oh this should have been __init before.

> -       {                                                                      \
> -               return kunit_run_tests(&suite);                                \
> -       }                                                                      \
> -       late_initcall(kunit_suite_init##suite)
> +       static struct kunit_suite *__kunit_suite_##suite                       \
> +       __used __aligned(8) __section(.kunit_test_suites) = &suite
>  
>  /*
>   * Like kunit_alloc_resource() below, but returns the struct kunit_resource
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> new file mode 100644
> index 0000000000000..978086cfd257d
> --- /dev/null
> +++ b/lib/kunit/executor.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Base unit test (KUnit) API.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#include <linux/init.h>
> +#include <linux/printk.h>
> +#include <kunit/test.h>
> +
> +/*
> + * These symbols point to the .kunit_test_suites section and are defined in
> + * include/asm-generic/vmlinux.lds.h, and consequently must be extern.
> + */
> +extern struct kunit_suite *__kunit_suites_start[];
> +extern struct kunit_suite *__kunit_suites_end[];
> +
> +static bool kunit_run_all_tests(void)

Should be __init?

> +{
> +       struct kunit_suite **suite;

Can this be const? And the linker references above too?

> +       bool has_test_failed = false;
> +
> +       for (suite = __kunit_suites_start;
> +            suite < __kunit_suites_end;
> +            ++suite) {
> +               if (kunit_run_tests(*suite))
> +                       has_test_failed = true;
> +       }
> +
> +       return !has_test_failed;
> +}
> +
> +static int kunit_executor_init(void)

Should be __init?

> +{
> +       if (kunit_run_all_tests())
> +               return 0;
> +       else
> +               return -EFAULT;

Why two functions instead of just one that is the target of the
late_initcall? Nitpick: deindent that last return and take it out of the
else.

> +}
> +
> +late_initcall(kunit_executor_init);

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

