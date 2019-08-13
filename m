Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxOaK-00070D-0v
 for linux-um@lists.infradead.org; Tue, 13 Aug 2019 04:39:01 +0000
MIME-Version: 1.0
In-Reply-To: <20190812182421.141150-15-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-15-brendanhiggins@google.com>
Subject: Re: [PATCH v12 14/18] kunit: defconfig: add defconfigs for building
 KUnit tests
From: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 12 Aug 2019 21:38:58 -0700
Message-Id: <20190813043859.661F82054F@mail.kernel.org>
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

Quoting Brendan Higgins (2019-08-12 11:24:17)
> diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
> new file mode 100644
> index 0000000000000..bfe49689038f1
> --- /dev/null
> +++ b/arch/um/configs/kunit_defconfig
> @@ -0,0 +1,8 @@
> +CONFIG_OF=y
> +CONFIG_OF_UNITTEST=y
> +CONFIG_OF_OVERLAY=y
> +CONFIG_I2C=y
> +CONFIG_I2C_MUX=y
> +CONFIG_KUNIT=y
> +CONFIG_KUNIT_TEST=y
> +CONFIG_KUNIT_EXAMPLE_TEST=y
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
> new file mode 100644
> index 0000000000000..bfe49689038f1
> --- /dev/null
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -0,0 +1,8 @@
> +CONFIG_OF=y
> +CONFIG_OF_UNITTEST=y
> +CONFIG_OF_OVERLAY=y
> +CONFIG_I2C=y
> +CONFIG_I2C_MUX=y

Are these above config options necessary? I don't think they're part of
the patch series anymore so it looks odd to enable the OF unittests and
i2c configs.

> +CONFIG_KUNIT=y
> +CONFIG_KUNIT_TEST=y
> +CONFIG_KUNIT_EXAMPLE_TEST=y

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

