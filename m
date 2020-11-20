Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgEGx-00018W-5t
 for linux-um@lists.infradead.org; Fri, 20 Nov 2020 21:48:52 +0000
Received: by mail-pg1-f193.google.com with SMTP id f18so8439427pgi.8
 for <linux-um@lists.infradead.org>; Fri, 20 Nov 2020 13:48:49 -0800 (PST)
Date: Fri, 20 Nov 2020 13:48:47 -0800
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] drivers: fpga: Specify HAS_IOMEM dependency for FPGA_DFL
Message-ID: <X7g5v94FINKC+f8i@archbook>
References: <20201119082209.3598354-1-davidgow@google.com>
 <X7dhwNFehhCRs7Ry@epycbox.lan>
 <CABVgOSmat7h9qqtEokwX69Aj-Q5AiAxU2G3yz_4ZMpmAArur7w@mail.gmail.com>
 <20201120074012.GB12837@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201120074012.GB12837@yilunxu-OptiPlex-7050>
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
To: Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Moritz Fischer <mdf@kernel.org>, David Gow <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>

Hi David,

On Fri, Nov 20, 2020 at 03:40:13PM +0800, Xu Yilun wrote:
> On Fri, Nov 20, 2020 at 03:30:35PM +0800, David Gow wrote:
> > On Fri, Nov 20, 2020 at 2:27 PM Moritz Fischer <mdf@kernel.org> wrote:
> > >
> > > Hi David,
> > >
> > > On Thu, Nov 19, 2020 at 12:22:09AM -0800, David Gow wrote:
> > > > Because dfl.c uses the 'devm_ioremap', 'devm_iounmap',
> > > > 'devm_ioremap_resource', and 'devm_platform_ioremap_resource'
> > > > functions, it should depend on HAS_IOMEM.
> > > >
> > > > This fixes make allyesconfig under UML (ARCH=um), which doesn't provide
> > > > HAS_IOMEM.
> > > >
> > > > Signed-off-by: David Gow <davidgow@google.com>
> > > > ---
> > > >  drivers/fpga/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > > index 7cd5a29fc437..5645226ca3ce 100644
> > > > --- a/drivers/fpga/Kconfig
> > > > +++ b/drivers/fpga/Kconfig
> > > > @@ -142,6 +142,7 @@ config FPGA_DFL
> > > >       tristate "FPGA Device Feature List (DFL) support"
> > > >       select FPGA_BRIDGE
> > > >       select FPGA_REGION
> > > > +     depends on HAS_IOMEM
> > > >       help
> > > >         Device Feature List (DFL) defines a feature list structure that
> > > >         creates a linked list of feature headers within the MMIO space
> > > > --
> > > > 2.29.2.454.gaff20da3a2-goog
> > > >
> > > Do you think we can add a Fixes: tag for this?
> > 
> > Sure. I think it should be:
> > 
> > Fixes: 543be3d ("fpga: add device feature list support")
> 
> I think it should be:
> 
> Fixes: 89eb35e810a8 ("fpga: dfl: map feature mmio resources in their own feature drivers")
I think so, yes.

Can you resend?

Cheers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

