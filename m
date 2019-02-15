Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gukcK-0003gZ-33
 for linux-um@lists.infradead.org; Fri, 15 Feb 2019 21:01:53 +0000
MIME-Version: 1.0
In-Reply-To: <20190214213729.21702-3-brendanhiggins@google.com>
Subject: Re: [RFC v4 02/17] kunit: test: add test resource management API
Message-ID: <155026451067.115909.17082794837098610153@swboyd.mtv.corp.google.com>
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-3-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 15 Feb 2019 13:01:50 -0800
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
Cc: brakmo@fb.com, pmladek@suse.com, amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, richard@nod.at, knut.omang@oracle.com, wfg@linux.intel.com, joel@jms.id.au, jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

Quoting Brendan Higgins (2019-02-14 13:37:14)
> @@ -104,6 +167,7 @@ struct kunit {
>         const char *name; /* Read only after initialization! */
>         spinlock_t lock; /* Gaurds all mutable test state. */
>         bool success; /* Protected by lock. */
> +       struct list_head resources; /* Protected by lock. */
>         void (*vprintk)(const struct kunit *test,
>                         const char *level,
>                         struct va_format *vaf);
> @@ -127,6 +191,51 @@ int kunit_run_tests(struct kunit_module *module);
>                 } \
>                 late_initcall(module_kunit_init##module)
>  
> +/**
> + * kunit_alloc_resource() - Allocates a *test managed resource*.
> + * @test: The test context object.
> + * @init: a user supplied function to initialize the resource.
> + * @free: a user supplied function to free the resource.
> + * @context: for the user to pass in arbitrary data.

Nitpick: "pass in arbitrary data to the init function"? Maybe that
provides some more clarity.

> + *
> + * Allocates a *test managed resource*, a resource which will automatically be
> + * cleaned up at the end of a test case. See &struct kunit_resource for an
> + * example.
> + */

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

