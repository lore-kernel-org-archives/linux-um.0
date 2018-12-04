Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTyAw-0002bH-9Y
 for linux-um@lists.infradead.org; Tue, 04 Dec 2018 00:02:58 +0000
Received: by mail-ot1-x344.google.com with SMTP id t5so13506219otk.1
 for <linux-um@lists.infradead.org>; Mon, 03 Dec 2018 16:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-17-brendanhiggins@google.com>
 <20181130034623.GQ18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130034623.GQ18410@garbanzo.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 3 Dec 2018 16:02:31 -0800
Message-ID: <CAFd5g463cxzsF+DJ06aL=mjGzNX1NcE5Xp8b584U2TAJ5joQKw@mail.gmail.com>
Subject: Re: [RFC v3 16/19] arch: um: make UML unflatten device tree when
 testing
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
To: mcgrof@kernel.org
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Thu, Nov 29, 2018 at 7:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 11:36:33AM -0800, Brendan Higgins wrote:
> > Make UML unflatten any present device trees when running KUnit tests.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  arch/um/kernel/um_arch.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> > index a818ccef30ca2..bd58ae3bf4148 100644
> > --- a/arch/um/kernel/um_arch.c
> > +++ b/arch/um/kernel/um_arch.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/sched/task.h>
> >  #include <linux/kmsg_dump.h>
> > +#include <linux/of_fdt.h>
> >
> >  #include <asm/pgtable.h>
> >  #include <asm/processor.h>
> > @@ -347,6 +348,9 @@ void __init setup_arch(char **cmdline_p)
> >       read_initrd();
> >
> >       paging_init();
> > +#if IS_ENABLED(CONFIG_OF_UNITTEST)
> > +     unflatten_device_tree();
> > +#endif
>
> *Why?*

Whoops, I didn't realize how bad that looked. In anycase, doing what
Rob suggested as a separate patch should clear this up.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

