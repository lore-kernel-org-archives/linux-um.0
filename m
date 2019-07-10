Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hl6ss-00022B-62
 for linux-um@lists.infradead.org; Wed, 10 Jul 2019 07:19:23 +0000
Received: by mail-pg1-x544.google.com with SMTP id i18so766057pgl.11
 for <linux-um@lists.infradead.org>; Wed, 10 Jul 2019 00:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
 <20190709063023.251446-7-brendanhiggins@google.com>
 <CAK7LNATx30AhZ51xozde=nO06-8UzuC0M9nfZXrqkyfmEFdu5w@mail.gmail.com>
In-Reply-To: <CAK7LNATx30AhZ51xozde=nO06-8UzuC0M9nfZXrqkyfmEFdu5w@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 10 Jul 2019 00:19:06 -0700
Message-ID: <CAFd5g479H3pS9preU6-oCnN5adwBPDe4zQkiFPatKPbxpT5r6w@mail.gmail.com>
Subject: Re: [PATCH v7 06/18] kbuild: enable building KUnit
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
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "Cc: Shuah Khan" <shuah@kernel.org>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, DTML <devicetree@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Tim Bird <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com, Michal Marek <michal.lkml@markovi.net>, Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Kevin Hilman <khilman@baylibre.com>

On Tue, Jul 9, 2019 at 9:00 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Tue, Jul 9, 2019 at 3:34 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > KUnit is a new unit testing framework for the kernel and when used is
> > built into the kernel as a part of it. Add KUnit to the root Kconfig and
> > Makefile to allow it to be actually built.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > ---
> >  Kconfig  | 2 ++
> >  Makefile | 2 +-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Kconfig b/Kconfig
> > index 48a80beab6853..10428501edb78 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -30,3 +30,5 @@ source "crypto/Kconfig"
> >  source "lib/Kconfig"
> >
> >  source "lib/Kconfig.debug"
> > +
> > +source "kunit/Kconfig"
> > diff --git a/Makefile b/Makefile
> > index 3e4868a6498b2..60cf4f0813e0d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -991,7 +991,7 @@ endif
> >  PHONY += prepare0
> >
> >  ifeq ($(KBUILD_EXTMOD),)
> > -core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
> > +core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/ kunit/
> >
> >  vmlinux-dirs   := $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
> >                      $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
>
>
> This is so trivial, and do not need to get ack from me.

Oh, sorry about that.

> Just a nit.
>
>
> When CONFIG_KUNIT is disable, is there any point in descending into kunit/ ?
>
> core-$(CONFIG_KUNIT) += kunit/
>
> ... might be useful to skip kunit/ entirely.

Makes sense. I just sent out a new change that does this.

Thanks!

> If you look at the top-level Makefile, some entries are doing this:
>
>
> init-y          := init/
> drivers-y       := drivers/ sound/
> drivers-$(CONFIG_SAMPLES) += samples/
> drivers-$(CONFIG_KERNEL_HEADER_TEST) += include/
> net-y           := net/
> libs-y          := lib/
> core-y          := usr/
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

