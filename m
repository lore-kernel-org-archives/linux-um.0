Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hn7cM-0003wA-JD
 for linux-um@lists.infradead.org; Mon, 15 Jul 2019 20:30:40 +0000
Received: by mail-pg1-x542.google.com with SMTP id z75so8261028pgz.5
 for <linux-um@lists.infradead.org>; Mon, 15 Jul 2019 13:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-3-brendanhiggins@google.com>
 <20190715202425.CE64C20665@mail.kernel.org>
In-Reply-To: <20190715202425.CE64C20665@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 15 Jul 2019 13:30:22 -0700
Message-ID: <CAFd5g45iHnMLOGQbXwzX6F74pkQGKBCSufkpYPOcw_iNSeiQKg@mail.gmail.com>
Subject: Re: [PATCH v9 02/18] kunit: test: add test resource management API
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
To: Stephen Boyd <sboyd@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Kevin Hilman <khilman@baylibre.com>

On Mon, Jul 15, 2019 at 1:24 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-12 01:17:28)
> > diff --git a/kunit/test.c b/kunit/test.c
> > index 571e4c65deb5c..f165c9d8e10b0 100644
> > --- a/kunit/test.c
> > +++ b/kunit/test.c
> > @@ -171,6 +175,96 @@ int kunit_run_tests(struct kunit_suite *suite)
> >         return 0;
> >  }
> >
> > +struct kunit_resource *kunit_alloc_resource(struct kunit *test,
> > +                                           kunit_resource_init_t init,
> > +                                           kunit_resource_free_t free,
> > +                                           void *context)
> > +{
> > +       struct kunit_resource *res;
> > +       int ret;
> > +
> > +       res = kzalloc(sizeof(*res), GFP_KERNEL);
>
> This uses GFP_KERNEL.
>
> > +       if (!res)
> > +               return NULL;
> > +
> > +       ret = init(res, context);
> > +       if (ret)
> > +               return NULL;
> > +
> > +       res->free = free;
> > +       mutex_lock(&test->lock);
>
> And this can sleep.
>
> > +       list_add_tail(&res->node, &test->resources);
> > +       mutex_unlock(&test->lock);
> > +
> > +       return res;
> > +}
> > +
> > +void kunit_free_resource(struct kunit *test, struct kunit_resource *res)
>
> Should probably add a note that we assume the test lock is held here, or
> even add a lockdep_assert_held(&test->lock) into the function to
> document that and assert it at the same time.

Seems reasonable.

> > +{
> > +       res->free(res);
> > +       list_del(&res->node);
> > +       kfree(res);
> > +}
> > +
> > +struct kunit_kmalloc_params {
> > +       size_t size;
> > +       gfp_t gfp;
> > +};
> > +
> > +static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
> > +{
> > +       struct kunit_kmalloc_params *params = context;
> > +
> > +       res->allocation = kmalloc(params->size, params->gfp);
> > +       if (!res->allocation)
> > +               return -ENOMEM;
> > +
> > +       return 0;
> > +}
> > +
> > +static void kunit_kmalloc_free(struct kunit_resource *res)
> > +{
> > +       kfree(res->allocation);
> > +}
> > +
> > +void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
> > +{
> > +       struct kunit_kmalloc_params params;
> > +       struct kunit_resource *res;
> > +
> > +       params.size = size;
> > +       params.gfp = gfp;
> > +
> > +       res = kunit_alloc_resource(test,
>
> This calls that sleeping function above...
>
> > +                                  kunit_kmalloc_init,
> > +                                  kunit_kmalloc_free,
> > +                                  &params);
>
> but this passes a GFP flags parameter through to the
> kunit_kmalloc_init() function. How is this going to work if some code
> uses GFP_ATOMIC, but then we try to allocate and sleep in
> kunit_alloc_resource() with GFP_KERNEL?

Yeah, that's an inconsistency. I need to fix that.

> One solution would be to piggyback on all the existing devres allocation
> logic we already have and make each struct kunit a device that we pass
> into the devres functions. A far simpler solution would be to just
> copy/paste what devres does and use a spinlock and an allocation
> function that takes GFP flags.

Yeah, that's what I did originally, but I thought from the discussion
on patch 01 that you thought a spinlock was overkill for struct kunit.
I take it you only meant in that initial patch?

> > +
> > +       if (res)
> > +               return res->allocation;
> > +
> > +       return NULL;
> > +}

Cheers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

