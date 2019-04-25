Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJm3b-0001yo-6N
 for linux-um@lists.infradead.org; Thu, 25 Apr 2019 21:37:28 +0000
Received: by mail-oi1-x241.google.com with SMTP id e5so1332817oii.0
 for <linux-um@lists.infradead.org>; Thu, 25 Apr 2019 14:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190404220652.19765-1-brendanhiggins@google.com>
 <20190404220652.19765-15-brendanhiggins@google.com>
 <20190424185813.xabwr4lt6aunvpsd@gabell>
In-Reply-To: <20190424185813.xabwr4lt6aunvpsd@gabell>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 25 Apr 2019 14:37:11 -0700
Message-ID: <CAFd5g45CD7=dMvvRgmLKomirXDWpO59hFSed9A=o0kdBxp7v-w@mail.gmail.com>
Subject: Re: [PATCH v1 14/17] Documentation: kunit: add documentation for KUnit
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
To: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: linux-doc@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Sasha Levin <Alexander.Levin@microsoft.com>, yamada.masahiro@socionext.com, devicetree <devicetree@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, "Bird, Timothy" <Tim.Bird@sony.com>, Dan Carpenter <dan.carpenter@oracle.com>, Petr Mladek <pmladek@suse.com>, linux-kbuild@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>, kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>, Greg KH <gregkh@linuxfoundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:58 AM Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>
> Hi Brendan,
>
> KUNIT_ASSERT_NOT_ERR_OR_NULL() should be replaced to
> KUNIT_EXPECT_NOT_ERR_OR_NULL(), right?

Generally speaking, no.

There may be places that I have used it improperly, but I think it is
generally okay to use.

If you are refering to the discussion with Frank and Stephen in RFC
v4, my take was that the resolution was that there were some things I
needed to fix in its implementation, but it is conceptually okay, and
that Frank doesn't want me to use it in drivers/of/unittest.c.
Consequently, I fixed the implementation issues that Frank and Stephen
pointed out, and I am holding off on drivers/of/unittest.c for this
patchset. The usage in this file should be fine.

>
> On Thu, Apr 04, 2019 at 03:06:49PM -0700, Brendan Higgins wrote:
> > Add documentation for KUnit, the Linux kernel unit testing framework.
> > - Add intro and usage guide for KUnit
> > - Add API reference
> >
> > Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
>
> <snip>

<snip>

Cheers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

