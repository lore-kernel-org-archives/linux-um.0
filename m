Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJm5Y-00024T-ES
 for linux-um@lists.infradead.org; Thu, 25 Apr 2019 21:39:30 +0000
Received: by mail-oi1-x242.google.com with SMTP id w139so1287099oie.9
 for <linux-um@lists.infradead.org>; Thu, 25 Apr 2019 14:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190404220652.19765-1-brendanhiggins@google.com>
 <20190404220652.19765-12-brendanhiggins@google.com>
 <20190424190019.wvljyeo3y7gd24p5@gabell>
In-Reply-To: <20190424190019.wvljyeo3y7gd24p5@gabell>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 25 Apr 2019 14:39:15 -0700
Message-ID: <CAFd5g45CaCFdQCxQqxgYfoQSGAF8RAV2YrOMs0oR4R-iCTZrig@mail.gmail.com>
Subject: Re: [PATCH v1 11/17] kunit: test: add test managed resource tests
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
To: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, yamada.masahiro@socionext.com, Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Kevin Hilman <khilman@baylibre.com>, linux-doc@vger.kernel.org, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, "Bird, Timothy" <Tim.Bird@sony.com>, Dan Carpenter <dan.carpenter@oracle.com>, Petr Mladek <pmladek@suse.com>, linux-kbuild@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Avinash Kondareddy <akndr41@gmail.com>, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>, Greg KH <gregkh@linuxfoundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:00 PM Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>
> On Thu, Apr 04, 2019 at 03:06:46PM -0700, Brendan Higgins wrote:
> > From: Avinash Kondareddy <akndr41@gmail.com>
> >
> > Tests how tests interact with test managed resources in their lifetime.
> >
> > Signed-off-by: Avinash Kondareddy <akndr41@gmail.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  kunit/test-test.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 122 insertions(+)
> >
> > diff --git a/kunit/test-test.c b/kunit/test-test.c
> > index 4bd7a34d0a6cb..54add8ca418a0 100644
> > --- a/kunit/test-test.c
> > +++ b/kunit/test-test.c
> > @@ -135,3 +135,125 @@ static struct kunit_module kunit_try_catch_test_module = {
> >       .test_cases = kunit_try_catch_test_cases,
> >  };
> >  module_test(kunit_try_catch_test_module);
> > +
> > +/*
> > + * Context for testing test managed resources
> > + * is_resource_initialized is used to test arbitrary resources
> > + */
> > +struct kunit_test_resource_context {
> > +     struct kunit test;
> > +     bool is_resource_initialized;
> > +};
> > +
> > +static int fake_resource_init(struct kunit_resource *res, void *context)
> > +{
> > +     struct kunit_test_resource_context *ctx = context;
> > +
> > +     res->allocation = &ctx->is_resource_initialized;
> > +     ctx->is_resource_initialized = true;
> > +     return 0;
> > +}
> > +
> > +static void fake_resource_free(struct kunit_resource *res)
> > +{
> > +     bool *is_resource_initialized = res->allocation;
> > +
> > +     *is_resource_initialized = false;
> > +}
> > +
> > +static void kunit_resource_test_init_resources(struct kunit *test)
> > +{
> > +     struct kunit_test_resource_context *ctx = test->priv;
> > +
> > +     kunit_init_test(&ctx->test, "testing_test_init_test");
> > +
> > +     KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
> > +}
> > +
> > +static void kunit_resource_test_alloc_resource(struct kunit *test)
> > +{
> > +     struct kunit_test_resource_context *ctx = test->priv;
> > +     struct kunit_resource *res;
> > +     kunit_resource_free_t free = fake_resource_free;
> > +
> > +     res = kunit_alloc_resource(&ctx->test,
> > +                                fake_resource_init,
> > +                                fake_resource_free,
> > +                                ctx);
> > +
>
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
>
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test, res);

See my reply to your email on the 14/17 patch.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

