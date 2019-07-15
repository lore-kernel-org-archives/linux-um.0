Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hn7WM-00019x-Hn
 for linux-um@lists.infradead.org; Mon, 15 Jul 2019 20:24:27 +0000
MIME-Version: 1.0
In-Reply-To: <20190712081744.87097-3-brendanhiggins@google.com>
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-3-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v9 02/18] kunit: test: add test resource management API
Date: Mon, 15 Jul 2019 13:24:25 -0700
Message-Id: <20190715202425.CE64C20665@mail.kernel.org>
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

Quoting Brendan Higgins (2019-07-12 01:17:28)
> diff --git a/kunit/test.c b/kunit/test.c
> index 571e4c65deb5c..f165c9d8e10b0 100644
> --- a/kunit/test.c
> +++ b/kunit/test.c
> @@ -171,6 +175,96 @@ int kunit_run_tests(struct kunit_suite *suite)
>         return 0;
>  }
>  
> +struct kunit_resource *kunit_alloc_resource(struct kunit *test,
> +                                           kunit_resource_init_t init,
> +                                           kunit_resource_free_t free,
> +                                           void *context)
> +{
> +       struct kunit_resource *res;
> +       int ret;
> +
> +       res = kzalloc(sizeof(*res), GFP_KERNEL);

This uses GFP_KERNEL.

> +       if (!res)
> +               return NULL;
> +
> +       ret = init(res, context);
> +       if (ret)
> +               return NULL;
> +
> +       res->free = free;
> +       mutex_lock(&test->lock);

And this can sleep.

> +       list_add_tail(&res->node, &test->resources);
> +       mutex_unlock(&test->lock);
> +
> +       return res;
> +}
> +
> +void kunit_free_resource(struct kunit *test, struct kunit_resource *res)

Should probably add a note that we assume the test lock is held here, or
even add a lockdep_assert_held(&test->lock) into the function to
document that and assert it at the same time.

> +{
> +       res->free(res);
> +       list_del(&res->node);
> +       kfree(res);
> +}
> +
> +struct kunit_kmalloc_params {
> +       size_t size;
> +       gfp_t gfp;
> +};
> +
> +static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
> +{
> +       struct kunit_kmalloc_params *params = context;
> +
> +       res->allocation = kmalloc(params->size, params->gfp);
> +       if (!res->allocation)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +static void kunit_kmalloc_free(struct kunit_resource *res)
> +{
> +       kfree(res->allocation);
> +}
> +
> +void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
> +{
> +       struct kunit_kmalloc_params params;
> +       struct kunit_resource *res;
> +
> +       params.size = size;
> +       params.gfp = gfp;
> +
> +       res = kunit_alloc_resource(test,

This calls that sleeping function above...

> +                                  kunit_kmalloc_init,
> +                                  kunit_kmalloc_free,
> +                                  &params);

but this passes a GFP flags parameter through to the
kunit_kmalloc_init() function. How is this going to work if some code
uses GFP_ATOMIC, but then we try to allocate and sleep in
kunit_alloc_resource() with GFP_KERNEL? 

One solution would be to piggyback on all the existing devres allocation
logic we already have and make each struct kunit a device that we pass
into the devres functions. A far simpler solution would be to just
copy/paste what devres does and use a spinlock and an allocation
function that takes GFP flags.

> +
> +       if (res)
> +               return res->allocation;
> +
> +       return NULL;
> +}

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

