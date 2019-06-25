Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hfu8E-0005Xm-FE
 for linux-um@lists.infradead.org; Tue, 25 Jun 2019 22:41:43 +0000
Received: by mail-pl1-x643.google.com with SMTP id g4so225928plb.5
 for <linux-um@lists.infradead.org>; Tue, 25 Jun 2019 15:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-7-brendanhiggins@google.com>
 <20190625221318.GO19023@42.do-not-panic.com>
In-Reply-To: <20190625221318.GO19023@42.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 25 Jun 2019 15:41:29 -0700
Message-ID: <CAFd5g448rYqr3PHg0cfoddr70nktkWXcRfJoZHmuPJjTW53YYg@mail.gmail.com>
Subject: Re: [PATCH v5 06/18] kbuild: enable building KUnit
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

On Tue, Jun 25, 2019 at 3:13 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Jun 17, 2019 at 01:26:01AM -0700, Brendan Higgins wrote:
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
>
> This patch would break compilation as kunit/Kconfig is not introduced. This
> would would also break bisectability on this commit. This change should
> either be folded in to the next patch, or just be a separate patch after
> the next one.

Maybe my brain isn't working right now, but I am pretty darn sure that
I introduce kunit/Kconfig in the very first patch of this series.
Quoting from the change summary from the first commit:

>  include/kunit/test.h | 161 +++++++++++++++++++++++++++++++++
>  kunit/Kconfig        |  17 ++++
>  kunit/Makefile       |   1 +
>  kunit/test.c         | 210 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 389 insertions(+)
>  create mode 100644 include/kunit/test.h
>  create mode 100644 kunit/Kconfig

I am not crazy, right?

>  create mode 100644 kunit/Makefile
>  create mode 100644 kunit/test.c

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

