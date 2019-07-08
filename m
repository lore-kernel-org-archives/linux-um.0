Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hkaRF-0007M9-Eu
 for linux-um@lists.infradead.org; Mon, 08 Jul 2019 20:40:43 +0000
Received: by mail-pf1-x443.google.com with SMTP id i189so8146170pfg.10
 for <linux-um@lists.infradead.org>; Mon, 08 Jul 2019 13:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-2-brendanhiggins@google.com>
 <20190705201505.GA19023@42.do-not-panic.com>
 <CAFd5g45cF9rYc8YupnCgd=7xz_yW+_TMp_L+cSFUBW7d9njnVQ@mail.gmail.com>
In-Reply-To: <CAFd5g45cF9rYc8YupnCgd=7xz_yW+_TMp_L+cSFUBW7d9njnVQ@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 8 Jul 2019 13:40:26 -0700
Message-ID: <CAFd5g44XV0zDpNgyDPSFMq86kSvwGb_WjhxzK=AoDMjwXD5CgQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/18] kunit: test: add KUnit test runner core
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

On Mon, Jul 8, 2019 at 11:08 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Jul 5, 2019 at 1:15 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Jul 03, 2019 at 05:35:58PM -0700, Brendan Higgins wrote:
> > > Add core facilities for defining unit tests; this provides a common way
> > > to define test cases, functions that execute code which is under test
> > > and determine whether the code under test behaves as expected; this also
> > > provides a way to group together related test cases in test suites (here
> > > we call them test_modules).
> > >
> > > Just define test cases and how to execute them for now; setting
> > > expectations on code will be defined later.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> >
> > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> >
> > But a nitpick below, I think that can be fixed later with a follow up
> > patch.
> >
> > > +/**
> > > + * struct kunit - represents a running instance of a test.
> > > + * @priv: for user to store arbitrary data. Commonly used to pass data created
> > > + * in the init function (see &struct kunit_suite).
> > > + *
> > > + * Used to store information about the current context under which the test is
> > > + * running. Most of this data is private and should only be accessed indirectly
> > > + * via public functions; the one exception is @priv which can be used by the
> > > + * test writer to store arbitrary data.
> > > + *
> > > + * A brief note on locking:
> > > + *
> > > + * First off, we need to lock because in certain cases a user may want to use an
> > > + * expectation in a thread other than the thread that the test case is running
> > > + * in.
> >
> > This as a prefix to the struct without a lock seems odd. It would be
> > clearer I think if you'd explain here what locking mechanism we decided
> > to use and why it suffices today.
>
> Whoops, sorry this should have been in the next patch. Will fix.

Err..no, this shouldn't be here at all. Sorry about that. I just need
to rewrite the comment.

> > > +/**
> > > + * suite_test() - used to register a &struct kunit_suite with KUnit.
> >
> > You mean kunit_test_suite()?
>
> Yep, sorry about that. Will fix.
>
> > > + * @suite: a statically allocated &struct kunit_suite.
> > > + *
> > > + * Registers @suite with the test framework. See &struct kunit_suite for more
> > > + * information.
> > > + *
> > > + * NOTE: Currently KUnit tests are all run as late_initcalls; this means that
> > > + * they cannot test anything where tests must run at a different init phase. One
> > > + * significant restriction resulting from this is that KUnit cannot reliably
> > > + * test anything that is initialize in the late_init phase.
> >                             initialize prior to the late init phase.
> >
> >
> > That is, this is useless to test things running early.
>
> Yeah, I can add that phrasing in.
>
> > > + *
> > > + * TODO(brendanhiggins@google.com): Don't run all KUnit tests as late_initcalls.
> > > + * I have some future work planned to dispatch all KUnit tests from the same
> > > + * place, and at the very least to do so after everything else is definitely
> > > + * initialized.
> >
> > TODOs are odd to be adding to documentation, this is just not common
> > place practice. The NOTE should suffice for you.
>
> Because it is a kernel doc? Would you usually make a separate
> non-kernel doc comment for a TODO? I guess that makes sense.
>
> Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

