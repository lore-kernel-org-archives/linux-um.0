Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSvY6-0002Bd-Kr
 for linux-um@lists.infradead.org; Sat, 01 Dec 2018 03:02:31 +0000
Received: by mail-pf1-f176.google.com with SMTP id i12so3704644pfo.7
 for <linux-um@lists.infradead.org>; Fri, 30 Nov 2018 19:02:20 -0800 (PST)
Date: Fri, 30 Nov 2018 19:02:15 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC v3 01/19] kunit: test: add KUnit test runner core
Message-ID: <20181201030215.GJ28501@garbanzo.do-not-panic.com>
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
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, alexander.h.duyck@linux.intel.com, shuah@kernel.org, robh@kernel.org, frowand.list@gmail.com, linux-nvdimm@lists.01.org, richard@nod.at, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, joel@jms.id.au, jdike@addtoit.com, Petr Mladek <pmladek@suse.com>, Tim.Bird@sony.com, keescook@google.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Wed, Nov 28, 2018 at 11:36:18AM -0800, Brendan Higgins wrote:
> +int kunit_run_tests(struct kunit_module *module)
> +{
> +	bool all_passed = true, success;
> +	struct kunit_case *test_case;
> +	struct kunit test;
> +	int ret;
> +
> +	ret = kunit_init_test(&test, module->name);
> +	if (ret)
> +		return ret;
> +
> +	for (test_case = module->test_cases; test_case->run_case; test_case++) {
> +		success = kunit_run_case(&test, module, test_case);

We are running test cases serially, why not address testing
asynchronously, this way tests can also be paralellized when possible,
therefore decreasing test time even further.

Would that mess up the printing/log stuff somehow?

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

