Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hglxE-0006bO-Ri
 for linux-um@lists.infradead.org; Fri, 28 Jun 2019 08:09:59 +0000
Received: by mail-pg1-x544.google.com with SMTP id g15so341921pgi.4
 for <linux-um@lists.infradead.org>; Fri, 28 Jun 2019 01:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
 <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
 <20190626034100.B238520883@mail.kernel.org>
 <CAFd5g46zHAupdUh3wDuqPJti2M+_=oje_5weFe7AVLQfkDDM6A@mail.gmail.com>
 <20190627181636.5EA752064A@mail.kernel.org>
In-Reply-To: <20190627181636.5EA752064A@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 28 Jun 2019 01:09:44 -0700
Message-ID: <CAFd5g44V3ZLNazUOgOo2sFR3zzbNnTkH4e9uxGX4iHi7G73Mzw@mail.gmail.com>
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
To: Stephen Boyd <sboyd@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Kevin Hilman <khilman@baylibre.com>

On Thu, Jun 27, 2019 at 11:16 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-06-26 16:00:40)
> > On Tue, Jun 25, 2019 at 8:41 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > > scenario like below, but where it is a problem. There could be three
> > > CPUs, or even one CPU and three threads if you want to describe the
> > > extra thread scenario.
> > >
> > > Here's my scenario where it isn't needed:
> > >
> > >     CPU0                                      CPU1
> > >     ----                                      ----
> > >     kunit_run_test(&test)
> > >                                               test_case_func()
> > >                                                 ....
> > >                                               [mock hardirq]
> > >                                                 kunit_set_success(&test)
> > >                                               [hardirq ends]
> > >                                                 ...
> > >                                                 complete(&test_done)
> > >       wait_for_completion(&test_done)
> > >       kunit_get_success(&test)
> > >
> > > We don't need to care about having locking here because success or
> > > failure only happens in one place and it's synchronized with the
> > > completion.
> >
> > Here is the scenario I am concerned about:
> >
> > CPU0                      CPU1                       CPU2
> > ----                      ----                       ----
> > kunit_run_test(&test)
> >                           test_case_func()
> >                             ....
> >                             schedule_work(foo_func)
> >                           [mock hardirq]             foo_func()
> >                             ...                        ...
> >                             kunit_set_success(false)   kunit_set_success(false)
> >                           [hardirq ends]               ...
> >                             ...
> >                             complete(&test_done)
> >   wait_for_completion(...)
> >   kunit_get_success(&test)
> >
> > In my scenario, since both CPU1 and CPU2 update the success status of
> > the test simultaneously, even though they are setting it to the same
> > value. If my understanding is correct, this could result in a
> > write-tear on some architectures in some circumstances. I suppose we
> > could just make it an atomic boolean, but I figured locking is also
> > fine, and generally preferred.
>
> This is what we have WRITE_ONCE() and READ_ONCE() for. Maybe you could
> just use that in the getter and setters and remove the lock if it isn't
> used for anything else.
>
> It may also be a good idea to have a kunit_fail_test() API that fails
> the test passed in with a WRITE_ONCE(false). Otherwise, the test is
> assumed successful and it isn't even possible for a test to change the
> state from failure to success due to a logical error because the API
> isn't available. Then we don't really need to have a generic
> kunit_set_success() function at all. We could have a kunit_test_failed()
> function too that replaces the kunit_get_success() function. That would
> read better in an if condition.

You know what, I think you are right.

Sorry, for not realizing this earlier, I think you mentioned something
along these lines a long time ago.

Thanks for your patience!

> >
> > Also, to be clear, I am onboard with dropping then IRQ stuff for now.
> > I am fine moving to a mutex for the time being.
> >
>
> Ok.

Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

