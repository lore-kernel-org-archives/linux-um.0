Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDC8CF6C16
	for <linux-um@archiver.kernel.org>; Wed,  7 Jan 2026 09:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FvnEwkDYSB/jihgGeK4Vpiag8LQBrUYYgwlxuwDfTA8=; b=m4H5d2anwdU05ICn2Gx5AqQpJ7
	D9z3bX0SOtDdoV+YrS6ldYyByXkOiJaVCRggciNKdnoLyVkrYGPuzt/tPlkPOY7OHf/Qq0Xqe7CnF
	ZDxrZKZak9tI/HaLSp3Y2p6Gs3blygdrx3hwmj/UbFnYDiibAXLAjHjGstWLJFuAyoPq/jHBuGr6w
	cA/CZhdw4dRY9aa2hoDCOh5E3UEYRaZV6DJLa7ZReuLJ0LKZ1S6cW5mF4TKNs4PGAWIDkMTcXbfBb
	Ragw6RVIkFuosWzvQsm+mIi8AjNSRCub7EZIBspXD1wDmgLlfjQN8XJTNfiXVaZTlAyGgaOaDivxn
	dCqKuT8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdPUX-0000000ETxW-2AYt;
	Wed, 07 Jan 2026 09:06:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdPUV-0000000ETwF-1I0O;
	Wed, 07 Jan 2026 09:06:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E95CD60141;
	Wed,  7 Jan 2026 09:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E975C4CEF7;
	Wed,  7 Jan 2026 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767776765;
	bh=pMgU+C5FcOLCmP6ptKqgGVGjjrLsI8HbEkAssUEFqo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gp3clrexlQYTflBjEroGcywSAtzuN1Rwv0/QCEq3+PrJVFxFCVnDuCiuhES9FxML1
	 +DUJuEGclss/ATJRkynVca+Jnh3h6LZ1jKDlpzlWcRAo6+izc5O03Sz6x9cKrXFMgx
	 Y9bLrHVqoYADWUH0XXdTVI1WfeT51LlKWgWoIjuvqFNTY1UuAQKsvL4rxcgKYa53RT
	 HwvCsYN0oC3j7a2aYW9dIrhGAdIXV+DZgKRIozZxrf5fhJ5MEoUdXKbMDnSFYYNvLk
	 A7qYfjWXWSXUlNaU2pK6XIEQpbQqJGgs3DYcZ5NSns73Gyit+KIQRcRWBuYWEkPzAs
	 SZx9UZSS/0clA==
Date: Wed, 7 Jan 2026 11:05:42 +0200
From: Mike Rapoport <rppt@kernel.org>
To: alexs@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
	"moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
	"open list:MMU GATHER AND TLB INVALIDATION" <linux-arch@vger.kernel.org>,
	"open list:MMU GATHER AND TLB INVALIDATION" <linux-mm@kvack.org>,
	"open list:C-SKY ARCHITECTURE" <linux-csky@vger.kernel.org>,
	"open list:QUALCOMM HEXAGON ARCHITECTURE" <linux-hexagon@vger.kernel.org>,
	"open list:LOONGARCH" <loongarch@lists.linux.dev>,
	"open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
	"open list:MIPS" <linux-mips@vger.kernel.org>,
	"open list:OPENRISC ARCHITECTURE" <linux-openrisc@vger.kernel.org>,
	"open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:SUPERH" <linux-sh@vger.kernel.org>,
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>
Subject: Re: [PATCH] mm/pgtable: convert pgtable_t to ptdesc pointer
Message-ID: <aV4h5vQUNXn5cpMY@kernel.org>
References: <20260107064642.15771-1-alexs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107064642.15771-1-alexs@kernel.org>
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

On Wed, Jan 07, 2026 at 02:46:35PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> After struct ptdesc introduced, pgtable_t should used it instead of old
> struct page pointer. The only thing in the way for this change is just
> pgtable->lru in pgtable_trans_huge_deposit/withdraw.
> 
> Let's convert them into ptdesc and use struct ptdesc* as pgtable_t.
> Thanks testing support from kernel test robot <lkp@intel.com>
> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> ---

...

> diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
> index a17f01235c29..1a3484c2df4c 100644
> --- a/arch/arm/include/asm/pgalloc.h
> +++ b/arch/arm/include/asm/pgalloc.h
> @@ -96,12 +96,12 @@ pte_alloc_one(struct mm_struct *mm)
>  {
>  	struct page *pte;
>  
> -	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
> +	pte = ptdesc_page(__pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM));

When ptdesc will be separated from struct page, ptdesc_page() would fail if the
allocation failed. This line should be split into something like

	struct ptdesc *ptdesc = __pte_alloc_one(...);
	if (!ptesc)
		return NULL;
	pte = ptdesc_page(ptdesc);


>  	if (!pte)
>  		return NULL;
>  	if (!PageHighMem(pte))
>  		clean_pte_table(page_address(pte));
> -	return pte;
> +	return page_ptdesc(pte);
>  }
>  
>  static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t pte,

-- 
Sincerely yours,
Mike.

