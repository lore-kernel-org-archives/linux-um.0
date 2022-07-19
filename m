Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 19 Jul 2022 22:05:46 +0900
From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH v2 2/2] asm-generic: Add new pci.h and use it
Message-ID: <YtasKiPrkFlBXZvh@antec>
References: <20220717033453.2896843-1-shorne@gmail.com>
 <20220717033453.2896843-3-shorne@gmail.com>
 <YtTjeEnKr8f8z4JS@infradead.org>
 <CAK8P3a1KJe4K5g1z-Faoxc9NhXqjCUWxnvk2HPxsj2wzG_iDbg@mail.gmail.com>
 <CAAfxs740yz1vJmtFHOPTXT6fqi0+37SR_OhoGsONe4mx_21+_g@mail.gmail.com>
 <CAK8P3a1Mo9+-t21rkP8SDnPrmbj3-uuVPtmHbeUerAevxN3TNw@mail.gmail.com>
 <YtaNvpE7AA/4eV1I@antec>
 <CAK8P3a2UTND+F83k2uQ+f=o1GWV=oa5coshy8Hy+cKHUGuNzEg@mail.gmail.com>
 <YtaiSEAnMhVqR4HS@antec>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YtaiSEAnMhVqR4HS@antec>
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

On Tue, Jul 19, 2022 at 09:23:36PM +0900, Stafford Horne wrote:
> On Tue, Jul 19, 2022 at 01:55:03PM +0200, Arnd Bergmann wrote:
> > On Tue, Jul 19, 2022 at 12:55 PM Stafford Horne <shorne@gmail.com> wrote:
> > 
> > > diff --git a/drivers/comedi/drivers/comedi_isadma.c b/drivers/comedi/drivers/comedi_isadma.c
> > > index 700982464c53..508421809128 100644
> > > --- a/drivers/comedi/drivers/comedi_isadma.c
> > > +++ b/drivers/comedi/drivers/comedi_isadma.c
> > > @@ -104,8 +104,10 @@ unsigned int comedi_isadma_poll(struct comedi_isadma *dma)
> > >
> > >         flags = claim_dma_lock();
> > >         clear_dma_ff(desc->chan);
> > > +#ifdef CONFIG_X86_32
> > >         if (!isa_dma_bridge_buggy)
> > >                 disable_dma(desc->chan);
> > > +#endif
> > 
> > There is a logic mistake here: if we are on something other than x86-32,
> > this always needs to call the disable_dma()/enable_dma().
> 
> Oops, thats right.  Sorry, I should have noticed that.
> 
> > Not sure how to best express this in a readable way, something like this
> > would work:
> 
> Option 1:
> 
> > #ifdef CONFIG_X86_32
> >         if (!isa_dma_bridge_buggy)
> > #endif
> >                disable_dma(desc->chan);
> > 
> > 
> > or possibly at the start of this file, a
> 
> Option 2:
> 
> > #ifndef CONFIG_X86_32
> > #define isa_dma_bridge_buggy 0
> > #endif
> 
> Option 3:
> 
> > Or we could try to keep the generic definition in a global header
> > like linux/isa-dma.h.
> 
> Perhaps option 3 makes the whole patch the most clean.

And this is the result, I will get this into the series and create a v4 tomorrow
if no issues.

-Stafford

--

diff --git a/arch/alpha/include/asm/dma.h b/arch/alpha/include/asm/dma.h
index 28610ea7786d..a04d76b96089 100644
--- a/arch/alpha/include/asm/dma.h
+++ b/arch/alpha/include/asm/dma.h
@@ -365,13 +365,4 @@ extern void free_dma(unsigned int dmanr);	/* release it again */
 #define KERNEL_HAVE_CHECK_DMA
 extern int check_dma(unsigned int dmanr);
 
-/* From PCI */
-
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy 	(0)
-#endif
-
-
 #endif /* _ASM_DMA_H */
diff --git a/arch/arc/include/asm/dma.h b/arch/arc/include/asm/dma.h
index 5b744f4b10a7..02431027ed2f 100644
--- a/arch/arc/include/asm/dma.h
+++ b/arch/arc/include/asm/dma.h
@@ -7,10 +7,5 @@
 #define ASM_ARC_DMA_H
 
 #define MAX_DMA_ADDRESS 0xC0000000
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy	0
-#endif
 
 #endif
diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index a81dda65c576..907d139be431 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -143,10 +143,4 @@ extern int  get_dma_residue(unsigned int chan);
 
 #endif /* CONFIG_ISA_DMA_API */
 
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy    (0)
-#endif
-
 #endif /* __ASM_ARM_DMA_H */
diff --git a/arch/ia64/include/asm/dma.h b/arch/ia64/include/asm/dma.h
index 59625e9c1f9c..eaed2626ffda 100644
--- a/arch/ia64/include/asm/dma.h
+++ b/arch/ia64/include/asm/dma.h
@@ -12,8 +12,6 @@
 
 extern unsigned long MAX_DMA_ADDRESS;
 
-extern int isa_dma_bridge_buggy;
-
 #define free_dma(x)
 
 #endif /* _ASM_IA64_DMA_H */
diff --git a/arch/m68k/include/asm/dma.h b/arch/m68k/include/asm/dma.h
index f6c5e0dfb4e5..1c8d9c5bc2fa 100644
--- a/arch/m68k/include/asm/dma.h
+++ b/arch/m68k/include/asm/dma.h
@@ -6,10 +6,4 @@
    bootmem allocator (but this should do it for this) */
 #define MAX_DMA_ADDRESS PAGE_OFFSET
 
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy    (0)
-#endif
-
 #endif /* _M68K_DMA_H */
diff --git a/arch/microblaze/include/asm/dma.h b/arch/microblaze/include/asm/dma.h
index f801582be912..7484c9eb66c4 100644
--- a/arch/microblaze/include/asm/dma.h
+++ b/arch/microblaze/include/asm/dma.h
@@ -9,10 +9,4 @@
 /* Virtual address corresponding to last available physical memory address.  */
 #define MAX_DMA_ADDRESS (CONFIG_KERNEL_START + memory_size - 1)
 
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy     (0)
-#endif
-
 #endif /* _ASM_MICROBLAZE_DMA_H */
diff --git a/arch/mips/include/asm/dma.h b/arch/mips/include/asm/dma.h
index be726b943530..d6186e6bea7e 100644
--- a/arch/mips/include/asm/dma.h
+++ b/arch/mips/include/asm/dma.h
@@ -307,12 +307,4 @@ static __inline__ int get_dma_residue(unsigned int dmanr)
 extern int request_dma(unsigned int dmanr, const char * device_id);	/* reserve a DMA channel */
 extern void free_dma(unsigned int dmanr);	/* release it again */
 
-/* From PCI */
-
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy	(0)
-#endif
-
 #endif /* _ASM_DMA_H */
diff --git a/arch/parisc/include/asm/dma.h b/arch/parisc/include/asm/dma.h
index eea80ed34e6d..9e8c101de902 100644
--- a/arch/parisc/include/asm/dma.h
+++ b/arch/parisc/include/asm/dma.h
@@ -176,10 +176,4 @@ static __inline__ void set_dma_count(unsigned int dmanr, unsigned int count)
 
 #define free_dma(dmanr)
 
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy 	(0)
-#endif
-
 #endif /* _ASM_DMA_H */
diff --git a/arch/powerpc/include/asm/dma.h b/arch/powerpc/include/asm/dma.h
index 6161a9596196..d97c66d9ae34 100644
--- a/arch/powerpc/include/asm/dma.h
+++ b/arch/powerpc/include/asm/dma.h
@@ -340,11 +340,5 @@ extern int request_dma(unsigned int dmanr, const char *device_id);
 /* release it again */
 extern void free_dma(unsigned int dmanr);
 
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy	(0)
-#endif
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_DMA_H */
diff --git a/arch/s390/include/asm/dma.h b/arch/s390/include/asm/dma.h
index 6f26f35d4a71..dec1c4ce628c 100644
--- a/arch/s390/include/asm/dma.h
+++ b/arch/s390/include/asm/dma.h
@@ -11,10 +11,4 @@
  */
 #define MAX_DMA_ADDRESS         0x80000000
 
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy	(0)
-#endif
-
 #endif /* _ASM_S390_DMA_H */
diff --git a/arch/sh/include/asm/dma.h b/arch/sh/include/asm/dma.h
index 17d23ae98c77..c8bee3f985a2 100644
--- a/arch/sh/include/asm/dma.h
+++ b/arch/sh/include/asm/dma.h
@@ -137,10 +137,4 @@ extern int register_chan_caps(const char *dmac, struct dma_chan_caps *capslist);
 extern int dma_create_sysfs_files(struct dma_channel *, struct dma_info *);
 extern void dma_remove_sysfs_files(struct dma_channel *, struct dma_info *);
 
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy	(0)
-#endif
-
 #endif /* __ASM_SH_DMA_H */
diff --git a/arch/sparc/include/asm/dma.h b/arch/sparc/include/asm/dma.h
index 462e7c794a09..08043f35b110 100644
--- a/arch/sparc/include/asm/dma.h
+++ b/arch/sparc/include/asm/dma.h
@@ -82,14 +82,6 @@
 #define DMA_BURST64      0x40
 #define DMA_BURSTBITS    0x7f
 
-/* From PCI */
-
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy 	(0)
-#endif
-
 #ifdef CONFIG_SPARC32
 struct device;
 
diff --git a/arch/x86/include/asm/dma.h b/arch/x86/include/asm/dma.h
index 8e95aa4b0d17..8ae6e0e11b8b 100644
--- a/arch/x86/include/asm/dma.h
+++ b/arch/x86/include/asm/dma.h
@@ -307,12 +307,4 @@ extern int request_dma(unsigned int dmanr, const char *device_id);
 extern void free_dma(unsigned int dmanr);
 #endif
 
-/* From PCI */
-
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy	(0)
-#endif
-
 #endif /* _ASM_X86_DMA_H */
diff --git a/arch/xtensa/include/asm/dma.h b/arch/xtensa/include/asm/dma.h
index bb099a373b5a..172644539032 100644
--- a/arch/xtensa/include/asm/dma.h
+++ b/arch/xtensa/include/asm/dma.h
@@ -52,11 +52,4 @@
 extern int request_dma(unsigned int dmanr, const char * device_id);
 extern void free_dma(unsigned int dmanr);
 
-#ifdef CONFIG_PCI
-extern int isa_dma_bridge_buggy;
-#else
-#define isa_dma_bridge_buggy 	(0)
-#endif
-
-
 #endif
diff --git a/drivers/comedi/drivers/comedi_isadma.c b/drivers/comedi/drivers/comedi_isadma.c
index 700982464c53..1d470b0da34c 100644
--- a/drivers/comedi/drivers/comedi_isadma.c
+++ b/drivers/comedi/drivers/comedi_isadma.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/isa-dma.h>
 #include <asm/dma.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/comedi/comedi_isadma.h>
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cfaf40a540a8..60c55d2cb2cc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -41,8 +41,10 @@ const char *pci_power_names[] = {
 };
 EXPORT_SYMBOL_GPL(pci_power_names);
 
+#ifdef CONFIG_X86_32
 int isa_dma_bridge_buggy;
 EXPORT_SYMBOL(isa_dma_bridge_buggy);
+#endif
 
 int pci_pci_problems;
 EXPORT_SYMBOL(pci_pci_problems);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 41aeaa235132..6fc64509eee7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/pci.h>
+#include <linux/isa-dma.h> /* isa_dma_bridge_buggy */
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/acpi.h>
@@ -30,7 +31,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
 #include <linux/switchtec.h>
-#include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
 static ktime_t fixup_debug_start(struct pci_dev *dev,
@@ -239,6 +239,7 @@ static void quirk_passive_release(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82441,	quirk_passive_release);
 
+#ifdef CONFIG_X86_32
 /*
  * The VIA VP2/VP3/MVP3 seem to have some 'features'. There may be a
  * workaround but VIA don't answer queries. If you happen to have good
@@ -265,6 +266,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1533,		quirk_isa_dma
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_1,	quirk_isa_dma_hangs);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_2,	quirk_isa_dma_hangs);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_dma_hangs);
+#endif
 
 /*
  * Intel NM10 "TigerPoint" LPC PM1a_STS.BM_STS must be clear
diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
index 556147983911..3ceb0cb12321 100644
--- a/include/asm-generic/pci.h
+++ b/include/asm-generic/pci.h
@@ -18,8 +18,6 @@
 #define pcibios_assign_all_busses() 1
 #endif
 
-extern int isa_dma_bridge_buggy;
-
 /* Enable generic resource mapping code in drivers/pci/ */
 #define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
diff --git a/include/linux/isa-dma.h b/include/linux/isa-dma.h
new file mode 100644
index 000000000000..9514f0949fa1
--- /dev/null
+++ b/include/linux/isa-dma.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_ISA_DMA_H
+#define __LINUX_ISA_DMA_H
+
+#if defined(CONFIG_PCI) && defined(CONFIG_X86_32)
+extern int isa_dma_bridge_buggy;
+#else
+#define isa_dma_bridge_buggy	(0)
+#endif
+
+#endif /* __LINUX_ISA_DMA_H */
diff --git a/sound/core/isadma.c b/sound/core/isadma.c
index 1f45ede023b4..9516cfb3d237 100644
--- a/sound/core/isadma.c
+++ b/sound/core/isadma.c
@@ -12,6 +12,7 @@
 #undef HAVE_REALLY_SLOW_DMA_CONTROLLER
 
 #include <linux/export.h>
+#include <linux/isa-dma.h>
 #include <sound/core.h>
 #include <asm/dma.h>
 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

