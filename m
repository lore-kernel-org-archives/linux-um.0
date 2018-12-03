Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTy2c-0007Hs-3H
 for linux-um@lists.infradead.org; Mon, 03 Dec 2018 23:54:19 +0000
Received: by mail-ot1-x342.google.com with SMTP id 40so13449409oth.4
 for <linux-um@lists.infradead.org>; Mon, 03 Dec 2018 15:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-15-brendanhiggins@google.com>
 <b4c72234-8c56-6efa-8003-f89d99a9779e@ideasonboard.com>
 <20181130034525.GP18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130034525.GP18410@garbanzo.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 3 Dec 2018 15:53:55 -0800
Message-ID: <CAFd5g47Cew6pmebsopjzmkd4RpnnC3zLAUfxCybjdhrO35OBpQ@mail.gmail.com>
Subject: Re: [RFC v3 14/19] Documentation: kunit: add documentation for KUnit
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
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, Felix Guo <felixguoxiuping@gmail.com>, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>, joe@perches.com, khilman@baylibre.com

On Thu, Nov 29, 2018 at 7:45 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Nov 29, 2018 at 01:56:37PM +0000, Kieran Bingham wrote:
> > Hi Brendan,
> >
> > Please excuse the top posting, but I'm replying here as I'm following
> > the section "Creating a kunitconfig" in Documentation/kunit/start.rst.
> >
> > Could the three line kunitconfig file live under say
> >        arch/um/configs/kunit_defconfig?
> >
> > So that it's always provided? And could even be extended with tests
> > which people would expect to be run by default? (say in distributions)
>
> Indeed, and then a top level 'make kunitconfig' could use it as well.

Yep, I totally agree.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

