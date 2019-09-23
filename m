Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCSjJ-0003wo-Kr
 for linux-um@lists.infradead.org; Mon, 23 Sep 2019 18:06:35 +0000
Received: by mail-pl1-x641.google.com with SMTP id d3so6849205plr.1
 for <linux-um@lists.infradead.org>; Mon, 23 Sep 2019 11:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20190923090249.127984-16-brendanhiggins@google.com>
 <d87eba35-ae09-0c53-bbbe-51ee9dc9531f@infradead.org>
In-Reply-To: <d87eba35-ae09-0c53-bbbe-51ee9dc9531f@infradead.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 23 Sep 2019 11:06:19 -0700
Message-ID: <CAFd5g45y-NWzbn8E8hUg=n4U5E+N6_4D8eCXhQ74Y0N4zqVW=w@mail.gmail.com>
Subject: Re: [PATCH v18 15/19] Documentation: kunit: add documentation for
 KUnit
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Ellerman <mpe@ellerman.id.au>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Linus Torvalds <torvalds@linux-foundation.org>, Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>, Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree <devicetree@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird, Timothy  <Tim.Bird@sony.com>, linux-um@lists.infradead.org, Steven Rostedt" <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Kevin Hilman <khilman@baylibre.com>

On Mon, Sep 23, 2019 at 8:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/23/19 2:02 AM, Brendan Higgins wrote:
> > Add documentation for KUnit, the Linux kernel unit testing framework.
> > - Add intro and usage guide for KUnit
> > - Add API reference
> >
> > Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  Documentation/dev-tools/index.rst           |   1 +
> >  Documentation/dev-tools/kunit/api/index.rst |  16 +
> >  Documentation/dev-tools/kunit/api/test.rst  |  11 +
> >  Documentation/dev-tools/kunit/faq.rst       |  62 +++
> >  Documentation/dev-tools/kunit/index.rst     |  79 +++
> >  Documentation/dev-tools/kunit/start.rst     | 180 ++++++
> >  Documentation/dev-tools/kunit/usage.rst     | 576 ++++++++++++++++++++
> >  7 files changed, 925 insertions(+)
> >  create mode 100644 Documentation/dev-tools/kunit/api/index.rst
> >  create mode 100644 Documentation/dev-tools/kunit/api/test.rst
> >  create mode 100644 Documentation/dev-tools/kunit/faq.rst
> >  create mode 100644 Documentation/dev-tools/kunit/index.rst
> >  create mode 100644 Documentation/dev-tools/kunit/start.rst
> >  create mode 100644 Documentation/dev-tools/kunit/usage.rst
>
>
> > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > new file mode 100644
> > index 000000000000..6dc229e46bb3
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/start.rst
> > @@ -0,0 +1,180 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +===============
> > +Getting Started
> > +===============
> > +
> > +Installing dependencies
> > +=======================
> > +KUnit has the same dependencies as the Linux kernel. As long as you can build
> > +the kernel, you can run KUnit.
> > +
> > +KUnit Wrapper
> > +=============
> > +Included with KUnit is a simple Python wrapper that helps format the output to
> > +easily use and read KUnit output. It handles building and running the kernel, as
> > +well as formatting the output.
> > +
> > +The wrapper can be run with:
> > +
> > +.. code-block:: bash
> > +
> > +   ./tools/testing/kunit/kunit.py run
> > +
> > +Creating a kunitconfig
> > +======================
> > +The Python script is a thin wrapper around Kbuild as such, it needs to be
>
>                                        around Kbuild. As such,

Thanks for pointing this out.

>
> > +configured with a ``kunitconfig`` file. This file essentially contains the
> > +regular Kernel config, with the specific test targets as well.
> > +
> > +.. code-block:: bash
> > +
> > +     git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
> > +     cd $PATH_TO_LINUX_REPO
> > +     ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
> > +
> > +You may want to add kunitconfig to your local gitignore.
> > +
> > +Verifying KUnit Works
> > +---------------------
> > +
> > +To make sure that everything is set up correctly, simply invoke the Python
> > +wrapper from your kernel repo:
> > +
> > +.. code-block:: bash
> > +
> > +     ./tools/testing/kunit/kunit.py
> > +
> > +.. note::
> > +   You may want to run ``make mrproper`` first.
>
> I normally use O=builddir when building kernels.
> Does this support using O=builddir ?

Yep, it supports specifying a separate build directory.

> > +
> > +If everything worked correctly, you should see the following:
> > +
> > +.. code-block:: bash
> > +
> > +     Generating .config ...
> > +     Building KUnit Kernel ...
> > +     Starting KUnit Kernel ...
> > +
> > +followed by a list of tests that are run. All of them should be passing.
> > +
> > +.. note::
> > +   Because it is building a lot of sources for the first time, the ``Building
> > +   kunit kernel`` step may take a while.
> > +
> > +Writing your first test
> > +=======================
>
> [snip]
>
> > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> > new file mode 100644
> > index 000000000000..c6e69634e274
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/usage.rst
>
> TBD...

What did you mean by this comment?

Cheers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

