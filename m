Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-f181.google.com ([209.85.210.181])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSZTV-0007W9-Hx
 for linux-um@lists.infradead.org; Fri, 30 Nov 2018 03:28:18 +0000
Received: by mail-pf1-f181.google.com with SMTP id u6so2064149pfh.11
 for <linux-um@lists.infradead.org>; Thu, 29 Nov 2018 19:28:07 -0800 (PST)
Date: Thu, 29 Nov 2018 19:28:02 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC v3 01/19] kunit: test: add KUnit test runner core
Message-ID: <20181130032802.GG18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-2-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128193636.254378-2-brendanhiggins@google.com>
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
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, frowand.list@gmail.com, linux-nvdimm@lists.01.org, richard@nod.at, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, joel@jms.id.au, jdike@addtoit.com, Tim.Bird@sony.com, keescook@google.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

> +static void kunit_run_case_internal(struct kunit *test,
> +				    struct kunit_module *module,
> +				    struct kunit_case *test_case)
> +{
> +	int ret;
> +
> +	if (module->init) {
> +		ret = module->init(test);
> +		if (ret) {
> +			kunit_err(test, "failed to initialize: %d", ret);
> +			kunit_set_success(test, false);
> +			return;
> +		}
> +	}
> +
> +	test_case->run_case(test);
> +}

<-- snip -->

> +static bool kunit_run_case(struct kunit *test,
> +			   struct kunit_module *module,
> +			   struct kunit_case *test_case)
> +{
> +	kunit_set_success(test, true);
> +
> +	kunit_run_case_internal(test, module, test_case);
> +	kunit_run_case_cleanup(test, module, test_case);
> +
> +	return kunit_get_success(test);
> +}

So we are running the module->init() for each test case... is that
correct? Shouldn't the init run once? Also, typically init calls are
pegged with __init so we free them later. You seem to have skipped the
init annotations. Why?

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

