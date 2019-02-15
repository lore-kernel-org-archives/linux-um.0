Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gukVV-0000t7-Ic
 for linux-um@lists.infradead.org; Fri, 15 Feb 2019 20:54:50 +0000
MIME-Version: 1.0
In-Reply-To: <20190214213729.21702-11-brendanhiggins@google.com>
Subject: Re: [RFC v4 10/17] kunit: test: add test managed resource tests
Message-ID: <155026408761.115909.17855438744578437385@swboyd.mtv.corp.google.com>
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-11-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 15 Feb 2019 12:54:47 -0800
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
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com, keescook@google.com, kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org, shuah@kernel.org
Cc: brakmo@fb.com, pmladek@suse.com, amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, richard@nod.at, knut.omang@oracle.com, wfg@linux.intel.com, joel@jms.id.au, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Avinash Kondareddy <avikr@google.com>, daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

Quoting Brendan Higgins (2019-02-14 13:37:22)
> diff --git a/kunit/test-test.c b/kunit/test-test.c
> index 0b4ad6690310d..bb34431398526 100644
> --- a/kunit/test-test.c
> +++ b/kunit/test-test.c
[...]
> +
> +#define KUNIT_RESOURCE_NUM 5
> +static void kunit_resource_test_cleanup_resources(struct kunit *test)
> +{
> +       int i;
> +       struct kunit_test_resource_context *ctx = test->priv;
> +       struct kunit_resource *resources[KUNIT_RESOURCE_NUM];
> +
> +       for (i = 0; i < KUNIT_RESOURCE_NUM; i++) {

Nitpick: This could use ARRAY_SIZE(resources) and then the #define could
be dropped.

> +               resources[i] = kunit_alloc_resource(&ctx->test,
> +                                                   fake_resource_init,
> +                                                   fake_resource_free,
> +                                                   ctx);
> +       }
> +
> +       kunit_cleanup(&ctx->test);
> +
> +       KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
> +}
> +
[...]
> +
> +static struct kunit_case kunit_resource_test_cases[] = {

Can these arrays be const?

> +       KUNIT_CASE(kunit_resource_test_init_resources),
> +       KUNIT_CASE(kunit_resource_test_alloc_resource),
> +       KUNIT_CASE(kunit_resource_test_free_resource),
> +       KUNIT_CASE(kunit_resource_test_cleanup_resources),
> +       {},
> +};

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

