Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTxYF-0005bh-DX
 for linux-um@lists.infradead.org; Mon, 03 Dec 2018 23:22:56 +0000
Received: by mail-oi1-x242.google.com with SMTP id v6so12613736oif.2
 for <linux-um@lists.infradead.org>; Mon, 03 Dec 2018 15:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-7-brendanhiggins@google.com>
 <CAL_JsqJLNSg-38hej8LV+Oh-YXBM2hRGomie3b_psa9LvzoRYg@mail.gmail.com>
 <20181130033704.GL18410@garbanzo.do-not-panic.com>
 <CAL_Jsq+jxHHmT5bLnABnF7S0fSBZvH72nDPyY5LHTn9Zm9hCUw@mail.gmail.com>
 <20181130182203.GS18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130182203.GS18410@garbanzo.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 3 Dec 2018 15:22:32 -0800
Message-ID: <CAFd5g47ndhD+j6-_tTV-9N8eY0_48kEvEO76BzOWi-BD3GYauw@mail.gmail.com>
Subject: Re: [RFC v3 06/19] arch: um: enable running kunit from User Mode Linux
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
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-nvdimm@lists.01.org, richard@nod.at, Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com, Joel Stanley <joel@jms.id.au>, jdike@addtoit.com, Arnd Bergmann <arnd@arndb.de>, Tim.Bird@sony.com, Kees Cook <keescook@google.com>, linux-um@lists.infradead.org, rostedt@goodmis.org, Julia Lawall <julia.lawall@lip6.fr>, dan.j.williams@intel.com, kunit-dev@googlegroups.com, Greg KH <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Fri, Nov 30, 2018 at 10:22 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Nov 30, 2018 at 08:05:34AM -0600, Rob Herring wrote:
> > On Thu, Nov 29, 2018 at 9:37 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Wed, Nov 28, 2018 at 03:26:03PM -0600, Rob Herring wrote:
> > > > On Wed, Nov 28, 2018 at 1:37 PM Brendan Higgins
> > > > <brendanhiggins@google.com> wrote:
> > > > >
> > > > > Make minimum number of changes outside of the KUnit directories for
> > > > > KUnit to build and run using UML.
> > > >
> > > > There's nothing in this patch limiting this to UML.
> > >
> > > Not that one, but the abort thing segv thing is, eventually.
> > > To support other architectures we'd need to make a wrapper to that
> > > hack which Brendan added, and then allow each os to implement
> > > its own call, and add an asm-generic helper.

I think Rob is referring to the description for this patch. This patch
previously did what you suggested, Luis, (source the KUnit kconfig
from arch/um/) but Kees asked me to change it to how it is now (which
probably makes sense if we are saying KUnit is not intended to be tied
to a particular architecture, no?), and I forgot to update the commit
description, sorry.

> >
> > I've not looked into why this is needed, but can't you make the abort
> > support optional and arches can select it when they support it.
>
> Its why I have asked for it to be properly documented. The patches in no
> way illustrate *why* such thing is done. And if we are going to
> potentially have other archs do something similar best to make it
> explicit.

Yeah, I should better document it. I should also probably not include
any UML specific header files in kunit/test.h; that seems like I am
asking to get more tightly coupled if I am not careful about exactly
what things I depend on.

I think Luis is right, I need to add a wrapper around the features
needed for the hack to support abort() and then write a UML specific
implementation.

For the asm-generic case, we could probably just have abort() call
BUG(), with that KUnit should work on most architectures, albeit with
pretty reduced functionality.

>
> > At
> > least before, the DT unittests didn't need this to run and shouldn't
> > depend on it after converting to kunit.

Fair enough.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

