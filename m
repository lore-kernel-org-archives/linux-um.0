Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iukm3-0005Nf-Sv
 for linux-um@lists.infradead.org; Thu, 23 Jan 2020 22:16:29 +0000
Received: by mail-pl1-x644.google.com with SMTP id q13so1241623pls.1
 for <linux-um@lists.infradead.org>; Thu, 23 Jan 2020 14:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-7-brendanhiggins@google.com>
 <20191214112815.GA3335535@kroah.com>
In-Reply-To: <20191214112815.GA3335535@kroah.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 23 Jan 2020 14:16:15 -0800
Message-ID: <CAFd5g44Eg7DjBYWfKZ-s860X+GW65k-RtwjfEbeGXkKQ99h8WA@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] staging: axis-fifo: add unspecified HAS_IOMEM
 dependency
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moses Christopher <moseschristopherb@gmail.com>, devel@driverdev.osuosl.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Gow <davidgow@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Sat, Dec 14, 2019 at 3:28 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 11, 2019 at 11:27:41AM -0800, Brendan Higgins wrote:
> > Currently CONFIG_XIL_AXIS_FIFO=y implicitly depends on
> > CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> > the following build error:
> >
> > ld: drivers/staging/axis-fifo/axis-fifo.o: in function `axis_fifo_probe':
> > drivers/staging/axis-fifo/axis-fifo.c:809: undefined reference to `devm_ioremap_resource'
> >
> > Fix the build error by adding the unspecified dependency.
> >
> > Reported-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>
> Saying you reported a problem and then fixed it kind of does a bit of
> disservice to the "reported-by:" tag which we normally use only to
> credit the people that do not actually fix the problem.
>
> So in the future, no need for this to be there for patches that you
> write yourself.

Alright, thanks for spelling that out. I will remember that in the future.

Cheers!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

