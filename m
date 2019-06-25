Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hfuSm-0004wU-Nn
 for linux-um@lists.infradead.org; Tue, 25 Jun 2019 23:02:58 +0000
Received: by mail-pf1-f196.google.com with SMTP id m30so181255pff.8
 for <linux-um@lists.infradead.org>; Tue, 25 Jun 2019 16:02:56 -0700 (PDT)
Date: Tue, 25 Jun 2019 23:02:53 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
Message-ID: <20190625230253.GQ19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
 <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
 <20190625214427.GN19023@42.do-not-panic.com>
 <CAFd5g47OABqN127cPKqoCOA_Wr9w=LFh_0XkF7LXu2iY9sFkSw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFd5g47OABqN127cPKqoCOA_Wr9w=LFh_0XkF7LXu2iY9sFkSw@mail.gmail.com>
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Kevin Hilman <khilman@baylibre.com>

On Tue, Jun 25, 2019 at 03:14:45PM -0700, Brendan Higgins wrote:
> On Tue, Jun 25, 2019 at 2:44 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > Since its a new architecture and since you seem to imply most tests
> > don't require locking or even IRQs disabled, I think its worth to
> > consider the impact of adding such extreme locking requirements for
> > an initial ramp up.
> 
> Fair enough, I can see the point of not wanting to use irq disabled
> until we get someone complaining about it, but I think making it
> thread safe is reasonable. It means there is one less thing to confuse
> a KUnit user and the only penalty paid is some very minor performance.

One reason I'm really excited about kunit is speed... so by all means I
think we're at a good point to analyze performance optimizationsm if
they do make sense.

While on the topic of parallization, what about support for running
different test cases in parallel? Or at the very least different kunit
modules in parallel.  Few questions come up based on this prospect:

  * Why not support parallelism from the start?
  * Are you opposed to eventually having this added? For instance, there is
    enough code on lib/test_kmod.c for batching tons of kthreads each
    one running its own thing for testing purposes which could be used
    as template.
  * If we eventually *did* support it:
    - Would logs be skewed?
    - Could we have a way to query: give me log for only kunit module
      named "foo"?

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

