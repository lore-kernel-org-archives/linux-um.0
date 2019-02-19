Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwEkI-0001Wm-Ca
 for linux-um@lists.infradead.org; Tue, 19 Feb 2019 23:24:15 +0000
Received: by mail-it1-x141.google.com with SMTP id h6so11029273itl.1
 for <linux-um@lists.infradead.org>; Tue, 19 Feb 2019 15:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-3-brendanhiggins@google.com>
 <155026451067.115909.17082794837098610153@swboyd.mtv.corp.google.com>
In-Reply-To: <155026451067.115909.17082794837098610153@swboyd.mtv.corp.google.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 19 Feb 2019 15:24:01 -0800
Message-ID: <CAFd5g47yPUQFiEb4PaN_6xgY-ORTr-Z6W_gf8sWmpQ82fuSB_g@mail.gmail.com>
Subject: Re: [RFC v4 02/17] kunit: test: add test resource management API
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
Cc: brakmo@fb.com, Petr Mladek <pmladek@suse.com>, amir73il@gmail.com, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, linux-kselftest@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Richard Weinberger <richard@nod.at>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, Jeff Dike <jdike@addtoit.com>, dan.carpenter@oracle.com, devicetree <devicetree@vger.kernel.org>, shuah@kernel.org, "Bird, Timothy" <Tim.Bird@sony.com>, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>, Kevin Hilman <khilman@baylibre.com>

On Fri, Feb 15, 2019 at 1:01 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-02-14 13:37:14)
> > @@ -104,6 +167,7 @@ struct kunit {
> >         const char *name; /* Read only after initialization! */
> >         spinlock_t lock; /* Gaurds all mutable test state. */
> >         bool success; /* Protected by lock. */
> > +       struct list_head resources; /* Protected by lock. */
> >         void (*vprintk)(const struct kunit *test,
> >                         const char *level,
> >                         struct va_format *vaf);
> > @@ -127,6 +191,51 @@ int kunit_run_tests(struct kunit_module *module);
> >                 } \
> >                 late_initcall(module_kunit_init##module)
> >
> > +/**
> > + * kunit_alloc_resource() - Allocates a *test managed resource*.
> > + * @test: The test context object.
> > + * @init: a user supplied function to initialize the resource.
> > + * @free: a user supplied function to free the resource.
> > + * @context: for the user to pass in arbitrary data.
>
> Nitpick: "pass in arbitrary data to the init function"? Maybe that
> provides some more clarity.

I think that makes sense. Will fix in next revision.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

