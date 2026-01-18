Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD9EC9832F
	for <linux-um@archiver.kernel.org>; Sun, 18 Jan 2026 08:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X+fhLmMt6EbvGWzllqZJVhmHGvaT37bdUz8irugZaMU=; b=eP9yh7BHmiCv5MJxKsAKX71YWn
	9mUPv2FPM+ElxjlPqKUi6wnzMQG+jp0xeE3/h89G+8aQ6sbH8wgh2oN9YgNAXOPpheM3dA/xtPy2B
	Xrm99NqOUv6LxpdgNIHeDRun3D4TFXC9lMWTXLydUYwT79SkoQnXg9sKZUlB/Ojw8u6cWfiVmfs0m
	C/rr7KVcBNcVuYabN/XmcpvdoPeYyq6qO19JKjXTztOD3e6tRcqEDtEaYi+KnyRhQsBfxjz1rWCWv
	mbbPwiqvSnkGdBCjvKVqfawglnnL8t6OkXN8jewTgiqkwkz+Som6CXnmKdH59Sgzi11/PFKQzn2vl
	EZxczS2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhNvN-0000000H5a2-1QFH;
	Sun, 18 Jan 2026 08:14:17 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhNvJ-0000000H5Ya-2Oma
	for linux-um@lists.infradead.org;
	Sun, 18 Jan 2026 08:14:15 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-29f0f875bc5so22991955ad.3
        for <linux-um@lists.infradead.org>; Sun, 18 Jan 2026 00:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768724052; x=1769328852; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X+fhLmMt6EbvGWzllqZJVhmHGvaT37bdUz8irugZaMU=;
        b=mU+yxHr+cs7p+mnYYyAR67ePoxH2KjFbekYPdDW5HzqTPCNJCaJAIJKuTIOgyw/14F
         Sl6egsypqhKFAYPPifLxVfELFX4JmSPpPOu4ui+KfOd7QzD99yUKX6XxX4f7+NkGHdWa
         YGN44ui1Vw7p7zTD2++X3ti0kwoFN5cfaOBfJjwSfXSuVrHDpifLKt/by64lllzzFrd4
         yrn+QsQMdX8MdOYRIJX1cPcXWPJ+bRzxe5+8mnFpLQXCMNQEmIgkIQI6UN9sj/NcM7Uj
         2HiS+ccGEZHY18C/f3ruZBwpkTqpJlWYGFg38vre+M688uPl0fGTlyrTe795NJ20ePWO
         2Owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768724052; x=1769328852;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+fhLmMt6EbvGWzllqZJVhmHGvaT37bdUz8irugZaMU=;
        b=A3F9SL8WZ/g3cAM8bUmDb245RVmTXFjHFtIM7Nz1z/aPMwoRJD+8GGtrkV2PoDQsEK
         GcMGcL1tRXwSh/TFBl4kiPbLQlDRBjaZ/9gupGH7pezB5CEHQUVeZWxoBVQ1N3/HblrA
         bGZQFjlFJrEvdPmMZn2netQ0Puv09Tt/mYaDvrWdMAq8qr0XYSkO5g4OMlSCmM5C2Qyn
         H56l/NJr0WdkXkoaHTUdu+0fB5suSYHI4U7x0fq96uJKnTebKzsn8OF6Iu2wdXu0br0I
         3/QoQSgdox6cxm+c4tTejF9D5ZGeNk1NC8AAR3EFhj9JzJDNOVhlrj2c/fw8FVVxMq7F
         bvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVey4+5nHz6X+aXKBSEYix7/pcXe2Eik7NWeEvrcjybZ+y1dEB95PidQEzL9HnfQE7EWgVRfH98kA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxXUzeLHYMHhLjxGgvJcb0y8eGDaT/f4BFTTtC9Ky2UaMZBJ4lz
	3HVnHQowaSdmNjXt9A7fulJma+lYBb+Ef09AzkBdxbS2nQtuCmL/9YbE
X-Gm-Gg: AY/fxX7qzaVXiK56fy0rMGstZhW/lDRuo3g6HOtbo8kGzTeh39fn6rDGYYABzLLMF0f
	yz4aq0QBfDfi6JXVFE/l+7NZ/DJpOqqsUXkkCrgCsta8K1u+bG8Z3UjCf8qGmDaAh2NmHr8URrV
	nxcQnVenAC+dv3bZK9q0xFJ7A3AVmkunb3OH4uUVG06yyLDvmPU3G2JUTXRccRlOMnU491eXxmw
	gqk2okkNNmdr1I2FX9sAbvBumZDwB+xNekQ2dRpgpoUxVqHkCa74D8YQiiHkxjhEzS6mTjaRZIw
	RhTIu5OVyXgLYwlUISrjtZCgdQLW/nBfsaTTKwdzE0leNDMR6vr1ErdRL0kKHkgSAFm/+guh+gH
	r5wuooVS+vNpcQ4lFWw84/1Q61p4APgmE7NenUiFliiNSSmC9k2bRdnxhW763Ru46+lQxXGqrHA
	CW2E0A8Hrf
X-Received: by 2002:a17:903:40c5:b0:2a7:3dae:de9b with SMTP id d9443c01a7336-2a73daedf5fmr2287485ad.44.1768724051933;
        Sun, 18 Jan 2026 00:14:11 -0800 (PST)
Received: from [192.168.2.226] ([114.92.45.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190abcf0sm63240195ad.12.2026.01.18.00.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 00:14:11 -0800 (PST)
Message-ID: <85a0be43-3598-435d-a50e-9403b7e963f7@gmail.com>
Date: Sun, 18 Jan 2026 16:13:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/pgtable: convert pgtable_t to ptdesc pointer
From: Alex Shi <seakeel@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>, alexs@kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
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
References: <20260107064642.15771-1-alexs@kernel.org>
 <aV4h5vQUNXn5cpMY@kernel.org>
 <080e493a-e4f1-4c97-a3e1-f76f126b5213@gmail.com>
 <aV5yIuGi9Ni5YP5E@casper.infradead.org>
 <1d110134-89ab-474b-bca6-cfbfd4b5057f@gmail.com>
Content-Language: en-US
In-Reply-To: <1d110134-89ab-474b-bca6-cfbfd4b5057f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260118_001413_727942_4EAD8BFE 
X-CRM114-Status: GOOD (  20.36  )
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



On 2026/1/8 10:23, Alex Shi wrote:
> 
> 
> On 2026/1/7 22:48, Matthew Wilcox wrote:
>> On Wed, Jan 07, 2026 at 05:28:36PM +0800, Alex Shi wrote:
>>> Right, I will fix this. and sent the 2nd version.
>> No, the patch is stupid and wrong.  Don't send a v2.  You seem to have a
>> hairtrigger resend, so I'm trying to prevent a v2 being sent instead of
>> sending a patient reply.
> 
> Hi Matthew,
> 
> I hear you—no v2 will be sent.
> but sorry for a bit confusing, what's your expected fix? is the too 
> quick resenting? or the direction to alignment pgtable_t with ptdesc is 
> wrong?

Hi Willy, Do you mind to share the detailed concern for this patch?

Thanks

> 
> If it's the first. the new change for review address Mike's concern.
> diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/ 
> pgalloc.h
> index a17f01235c29..a204c3ac800a 100644
> --- a/arch/arm/include/asm/pgalloc.h
> +++ b/arch/arm/include/asm/pgalloc.h
> @@ -94,13 +94,13 @@ pte_alloc_one_kernel(struct mm_struct *mm)
>   static inline pgtable_t
>   pte_alloc_one(struct mm_struct *mm)
>   {
> -       struct page *pte;
> +       struct ptdesc *pte;
> 
>          pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
>          if (!pte)
>                  return NULL;
> -       if (!PageHighMem(pte))
> -               clean_pte_table(page_address(pte));
> +       if (!PageHighMem(ptdesc_page(pte)))
> +               clean_pte_table(ptdesc_address(pte));
>          return pte;
>   }
> 
> @@ -141,7 +141,7 @@ pmd_populate(struct mm_struct *mm, pmd_t *pmdp, 
> pgtable_t ptep)
>          else
>                  prot = _PAGE_USER_TABLE;
> 
> -       __pmd_populate(pmdp, page_to_phys(ptep), prot);
> +       __pmd_populate(pmdp, page_to_phys(ptdesc_page(ptep)), prot);
>   }
> 
>   #endif /* CONFIG_MMU */


