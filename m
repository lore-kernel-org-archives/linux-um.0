Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hMQah-0005jR-QY
 for linux-um@lists.infradead.org; Fri, 03 May 2019 05:18:37 +0000
Received: by mail-ot1-x342.google.com with SMTP id e108so4244427ote.10
 for <linux-um@lists.infradead.org>; Thu, 02 May 2019 22:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-8-brendanhiggins@google.com>
 <d4934565-9b41-880e-3bbe-984224b50fac@kernel.org>
In-Reply-To: <d4934565-9b41-880e-3bbe-984224b50fac@kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 2 May 2019 22:18:22 -0700
Message-ID: <CAFd5g44ex8B71K78V7-kRqcRw18Jou_c0KFtTR7wBpArw+P+MQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] kunit: test: add initial tests
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
Cc: Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, linux-kbuild@vger.kernel.org, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, skhan@linuxfoundation.org, Dan Williams <dan.j.williams@intel.com>, kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>

On Thu, May 2, 2019 at 6:27 PM shuah <shuah@kernel.org> wrote:
>
> On 5/1/19 5:01 PM, Brendan Higgins wrote:
> > Add a test for string stream along with a simpler example.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >   kunit/Kconfig              | 12 ++++++
> >   kunit/Makefile             |  4 ++
> >   kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++
> >   kunit/string-stream-test.c | 61 ++++++++++++++++++++++++++
> >   4 files changed, 165 insertions(+)
> >   create mode 100644 kunit/example-test.c
> >   create mode 100644 kunit/string-stream-test.c
> >
> > diff --git a/kunit/Kconfig b/kunit/Kconfig
> > index 64480092b2c24..5cb500355c873 100644
> > --- a/kunit/Kconfig
> > +++ b/kunit/Kconfig
> > @@ -13,4 +13,16 @@ config KUNIT
> >         special hardware. For more information, please see
> >         Documentation/kunit/
> >
> > +config KUNIT_TEST
> > +     bool "KUnit test for KUnit"
> > +     depends on KUNIT
> > +     help
> > +       Enables KUnit test to test KUnit.
> > +
>
> Please add a bit more information on what this config option
> does. Why should user care to enable it?
>
> > +config KUNIT_EXAMPLE_TEST
> > +     bool "Example test for KUnit"
> > +     depends on KUNIT
> > +     help
> > +       Enables example KUnit test to demo features of KUnit.
> > +
>
> Same here.

Sounds reasonable. Will fix in the next revision.

< snip >

Thanks!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

