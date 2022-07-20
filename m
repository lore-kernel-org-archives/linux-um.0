Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 20 Jul 2022 22:24:01 +0900
From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH v2 2/2] asm-generic: Add new pci.h and use it
Message-ID: <YtgB8SDLB4d0adfB@antec>
References: <20220717033453.2896843-1-shorne@gmail.com>
 <20220717033453.2896843-3-shorne@gmail.com>
 <YtTjeEnKr8f8z4JS@infradead.org>
 <CAK8P3a1KJe4K5g1z-Faoxc9NhXqjCUWxnvk2HPxsj2wzG_iDbg@mail.gmail.com>
 <CAAfxs740yz1vJmtFHOPTXT6fqi0+37SR_OhoGsONe4mx_21+_g@mail.gmail.com>
 <CAK8P3a1Mo9+-t21rkP8SDnPrmbj3-uuVPtmHbeUerAevxN3TNw@mail.gmail.com>
 <YtaNvpE7AA/4eV1I@antec>
 <CAK8P3a2UTND+F83k2uQ+f=o1GWV=oa5coshy8Hy+cKHUGuNzEg@mail.gmail.com>
 <YtaiSEAnMhVqR4HS@antec>
 <874af766883a4c0da6759eff433ec6d6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <874af766883a4c0da6759eff433ec6d6@AcuMS.aculab.com>
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
To: David Laight <David.Laight@aculab.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas <bhelgaas@google.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>, linux-pci <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Tue, Jul 19, 2022 at 03:09:35PM +0000, David Laight wrote:
> From: Stafford Horne
> > Sent: 19 July 2022 13:24
> > 
> > On Tue, Jul 19, 2022 at 01:55:03PM +0200, Arnd Bergmann wrote:
> > > On Tue, Jul 19, 2022 at 12:55 PM Stafford Horne <shorne@gmail.com> wrote:

> > Option 3:
> > 
> > > Or we could try to keep the generic definition in a global header
> > > like linux/isa-dma.h.
> > 
> > Perhaps option 3 makes the whole patch the most clean.
> 
> Isn't there a define that can be used inside an if?
> So you could do:
> 		if (!IS_CONFIG_X86_32 || !isa_dma_bridge_buggy)
> 			disable_dma();
> (but I can't remember the name!)

I think you probably mean:

  if (IS_ENABLED(CONFIG_X86_32) ... )

That could work too, but we still want to move the definition of
isa_dma_bridge_buggy out of architectures and into the global header.  I have
gone with option 3 for now.

-Stafford

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

