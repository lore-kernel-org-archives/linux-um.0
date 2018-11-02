Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gIeRG-00023P-TR
 for linux-um@lists.infradead.org; Fri, 02 Nov 2018 18:45:00 +0000
Subject: Re: [RFC v2 01/14] kunit: test: add KUnit test runner core
References: <20181023235750.103146-1-brendanhiggins@google.com>
 <20181023235750.103146-2-brendanhiggins@google.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <017b111f-d960-c1ef-46ae-eb0eb639fe5b@kernel.org>
Date: Fri, 2 Nov 2018 12:44:46 -0600
MIME-Version: 1.0
In-Reply-To: <20181023235750.103146-2-brendanhiggins@google.com>
Content-Language: en-US
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
To: Brendan Higgins <brendanhiggins@google.com>, gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org
Cc: brakmo@fb.com, robh@kernel.org, richard@nod.at, dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org, mpe@ellerman.id.au, Tim.Bird@sony.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, kieran.bingham@ideasonboard.com, julia.lawall@lip6.fr, joel@jms.id.au, linux-kselftest@vger.kernel.org, khilman@baylibre.com, joe@perches.com, daniel@ffwll.ch, dan.j.williams@intel.com, Shuah Khan <shuah@kernel.org>, jdike@addtoit.com, kunit-dev@googlegroups.com

On 10/23/2018 05:57 PM, Brendan Higgins wrote:
> Add core facilities for defining unit tests; this provides a common way
> to define test cases, functions that execute code which is under test
> and determine whether the code under test behaves as expected; this also
> provides a way to group together related test cases in test suites (here
> we call them test_modules).
> 
> Just define test cases and how to execute them for now; setting
> expectations on code will be defined later.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  include/kunit/test.h | 165 ++++++++++++++++++++++++++++++++++++++++++
>  kunit/Kconfig        |  17 +++++
>  kunit/Makefile       |   1 +
>  kunit/test.c         | 168 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 351 insertions(+)
>  create mode 100644 include/kunit/test.h
>  create mode 100644 kunit/Kconfig
>  create mode 100644 kunit/Makefile
>  create mode 100644 kunit/test.c
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> new file mode 100644
> index 0000000000000..e0b14b227ac44
> --- /dev/null
> +++ b/include/kunit/test.h
> @@ -0,0 +1,165 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Base unit test (KUnit) API.
> + *
> + * Copyright (C) 2018, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#ifndef _KUNIT_TEST_H
> +#define _KUNIT_TEST_H
> +
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +
> +struct test;
> +
> +/**
> + * struct test_case - represents an individual test case.
> + * @run_case: the function representing the actual test case.
> + * @name: the name of the test case.
> + *
> + * A test case is a function with the signature, ``void (*)(struct test *)``
> + * that makes expectations (see TEST_EXPECT_TRUE()) about code under test. Each
> + * test case is associated with a &struct test_module and will be run after the
> + * module's init function and followed by the module's exit function.
> + *
> + * A test case should be static and should only be created with the TEST_CASE()
> + * macro; additionally, every array of test cases should be terminated with an
> + * empty test case.
> + *
> + * Example:
> + *
> + * .. code-block:: c
> + *
> + *	void add_test_basic(struct test *test)
> + *	{
> + *		TEST_EXPECT_EQ(test, 1, add(1, 0));
> + *		TEST_EXPECT_EQ(test, 2, add(1, 1));
> + *		TEST_EXPECT_EQ(test, 0, add(-1, 1));
> + *		TEST_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
> + *		TEST_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
> + *	}
> + *
> + *	static struct test_case example_test_cases[] = {
> + *		TEST_CASE(add_test_basic),
> + *		{},
> + *	};
> + *
> + */
> +struct test_case {
> +	void (*run_case)(struct test *test);
> +	const char name[256];
> +
> +	/* private: internal use only. */
> +	bool success;
> +};
> +

Introducing a prefix kunit_* might be a good idea for the API.
This comment applies to the rest of patches as well.

thanks,
-- Shuah

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

