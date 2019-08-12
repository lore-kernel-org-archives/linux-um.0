Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxKBS-0006mN-1J
 for linux-um@lists.infradead.org; Mon, 12 Aug 2019 23:57:03 +0000
MIME-Version: 1.0
In-Reply-To: <20190812182421.141150-6-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-6-brendanhiggins@google.com>
Subject: Re: [PATCH v12 05/18] kunit: test: add the concept of expectations
From: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 12 Aug 2019 16:57:00 -0700
Message-Id: <20190812235701.533E82063F@mail.kernel.org>
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
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com, gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com, kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org, robh@kernel.org, shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com, wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com, richard@nod.at, rdunlap@infradead.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org, logang@deltatee.com

Quoting Brendan Higgins (2019-08-12 11:24:08)
> Add support for expectations, which allow properties to be specified and
> then verified in tests.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Just some minor nits again.

> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index d0bf112910caf..2625bcfeb19ac 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -9,8 +9,10 @@
>  #ifndef _KUNIT_TEST_H
>  #define _KUNIT_TEST_H
>  
> +#include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/slab.h>
> +#include <kunit/assert.h>

Can you alphabet sort these?

>  
>  struct kunit_resource;
>  
> @@ -319,4 +321,845 @@ void __printf(3, 4) kunit_printk(const char *level,
>  #define kunit_err(test, fmt, ...) \
>                 kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
>  
> +/*
> + * Generates a compile-time warning in case of comparing incompatible types.
> + */
> +#define __kunit_typecheck(lhs, rhs) \
> +       ((void) __typecheck(lhs, rhs))

Is there a reason why this can't be inlined and the __kunit_typecheck()
macro can't be removed?

> +
> +/**
> + * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
> + * @test: The test context object.
[...]
> + * @condition: an arbitrary boolean expression. The test fails when this does
> + * not evaluate to true.
> + *
> + * This and expectations of the form `KUNIT_EXPECT_*` will cause the test case
> + * to fail when the specified condition is not met; however, it will not prevent
> + * the test case from continuing to run; this is otherwise known as an
> + * *expectation failure*.
> + */
> +#define KUNIT_EXPECT_TRUE(test, condition) \
> +               KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)

A lot of these macros seem double indented.

> +
> +#define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)                      \
> +               KUNIT_TRUE_MSG_ASSERTION(test,                                 \
> +                                        KUNIT_EXPECTATION,                    \
> +                                        condition,                            \
> +                                        fmt,                                  \
> +                                        ##__VA_ARGS__)
> +

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

