Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hfvTW-0002FF-EF
 for linux-um@lists.infradead.org; Wed, 26 Jun 2019 00:07:47 +0000
Received: by mail-pf1-x444.google.com with SMTP id r7so269070pfl.3
 for <linux-um@lists.infradead.org>; Tue, 25 Jun 2019 17:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
 <20190625223312.GP19023@42.do-not-panic.com>
In-Reply-To: <20190625223312.GP19023@42.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 25 Jun 2019 17:07:32 -0700
Message-ID: <CAFd5g46TLAONgXiZkFM98BPd-sariMTwhmYG9hSJ+M9=r-ixeg@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
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
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Kevin Hilman <khilman@baylibre.com>

On Tue, Jun 25, 2019 at 3:33 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Jun 17, 2019 at 01:25:56AM -0700, Brendan Higgins wrote:
> > +/**
> > + * module_test() - used to register a &struct kunit_module with KUnit.
> > + * @module: a statically allocated &struct kunit_module.
> > + *
> > + * Registers @module with the test framework. See &struct kunit_module for more
> > + * information.
> > + */
> > +#define module_test(module) \
> > +             static int module_kunit_init##module(void) \
> > +             { \
> > +                     return kunit_run_tests(&module); \
> > +             } \
> > +             late_initcall(module_kunit_init##module)
>
> Becuase late_initcall() is used, if these modules are built-in, this
> would preclude the ability to test things prior to this part of the
> kernel under UML or whatever architecture runs the tests. So, this
> limits the scope of testing. Small detail but the scope whould be
> documented.

You aren't the first person to complain about this (and I am not sure
it is the first time you have complained about it). Anyway, I have
some follow on patches that will improve the late_initcall thing, and
people seemed okay with discussing the follow on patches as part of a
subsequent patchset after this gets merged.

I will nevertheless document the restriction until then.

> > +static void kunit_print_tap_version(void)
> > +{
> > +     if (!kunit_has_printed_tap_version) {
> > +             kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
>
> What is this TAP thing? Why should we care what version it is on?
> Why are we printing this?

It's part of the TAP specification[1]. Greg and Frank asked me to make
the intermediate format conform to TAP. Seems like something else I
should probable document...

> > +             kunit_has_printed_tap_version = true;
> > +     }
> > +}
> > +
> > +static size_t kunit_test_cases_len(struct kunit_case *test_cases)
> > +{
> > +     struct kunit_case *test_case;
> > +     size_t len = 0;
> > +
> > +     for (test_case = test_cases; test_case->run_case; test_case++)
>
> If we make the last test case NULL, we'd just check for test_case here,
> and save ourselves an extra few bytes per test module. Any reason why
> the last test case cannot be NULL?

Is there anyway to make that work with a statically defined array?

Basically, I want to be able to do something like:

static struct kunit_case example_test_cases[] = {
        KUNIT_CASE(example_simple_test),
        KUNIT_CASE(example_mock_test),
        {}
};

FYI,
#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }

In order to do what you are proposing, I think I need an array of
pointers to test cases, which is not ideal.

> > +void kunit_init_test(struct kunit *test, const char *name)
> > +{
> > +     spin_lock_init(&test->lock);
> > +     test->name = name;
> > +     test->success = true;
> > +}
> > +
> > +/*
> > + * Performs all logic to run a test case.
> > + */
> > +static void kunit_run_case(struct kunit_module *module,
> > +                        struct kunit_case *test_case)
> > +{
> > +     struct kunit test;
> > +     int ret = 0;
> > +
> > +     kunit_init_test(&test, test_case->name);
> > +
> > +     if (module->init) {
> > +             ret = module->init(&test);
>
> I believe if we used struct kunit_module *kmodule it would be much
> clearer who's init this is.

That's reasonable. I will fix in next revision.

Cheers!

[1] https://github.com/TestAnything/Specification/blob/tap-14-specification/specification.md

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

