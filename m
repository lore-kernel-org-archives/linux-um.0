Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg15q-0008PA-6G
 for linux-um@lists.infradead.org; Fri, 20 Nov 2020 07:44:31 +0000
Date: Fri, 20 Nov 2020 15:40:13 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH] drivers: fpga: Specify HAS_IOMEM dependency for FPGA_DFL
Message-ID: <20201120074012.GB12837@yilunxu-OptiPlex-7050>
References: <20201119082209.3598354-1-davidgow@google.com>
 <X7dhwNFehhCRs7Ry@epycbox.lan>
 <CABVgOSmat7h9qqtEokwX69Aj-Q5AiAxU2G3yz_4ZMpmAArur7w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABVgOSmat7h9qqtEokwX69Aj-Q5AiAxU2G3yz_4ZMpmAArur7w@mail.gmail.com>
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
To: David Gow <davidgow@google.com>
Cc: Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Moritz Fischer <mdf@kernel.org>, Brendan Higgins <brendanhiggins@google.com>

On Fri, Nov 20, 2020 at 03:30:35PM +0800, David Gow wrote:
> On Fri, Nov 20, 2020 at 2:27 PM Moritz Fischer <mdf@kernel.org> wrote:
> >
> > Hi David,
> >
> > On Thu, Nov 19, 2020 at 12:22:09AM -0800, David Gow wrote:
> > > Because dfl.c uses the 'devm_ioremap', 'devm_iounmap',
> > > 'devm_ioremap_resource', and 'devm_platform_ioremap_resource'
> > > functions, it should depend on HAS_IOMEM.
> > >
> > > This fixes make allyesconfig under UML (ARCH=um), which doesn't provide
> > > HAS_IOMEM.
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> > > ---
> > >  drivers/fpga/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > index 7cd5a29fc437..5645226ca3ce 100644
> > > --- a/drivers/fpga/Kconfig
> > > +++ b/drivers/fpga/Kconfig
> > > @@ -142,6 +142,7 @@ config FPGA_DFL
> > >       tristate "FPGA Device Feature List (DFL) support"
> > >       select FPGA_BRIDGE
> > >       select FPGA_REGION
> > > +     depends on HAS_IOMEM
> > >       help
> > >         Device Feature List (DFL) defines a feature list structure that
> > >         creates a linked list of feature headers within the MMIO space
> > > --
> > > 2.29.2.454.gaff20da3a2-goog
> > >
> > Do you think we can add a Fixes: tag for this?
> 
> Sure. I think it should be:
> 
> Fixes: 543be3d ("fpga: add device feature list support")

I think it should be:

Fixes: 89eb35e810a8 ("fpga: dfl: map feature mmio resources in their own feature drivers")

Thanks,
Yilun

> 
> Let me know if you want me to re-send the patch with that included.
> 
> Cheers,
> -- David

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

