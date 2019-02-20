Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwIjL-0000z2-OX
 for linux-um@lists.infradead.org; Wed, 20 Feb 2019 03:39:33 +0000
Received: by mail-ot1-x341.google.com with SMTP id z19so37983180otm.2
 for <linux-um@lists.infradead.org>; Tue, 19 Feb 2019 19:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-9-brendanhiggins@google.com>
 <da1995fa-a362-dfe6-8184-7fcdf2b923e8@gmail.com>
In-Reply-To: <da1995fa-a362-dfe6-8184-7fcdf2b923e8@gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 19 Feb 2019 19:39:19 -0800
Message-ID: <CAFd5g467OV8wTB7zEshgZw8g8=zoq0dLVfwx3wDH-8UA+9GWFA@mail.gmail.com>
Subject: Re: [RFC v4 08/17] kunit: test: add support for test abort
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
To: Frank Rowand <frowand.list@gmail.com>
Cc: brakmo@fb.com, Petr Mladek <pmladek@suse.com>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Richard Weinberger <richard@nod.at>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, Jeff Dike <jdike@addtoit.com>, dan.carpenter@oracle.com, devicetree <devicetree@vger.kernel.org>, "Bird," Timothy" <Tim.Bird@sony.com>, Kees Cook <keescook@google.com>," linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>, Kevin Hilman <khilman@baylibre.com>

On Mon, Feb 18, 2019 at 11:52 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/14/19 1:37 PM, Brendan Higgins wrote:
> > Add support for aborting/bailing out of test cases. Needed for
> > implementing assertions.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> > Changes Since Last Version
> >  - This patch is new introducing a new cross-architecture way to abort
> >    out of a test case (needed for KUNIT_ASSERT_*, see next patch for
> >    details).
> >  - On a side note, this is not a complete replacement for the UML abort
> >    mechanism, but covers the majority of necessary functionality. UML
> >    architecture specific featurs have been dropped from the initial
> >    patchset.
> > ---
> >  include/kunit/test.h |  24 +++++
> >  kunit/Makefile       |   3 +-
> >  kunit/test-test.c    | 127 ++++++++++++++++++++++++++
> >  kunit/test.c         | 208 +++++++++++++++++++++++++++++++++++++++++--
> >  4 files changed, 353 insertions(+), 9 deletions(-)
> >  create mode 100644 kunit/test-test.c
>
> < snip >
>
> > diff --git a/kunit/test.c b/kunit/test.c
> > index d18c50d5ed671..6e5244642ab07 100644
> > --- a/kunit/test.c
> > +++ b/kunit/test.c
> > @@ -6,9 +6,9 @@
> >   * Author: Brendan Higgins <brendanhiggins@google.com>
> >   */
> >
> > -#include <linux/sched.h>
> >  #include <linux/sched/debug.h>
> > -#include <os.h>
> > +#include <linux/completion.h>
> > +#include <linux/kthread.h>
> >  #include <kunit/test.h>
> >
> >  static bool kunit_get_success(struct kunit *test)
> > @@ -32,6 +32,27 @@ static void kunit_set_success(struct kunit *test, bool success)
> >       spin_unlock_irqrestore(&test->lock, flags);
> >  }
> >
> > +static bool kunit_get_death_test(struct kunit *test)
> > +{
> > +     unsigned long flags;
> > +     bool death_test;
> > +
> > +     spin_lock_irqsave(&test->lock, flags);
> > +     death_test = test->death_test;
> > +     spin_unlock_irqrestore(&test->lock, flags);
> > +
> > +     return death_test;
> > +}
> > +
> > +static void kunit_set_death_test(struct kunit *test, bool death_test)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&test->lock, flags);
> > +     test->death_test = death_test;
> > +     spin_unlock_irqrestore(&test->lock, flags);
> > +}
> > +
> >  static int kunit_vprintk_emit(const struct kunit *test,
> >                             int level,
> >                             const char *fmt,
> > @@ -70,13 +91,29 @@ static void kunit_fail(struct kunit *test, struct kunit_stream *stream)
> >       stream->commit(stream);
> >  }
> >
> > +static void __noreturn kunit_abort(struct kunit *test)
> > +{
> > +     kunit_set_death_test(test, true);
> > +
> > +     test->try_catch.throw(&test->try_catch);
> > +
> > +     /*
> > +      * Throw could not abort from test.
> > +      */
> > +     kunit_err(test, "Throw could not abort from test!");
> > +     show_stack(NULL, NULL);
> > +     BUG();
>
> kunit_abort() is what will be call as the result of an assert failure.

Yep. Does that need clarified somewhere?

>
> BUG(), which is a panic, which is crashing the system is not acceptable
> in the Linux kernel.  You will just annoy Linus if you submit this.

Sorry, I thought this was an acceptable use case since, a) this should
never be compiled in a production kernel, b) we are in a pretty bad,
unpredictable state if we get here and keep going. I think you might
have said elsewhere that you think "a" is not valid? In any case, I
can replace this with a WARN, would that be acceptable?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

