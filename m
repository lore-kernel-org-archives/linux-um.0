Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJN6A-0002mp-3s
 for linux-um@lists.infradead.org; Wed, 24 Apr 2019 18:58:27 +0000
Received: by mail-qk1-x741.google.com with SMTP id d5so9246990qko.12
 for <linux-um@lists.infradead.org>; Wed, 24 Apr 2019 11:58:25 -0700 (PDT)
Date: Wed, 24 Apr 2019 14:58:14 -0400
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH v1 14/17] Documentation: kunit: add documentation for KUnit
Message-ID: <20190424185813.xabwr4lt6aunvpsd@gabell>
References: <20190404220652.19765-1-brendanhiggins@google.com>
 <20190404220652.19765-15-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190404220652.19765-15-brendanhiggins@google.com>
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: linux-doc@vger.kernel.org, amir73il@gmail.com, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com, devicetree@vger.kernel.org, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, frowand.list@gmail.com, corbet@lwn.net, khilman@baylibre.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com, joel@jms.id.au, Tim.Bird@sony.com, dan.carpenter@oracle.com, pmladek@suse.com, linux-kbuild@vger.kernel.org, jdike@addtoit.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com, richard@nod.at, gregkh@linuxfoundation.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org

Hi Brendan,

KUNIT_ASSERT_NOT_ERR_OR_NULL() should be replaced to
KUNIT_EXPECT_NOT_ERR_OR_NULL(), right?

On Thu, Apr 04, 2019 at 03:06:49PM -0700, Brendan Higgins wrote:
> Add documentation for KUnit, the Linux kernel unit testing framework.
> - Add intro and usage guide for KUnit
> - Add API reference
> 
> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

<snip>

> diff --git a/Documentation/kunit/start.rst b/Documentation/kunit/start.rst
> new file mode 100644
> index 0000000000000..5cdba5091905e
> --- /dev/null
> +++ b/Documentation/kunit/start.rst

<snip>

> +Assertions
> +~~~~~~~~~~
> +
> +KUnit also has the concept of an *assertion*. An assertion is just like an
> +expectation except the assertion immediately terminates the test case if it is
> +not satisfied.
> +
> +For example:
> +
> +.. code-block:: c
> +
> +	static void mock_test_do_expect_default_return(struct kunit *test)
> +	{
> +		struct mock_test_context *ctx = test->priv;
> +		struct mock *mock = ctx->mock;
> +		int param0 = 5, param1 = -5;
> +		const char *two_param_types[] = {"int", "int"};
> +		const void *two_params[] = {&param0, &param1};
> +		const void *ret;
> +
> +		ret = mock->do_expect(mock,
> +				      "test_printk", test_printk,
> +				      two_param_types, two_params,
> +				      ARRAY_SIZE(two_params));

> +		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);

		KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ret);

> +		KUNIT_EXPECT_EQ(test, -4, *((int *) ret));
> +	}
> +
> +In this example, the method under test should return a pointer to a value, so
> +if the pointer returned by the method is null or an errno, we don't want to
> +bother continuing the test since the following expectation could crash the test

> +case. `ASSERT_NOT_ERR_OR_NULL(...)` allows us to bail out of the test case if

  +case. `KUNIT_EXPECT_NOT_ERR_OR_NULL(...)` allows us to bail out of the test case if

Thanks!
Masa

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

