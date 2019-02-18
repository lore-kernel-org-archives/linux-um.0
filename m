Return-Path: <devicetree-owner@vger.kernel.org>
Subject: Re: [RFC v4 08/17] kunit: test: add support for test abort
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-9-brendanhiggins@google.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <da1995fa-a362-dfe6-8184-7fcdf2b923e8@gmail.com>
Date: Mon, 18 Feb 2019 11:52:37 -0800
MIME-Version: 1.0
In-Reply-To: <20190214213729.21702-9-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: devicetree-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, keescook@google.com, mcgrof@kernel.org, shuah@kernel.org, robh@kernel.org, kieran.bingham@ideasonboard.com
Cc: gregkh@linuxfoundation.org, joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com, rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, dan.j.williams@intel.com, linux-nvdimm@lists.01.org, knut.omang@oracle.com, devicetree@vger.kernel.org, pmladek@suse.com, Alexander.Levin@microsoft.com, amir73il@gmail.com, dan.carpenter@oracle.com, wfg@linux.intel.com
List-ID: <linux-um.lists.infradead.org>

On 2/14/19 1:37 PM, Brendan Higgins wrote:
> Add support for aborting/bailing out of test cases. Needed for
> implementing assertions.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> Changes Since Last Version
>  - This patch is new introducing a new cross-architecture way to abort
>    out of a test case (needed for KUNIT_ASSERT_*, see next patch for
>    details).
>  - On a side note, this is not a complete replacement for the UML abort
>    mechanism, but covers the majority of necessary functionality. UML
>    architecture specific featurs have been dropped from the initial
>    patchset.
> ---
>  include/kunit/test.h |  24 +++++
>  kunit/Makefile       |   3 +-
>  kunit/test-test.c    | 127 ++++++++++++++++++++++++++
>  kunit/test.c         | 208 +++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 353 insertions(+), 9 deletions(-)
>  create mode 100644 kunit/test-test.c

< snip >

> diff --git a/kunit/test.c b/kunit/test.c
> index d18c50d5ed671..6e5244642ab07 100644
> --- a/kunit/test.c
> +++ b/kunit/test.c
> @@ -6,9 +6,9 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>  
> -#include <linux/sched.h>
>  #include <linux/sched/debug.h>
> -#include <os.h>
> +#include <linux/completion.h>
> +#include <linux/kthread.h>
>  #include <kunit/test.h>
>  
>  static bool kunit_get_success(struct kunit *test)
> @@ -32,6 +32,27 @@ static void kunit_set_success(struct kunit *test, bool success)
>  	spin_unlock_irqrestore(&test->lock, flags);
>  }
>  
> +static bool kunit_get_death_test(struct kunit *test)
> +{
> +	unsigned long flags;
> +	bool death_test;
> +
> +	spin_lock_irqsave(&test->lock, flags);
> +	death_test = test->death_test;
> +	spin_unlock_irqrestore(&test->lock, flags);
> +
> +	return death_test;
> +}
> +
> +static void kunit_set_death_test(struct kunit *test, bool death_test)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&test->lock, flags);
> +	test->death_test = death_test;
> +	spin_unlock_irqrestore(&test->lock, flags);
> +}
> +
>  static int kunit_vprintk_emit(const struct kunit *test,
>  			      int level,
>  			      const char *fmt,
> @@ -70,13 +91,29 @@ static void kunit_fail(struct kunit *test, struct kunit_stream *stream)
>  	stream->commit(stream);
>  }
>  
> +static void __noreturn kunit_abort(struct kunit *test)
> +{
> +	kunit_set_death_test(test, true);
> +
> +	test->try_catch.throw(&test->try_catch);
> +
> +	/*
> +	 * Throw could not abort from test.
> +	 */
> +	kunit_err(test, "Throw could not abort from test!");
> +	show_stack(NULL, NULL);
> +	BUG();

kunit_abort() is what will be call as the result of an assert failure.

BUG(), which is a panic, which is crashing the system is not acceptable
in the Linux kernel.  You will just annoy Linus if you submit this.

-Frank

< snip >

