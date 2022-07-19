Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 19 Jul 2022 22:33:52 +0900
From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH v2 2/2] asm-generic: Add new pci.h and use it
Message-ID: <YtaywBinmYuMUOoI@antec>
References: <20220717033453.2896843-3-shorne@gmail.com>
 <YtTjeEnKr8f8z4JS@infradead.org>
 <CAK8P3a1KJe4K5g1z-Faoxc9NhXqjCUWxnvk2HPxsj2wzG_iDbg@mail.gmail.com>
 <CAAfxs740yz1vJmtFHOPTXT6fqi0+37SR_OhoGsONe4mx_21+_g@mail.gmail.com>
 <CAK8P3a1Mo9+-t21rkP8SDnPrmbj3-uuVPtmHbeUerAevxN3TNw@mail.gmail.com>
 <YtaNvpE7AA/4eV1I@antec>
 <CAK8P3a2UTND+F83k2uQ+f=o1GWV=oa5coshy8Hy+cKHUGuNzEg@mail.gmail.com>
 <YtaiSEAnMhVqR4HS@antec>
 <YtasKiPrkFlBXZvh@antec>
 <CAK8P3a0wraTmA6aEF+XJ0RyZV=LSrZ2uPvQmvdw=Pe=nktyGjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a0wraTmA6aEF+XJ0RyZV=LSrZ2uPvQmvdw=Pe=nktyGjQ@mail.gmail.com>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas <bhelgaas@google.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>, linux-pci <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Tue, Jul 19, 2022 at 03:18:17PM +0200, Arnd Bergmann wrote:
> On Tue, Jul 19, 2022 at 3:05 PM Stafford Horne <shorne@gmail.com> wrote:
> > On Tue, Jul 19, 2022 at 09:23:36PM +0900, Stafford Horne wrote:
> > > On Tue, Jul 19, 2022 at 01:55:03PM +0200, Arnd Bergmann wrote:
> 
> >
> > And this is the result, I will get this into the series and create a v4 tomorrow
> > if no issues.
> 
> Looks good to me, just one detail:
> 
> > diff --git a/include/linux/isa-dma.h b/include/linux/isa-dma.h
> > new file mode 100644
> > index 000000000000..9514f0949fa1
> > --- /dev/null
> > +++ b/include/linux/isa-dma.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __LINUX_ISA_DMA_H
> > +#define __LINUX_ISA_DMA_H
> > +
> > +#if defined(CONFIG_PCI) && defined(CONFIG_X86_32)
> > +extern int isa_dma_bridge_buggy;
> > +#else
> > +#define isa_dma_bridge_buggy   (0)
> > +#endif
> > +
> > +#endif /* __LINUX_ISA_DMA_H */
> 
> I would make this file #include <asm/dma.h> as a step towards making
> linux/isa-dma.h the official replacement for it in the driver api.
> 
> Including asm/dma.h from a driver is already a bit awkward, since we
> are generally moving towards including only linux/*.h type headers, and
> the dma.h name is too generic for something that is completely obsolete.

OK, that makes sense.  Then I can remove the asm/dma.h include from:
 - drivers/comedi/drivers/comedi_isadma.c
 - sound/core/isadma.c

-Stafford

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

