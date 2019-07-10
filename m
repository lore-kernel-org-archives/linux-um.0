Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlJC1-0001MN-FC
 for linux-um@lists.infradead.org; Wed, 10 Jul 2019 20:27:59 +0000
Received: by mail-pf1-x441.google.com with SMTP id m30so1614396pff.8
 for <linux-um@lists.infradead.org>; Wed, 10 Jul 2019 13:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
 <20190709063023.251446-17-brendanhiggins@google.com>
 <7cc417dd-036f-7dc1-6814-b1fdac810f03@kernel.org>
 <CAFd5g4595X8cM919mohQVaShs4dKWzZ_-2RVB=6SH3RdVMwuQw@mail.gmail.com>
In-Reply-To: <CAFd5g4595X8cM919mohQVaShs4dKWzZ_-2RVB=6SH3RdVMwuQw@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 10 Jul 2019 13:27:42 -0700
Message-ID: <CAFd5g45zFhBN-yrJbRt6KnFkYKxVqjs9qeQULCSD6z89vvG-Tg@mail.gmail.com>
Subject: Re: [PATCH v7 16/18] MAINTAINERS: add entry for KUnit the unit
 testing framework
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
To: shuah <shuah@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>

On Tue, Jul 9, 2019 at 11:01 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Jul 9, 2019 at 7:53 AM shuah <shuah@kernel.org> wrote:
> >
> > On 7/9/19 12:30 AM, Brendan Higgins wrote:
> > > Add myself as maintainer of KUnit, the Linux kernel's unit testing
> > > framework.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > > ---
> > >   MAINTAINERS | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 677ef41cb012c..48d04d180a988 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -8599,6 +8599,17 @@ S:     Maintained
> > >   F:  tools/testing/selftests/
> > >   F:  Documentation/dev-tools/kselftest*
> > >
> > > +KERNEL UNIT TESTING FRAMEWORK (KUnit)
> > > +M:   Brendan Higgins <brendanhiggins@google.com>
> > > +L:   linux-kselftest@vger.kernel.org
> > > +L:   kunit-dev@googlegroups.com
> > > +W:   https://google.github.io/kunit-docs/third_party/kernel/docs/
> > > +S:   Maintained
> > > +F:   Documentation/dev-tools/kunit/
> > > +F:   include/kunit/
> > > +F:   kunit/
> > > +F:   tools/testing/kunit/
> > > +
> > >   KERNEL USERMODE HELPER
> > >   M:  Luis Chamberlain <mcgrof@kernel.org>
> > >   L:  linux-kernel@vger.kernel.org
> > >
> >
> > Thanks Brendan.
> >
> > I am good with this. I can take KUnit patches through kselftest
> > with your Ack.
>
> My acknowledgement? Sure! I thought we already agreed to that.
>
> Also, do we need an ack from Masahiro or Michal for the Kbuild patch
> [PATCH v7 06/18]? And an ack from Josh or Peter for the objtool patch
> [PATCH v7 08/18]?

By the way, I am guessing you have already seen it, but I uploaded a
new version to incorporate a suggestion made by Masahiro on patch
06/18. In addition, I have gotten acks on the two patches mentioned
above. So I think we are good to go.

Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

