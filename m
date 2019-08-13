Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxOpz-0004K7-Ko
 for linux-um@lists.infradead.org; Tue, 13 Aug 2019 04:55:12 +0000
MIME-Version: 1.0
In-Reply-To: <20190812182421.141150-12-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-12-brendanhiggins@google.com>
Subject: Re: [PATCH v12 11/18] kunit: test: add the concept of assertions
From: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 12 Aug 2019 21:55:09 -0700
Message-Id: <20190813045510.C1D6E206C2@mail.kernel.org>
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

Quoting Brendan Higgins (2019-08-12 11:24:14)
> Add support for assertions which are like expectations except the test
> terminates if the assertion is not satisfied.
> 
> The idea with assertions is that you use them to state all the
> preconditions for your test. Logically speaking, these are the premises
> of the test case, so if a premise isn't true, there is no point in
> continuing the test case because there are no conclusions that can be
> drawn without the premises. Whereas, the expectation is the thing you
> are trying to prove. It is not used universally in x-unit style test
> frameworks, but I really like it as a convention.  You could still
> express the idea of a premise using the above idiom, but I think
> KUNIT_ASSERT_* states the intended idea perfectly.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

> + * Sets an expectation that the values that @left and @right evaluate to are
> + * not equal. This is semantically equivalent to
> + * KUNIT_ASSERT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_ASSERT_TRUE()
> + * for more information.
> + */
> +#define KUNIT_ASSERT_STRNEQ(test, left, right)                                \
> +               KUNIT_BINARY_STR_NE_ASSERTION(test,                            \
> +                                             KUNIT_ASSERTION,                 \
> +                                             left,                            \
> +                                             right)
> +
> +#define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)                  \
> +               KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,                        \
> +                                                 KUNIT_ASSERTION,             \
> +                                                 left,                        \
> +                                                 right,                       \
> +                                                 fmt,                         \

Same question about tabbing too.

> diff --git a/kunit/test-test.c b/kunit/test-test.c
> index 88f4cdf03db2a..058f3fb37458a 100644
> --- a/kunit/test-test.c
> +++ b/kunit/test-test.c
> @@ -78,11 +78,13 @@ static int kunit_try_catch_test_init(struct kunit *test)
>         struct kunit_try_catch_test_context *ctx;
>  
>         ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);

Ah ok. Question still stands if kunit_kzalloc() should just have the
assertion on failure.

>         test->priv = ctx;
>  
>         ctx->try_catch = kunit_kmalloc(test,
>                                        sizeof(*ctx->try_catch),
>                                        GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->try_catch);
>  

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

