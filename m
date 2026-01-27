Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC71D2FED1
	for <linux-um@archiver.kernel.org>; Tue, 27 Jan 2026 18:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2GTgDTMSjRtu9XA/FLPKOljq2ml0hMhzhLI6yqYD4CI=; b=qKHIG++I6YDOVG/MEGJXM8l0Kw
	MVp9y2AyNJs8Y8QpW4hKkCTxvD7z3/BedaSwgjIQmkwBdTLt/q33lQ7QNx3aJrNrDh71JEYSMcZOX
	8ZyOG/Jb5qjKLgT2Y6zQkTbrTF458jvtebVN3W6ThMF8oPK5P9aiODPE59sdPt3d5yTfbjALdWPHJ
	QYjk8bOuyk+KH0o+HntLAaqP5q8zBxaHUO+IC+0P4RdehcFFVwIQT7EA/WrcZiCUabdplg+BADDrK
	UtuDtQHUXAbLdsVhNPgZPufwooNVixnHEDARUTgs3g1G3gDU6hAwSL5fCAX2bFN4DXe0qUE8KwDIj
	VF2gEyWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vknXT-0000000EnE5-0WJC;
	Tue, 27 Jan 2026 18:11:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vknXO-0000000EnDR-3sFA;
	Tue, 27 Jan 2026 18:11:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 503606013B;
	Tue, 27 Jan 2026 18:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4A5C116C6;
	Tue, 27 Jan 2026 18:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769537498;
	bh=esR6CFIdT2IldE04x541sMjzg2hM0kwiBu50M1Q4i6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ByaWjtsSvwoLSW/kNH7xWLyVjxxz5GlRC8jYXsgV/gqb4/lcnR/DbPtvL6ZsfFpSk
	 UMuJqyvtKtohQKsmQxoM99rDtG1O4GqRTw9ZhQsEmWLSfLiBrUcxYInGfM89HyeRgM
	 CxuZITcoVajun6fKU8J38DnbH8BoWcjGzNDWtXdHngn0Bx8YWSVtKYdo5/nJpd1YVl
	 JH22ZwPPk16pgnbMx9Vr3rouzXVb84WvDBKXKk6PK90HPv2OIOvHU6AimhWntYIXkX
	 +GnE9E9QwmWlr81X+KXfieSH8beDfJtCHQfJLkjpSxZ2STIQw2Fz3NkhSNYKoguw1h
	 QmmKWVv1yE1UQ==
Date: Tue, 27 Jan 2026 20:11:19 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH mm-unstable] arch, mm: consolidate empty_zero_page
Message-ID: <aXj_x5CyUeys7ONM@kernel.org>
References: <20260124095628.668870-1-rppt@kernel.org>
 <2157220c-0394-40fa-9918-a8514171bd10@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2157220c-0394-40fa-9918-a8514171bd10@gaisler.com>
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi,

On Tue, Jan 27, 2026 at 05:02:39PM +0100, Andreas Larsson wrote:
> On 2026-01-24 10:56, Mike Rapoport wrote:
>
> > Every architecture defines empty_zero_page that way or another, but for the
> > most of them it is always a page aligned page in BSS and most definitions
> > of ZERO_PAGE do virt_to_page(empty_zero_page).
> 
> Running this in an LDOM on an UltraSparc T4 sparc64, the entire LDOM
> hangs after a while during boot.
> 
> > diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> > index c2d19c9a9244..2bd99944176d 100644
> > --- a/arch/sparc/mm/init_64.c
> > +++ b/arch/sparc/mm/init_64.c
> > @@ -177,9 +177,6 @@ extern unsigned long sparc_ramdisk_image64;
> >  extern unsigned int sparc_ramdisk_image;
> >  extern unsigned int sparc_ramdisk_size;
> >  
> > -struct page *mem_map_zero __read_mostly;
> > -EXPORT_SYMBOL(mem_map_zero);
> > -
> >  unsigned int sparc64_highest_unlocked_tlb_ent __read_mostly;
> >  
> >  unsigned long sparc64_kern_pri_context __read_mostly;
> > @@ -2506,18 +2503,6 @@ void __init mem_init(void)
> >  	 */
> >  	register_page_bootmem_info();
> >  
> > -	/*
> > -	 * Set up the zero page, mark it reserved, so that page count
> > -	 * is not manipulated when freeing the page from user ptes.
> > -	 */
> > -	mem_map_zero = alloc_pages(GFP_KERNEL|__GFP_ZERO, 0);
> > -	if (mem_map_zero == NULL) {
> > -		prom_printf("paging_init: Cannot alloc zero page.\n");
> > -		prom_halt();
> > -	}
> > -	mark_page_reserved(mem_map_zero);
> > -
> > -
> >  	if (tlb_type == cheetah || tlb_type == cheetah_plus)
> >  		cheetah_ecache_flush_init();
> >  }
> 
> This just removes the mark_page_reserved(mem_map_zero) without 
> replacing it with something corresponding to that. Perhaps part
> of the problem?

I don't think so, empty_zero_page is in BSS now an it's reserved as a part
of the kernel image.

I suspect that virt_to_page() does not work BSS symbols on sparc64. Can you
please try with this patch:

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 74ede706fb32..0578c5172d4e 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -22,6 +22,7 @@
 #include <asm/adi.h>
 #include <asm/page.h>
 #include <asm/processor.h>
+#include <asm/vaddrs.h>
 
 /* The kernel image occupies 0x4000000 to 0x6000000 (4MB --> 96MB).
  * The page copy blockops can use 0x6000000 to 0x8000000.
@@ -210,6 +211,11 @@ extern unsigned long _PAGE_CACHE;
 extern unsigned long pg_iobits;
 extern unsigned long _PAGE_ALL_SZ_BITS;
 
+extern unsigned long kern_base;
+#define ZERO_PAGE(vaddr)						   \
+	(virt_to_page(empty_zero_page + ((unsigned long)__va(kern_base)) - \
+		      ((unsigned long)KERNBASE)))
+
 /* PFNs are real physical page numbers.  However, mem_map only begins to record
  * per-page information starting at pfn_base.  This is to handle systems where
  * the first physical page in the machine is at some huge physical address,
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 2bd99944176d..d2d724ba4f83 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -170,6 +170,8 @@ static void __init read_obp_memory(const char *property,
 
 /* Kernel physical address base and size in bytes.  */
 unsigned long kern_base __read_mostly;
+EXPORT_SYMBOL(kern_base);
+
 unsigned long kern_size __read_mostly;
 
 /* Initial ramdisk setup */
 
> Cheers,
> Andreas

-- 
Sincerely yours,
Mike.

