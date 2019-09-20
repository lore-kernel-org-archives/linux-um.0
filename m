Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBShO-0006YH-UB
 for linux-um@lists.infradead.org; Fri, 20 Sep 2019 23:52:28 +0000
Received: by mail-pl1-x643.google.com with SMTP id e5so3922612pls.9
 for <linux-um@lists.infradead.org>; Fri, 20 Sep 2019 16:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
 <20190920231923.141900-7-brendanhiggins@google.com>
 <20190920233600.48BBA20644@mail.kernel.org>
 <CAFd5g46pndA_gOD9i8M5e5fb8x4mSL9mcgMDujN7XufeFs8bmQ@mail.gmail.com>
In-Reply-To: <CAFd5g46pndA_gOD9i8M5e5fb8x4mSL9mcgMDujN7XufeFs8bmQ@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 20 Sep 2019 16:52:14 -0700
Message-ID: <CAFd5g44E9Z=wRLarzcirAMudQ5=_3d4gnYfAwM9T2XB+sr+_qg@mail.gmail.com>
Subject: Re: [PATCH v16 06/19] lib: enable building KUnit in lib/
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
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Linus Torvalds <torvalds@linux-foundation.org>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, Kees Cook <keescook@chromium.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Logan Gunthorpe <logang@deltatee.com>, Kevin Hilman <khilman@baylibre.com>

On Fri, Sep 20, 2019 at 4:44 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Sep 20, 2019 at 4:36 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-09-20 16:19:10)
> > > KUnit is a new unit testing framework for the kernel and when used is
> > > built into the kernel as a part of it. Add KUnit to the lib Kconfig and
> > > Makefile to allow it to be actually built.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > ---
> > >  lib/Kconfig.debug | 2 ++
> > >  lib/Makefile      | 2 ++
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index 5960e2980a8a..5870fbe11e9b 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -2144,4 +2144,6 @@ config IO_STRICT_DEVMEM
> > >
> > >  source "arch/$(SRCARCH)/Kconfig.debug"
> > >
> > > +source "lib/kunit/Kconfig"
> > > +
> >
> > Perhaps this should go by the "Runtime Testing" part? Before or after.

Now I am actually thinking that it should be a menuconfig...

> > >  endmenu # Kernel hacking

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

