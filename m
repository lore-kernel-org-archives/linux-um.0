Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxRiM-0001pi-E5
 for linux-um@lists.infradead.org; Tue, 13 Aug 2019 07:59:31 +0000
Received: by mail-pl1-x642.google.com with SMTP id m9so48784318pls.8
 for <linux-um@lists.infradead.org>; Tue, 13 Aug 2019 00:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-15-brendanhiggins@google.com>
 <20190813043859.661F82054F@mail.kernel.org>
In-Reply-To: <20190813043859.661F82054F@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 13 Aug 2019 00:59:18 -0700
Message-ID: <CAFd5g44wUOhmxr3r+-LR_igePMjtaRrtT5jGdqPJgb0xPdf+Ag@mail.gmail.com>
Subject: Re: [PATCH v12 14/18] kunit: defconfig: add defconfigs for building
 KUnit tests
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

On Mon, Aug 12, 2019 at 9:39 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 11:24:17)
> > diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
> > new file mode 100644
> > index 0000000000000..bfe49689038f1
> > --- /dev/null
> > +++ b/arch/um/configs/kunit_defconfig
> > @@ -0,0 +1,8 @@
> > +CONFIG_OF=y
> > +CONFIG_OF_UNITTEST=y
> > +CONFIG_OF_OVERLAY=y
> > +CONFIG_I2C=y
> > +CONFIG_I2C_MUX=y
> > +CONFIG_KUNIT=y
> > +CONFIG_KUNIT_TEST=y
> > +CONFIG_KUNIT_EXAMPLE_TEST=y
> > diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
> > new file mode 100644
> > index 0000000000000..bfe49689038f1
> > --- /dev/null
> > +++ b/tools/testing/kunit/configs/all_tests.config
> > @@ -0,0 +1,8 @@
> > +CONFIG_OF=y
> > +CONFIG_OF_UNITTEST=y
> > +CONFIG_OF_OVERLAY=y
> > +CONFIG_I2C=y
> > +CONFIG_I2C_MUX=y
>
> Are these above config options necessary? I don't think they're part of
> the patch series anymore so it looks odd to enable the OF unittests and
> i2c configs.

Oh whoops, I forgot that we dropped the OF_UNITTEST from this
patchset. Will fix.

> > +CONFIG_KUNIT=y
> > +CONFIG_KUNIT_TEST=y
> > +CONFIG_KUNIT_EXAMPLE_TEST=y

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

