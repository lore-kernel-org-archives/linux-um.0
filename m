Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwEgi-0001Ms-Rf
 for linux-um@lists.infradead.org; Tue, 19 Feb 2019 23:20:34 +0000
Received: by mail-it1-x144.google.com with SMTP id l15so10948877iti.4
 for <linux-um@lists.infradead.org>; Tue, 19 Feb 2019 15:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-11-brendanhiggins@google.com>
 <155026408761.115909.17855438744578437385@swboyd.mtv.corp.google.com>
In-Reply-To: <155026408761.115909.17855438744578437385@swboyd.mtv.corp.google.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 19 Feb 2019 15:20:18 -0800
Message-ID: <CAFd5g44Dizk-VsFOmGn++E0d40sZmH6V+j05Eu6zUXaBj1xfcA@mail.gmail.com>
Subject: Re: [RFC v4 10/17] kunit: test: add test managed resource tests
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
Cc: brakmo@fb.com, Petr Mladek <pmladek@suse.com>, amir73il@gmail.com, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, linux-kselftest@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Richard Weinberger <richard@nod.at>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, Jeff Dike <jdike@addtoit.com>, dan.carpenter@oracle.com, devicetree <devicetree@vger.kernel.org>, shuah@kernel.org, "Bird, Timothy" <Tim.Bird@sony.com>, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Avinash Kondareddy <avikr@google.com>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>, Kevin Hilman <khilman@baylibre.com>

On Fri, Feb 15, 2019 at 12:54 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-02-14 13:37:22)
> > diff --git a/kunit/test-test.c b/kunit/test-test.c
> > index 0b4ad6690310d..bb34431398526 100644
> > --- a/kunit/test-test.c
> > +++ b/kunit/test-test.c
> [...]
> > +
> > +#define KUNIT_RESOURCE_NUM 5
> > +static void kunit_resource_test_cleanup_resources(struct kunit *test)
> > +{
> > +       int i;
> > +       struct kunit_test_resource_context *ctx = test->priv;
> > +       struct kunit_resource *resources[KUNIT_RESOURCE_NUM];
> > +
> > +       for (i = 0; i < KUNIT_RESOURCE_NUM; i++) {
>
> Nitpick: This could use ARRAY_SIZE(resources) and then the #define could
> be dropped.

Noted. Will fix in next revision.

>
> > +               resources[i] = kunit_alloc_resource(&ctx->test,
> > +                                                   fake_resource_init,
> > +                                                   fake_resource_free,
> > +                                                   ctx);
> > +       }
> > +
> > +       kunit_cleanup(&ctx->test);
> > +
> > +       KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
> > +}
> > +
> [...]
> > +
> > +static struct kunit_case kunit_resource_test_cases[] = {
>
> Can these arrays be const?

There is some private mutable state inside of `struct kunit_case` that
would be kind of annoying to pull out; I don't think it would make it
cleaner.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

