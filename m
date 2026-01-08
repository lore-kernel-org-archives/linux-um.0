Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38F5D14892
	for <linux-um@archiver.kernel.org>; Thu,  8 Jan 2026 02:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6WPMqEgbiq/1nCGoqJgHIPGVbxZP1MvEMarO5Hdi07w=; b=KFlv/KB5zoksqU+n+IAvJoA0O8
	M4NFg0Y+yvvnhf3qGY2yEyJADLDrEP0IYgEs7F/Kt1mhYenyfFQc4xGPVOPO/+0BSJOGJwiV68eXp
	MGrRd9SpfNAf0YYG1vsn5g0ZayhPfXI/YcPJEN39kA/sYN+r+SKHyBZGR6kgevYsZQYYw+SB1agbn
	ejYsQYbEG8uTV5fKRdtPC03VgcCI40K5JtmMl+sdDDJIZytb9+6ZdH7eIU24xgK/fMLjIYKcz0mZ5
	kGm4qnZx3rArdsWDnJzqQvrGTPybvMWzG/K1RZkQCziXdjEirbbWwMJDouUqCkjdo5vIhN6kOVbG2
	sCfZUMQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdfgq-0000000FpvP-2A8R;
	Thu, 08 Jan 2026 02:23:56 +0000
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdfgk-0000000Fptn-0jMi
	for linux-um@lists.infradead.org;
	Thu, 08 Jan 2026 02:23:53 +0000
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-78c66bdf675so27815577b3.2
        for <linux-um@lists.infradead.org>; Wed, 07 Jan 2026 18:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839029; x=1768443829; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6WPMqEgbiq/1nCGoqJgHIPGVbxZP1MvEMarO5Hdi07w=;
        b=ZcqmtyBLPyrKPNZaaRrhvxCONjGAiP2J4uKyNynlgW5cnWSThRTnnJPuNuADGQtRWu
         bw/eKjATnqzQ2hphlKyJKNK/EfseUzMVrXJtJ1u22o33pQIyWhFdSS63TIHmPngVYhC2
         80iE0Ja9hsxNwSgRzkrnGZBXBvnf2qvb5P3Nq+URxNwgz/f08r72f/egn4GjXcuUaZ9H
         ME5fytAZwIxd03ckvSDjxxEQZXL5S414YXWwgOaixEvYBE54g4KIiukkTgU5O/yeags7
         dRTOv59EJ5fGXWTFaY97Kl7GpSYVa7nuMio6gX6KsBTQpKt83YrqXbLJpVkUA6thkmTl
         HtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839029; x=1768443829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WPMqEgbiq/1nCGoqJgHIPGVbxZP1MvEMarO5Hdi07w=;
        b=DI4AUse133Z9yKlP/YAZfdIeEihDprekdVyNNaC+apeE8p4goVJqnt1m/WY9x7yveY
         x6ta4waROOtGuJ+8TqKHmDY/CUIuFITIkL17eSrrERdTMTrhujxqZgs7g0XlFiPvmQRu
         +l49f0uxCNYOLrvHuUW9uhdu3H3KCnZUTPyIRT3NLh/dXkB7zrR6omQQG8dff7XsOKCV
         koS9F9fU2HL9GpIVyQVeXZa/IO5HpRwc64VCjoZ4CLOldMQr9D33zoeGBxkreOOvwENL
         RdC/Cni2ofkER5rdOFAh61C7hVLAa0Uxnt05aybkxMryHG/ntrn4BxnQ37Hg+lzPkb1Y
         sunQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ5v2QYXXqRCqy5Ydci9gmByYHWU30W7Pxo7VLcuJOMb2FPSt9hpJAhMy5A5oQ/aXDEKeME4mU8A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxvIOwDZB2REGZeUSVuaInFUH3rO8IW8OrpAUs7ml/OPXWF1w2s
	syFIqQw5sOt+rbYOKT04L6KwHCXZwAQibZwBUEZVqnFH828oVu4BEEkA
X-Gm-Gg: AY/fxX67OGt/fV9zxcyIhm8QblhxzsxQs7DCo2GiogJzunmzgsAbf/q62gnKcH7CJKB
	WfuZ0L06amV0VdNqh/kEy769gAbgbT0EhSVyfFq1YD+4SKH1pqDh0f/71YWOUXVgFox+H2ATatj
	A6lhDK/T1VyNDnUIR8qJV5svuczzRLGmWSLqYQHvH/FLrVTmf4jRcihklwQhF0ROjpE9v+lNSFd
	LXteQBy9MvozEYZ9Bl+lVWJW8FfRKqcifEnKqd6zE3wUjd4Oftdpe3fRfaTD7L4qAV2qQ0NW7rW
	VKvcngvqm8akSNlDsVZ2IxcWojb95FhoPF6wfzY5zXgpt4LBCtvmSUvr0k7I/Pn3UkKkscnGiHs
	eaHQnl8SsKVH8lPQUZoif7iZVxraz2SpFiN3QP7lmQK8TvIiBqtIOuVSRaeNIyu6sXKQPreHrTH
	AMmfjTk1G6JmJjCnRDWzmQpb9mdSmxyskw4KZMQA==
X-Google-Smtp-Source: AGHT+IGgMpL+kZMdvF4ADTgetvjR8KjnRPwe3Xe2CKlVvJLk69qHA2NQZ4MxPPVQYhnVGWyKjWzQjw==
X-Received: by 2002:a05:690e:1c06:b0:644:6b68:f126 with SMTP id 956f58d0204a3-64716cacb29mr3927712d50.77.1767839028925;
        Wed, 07 Jan 2026 18:23:48 -0800 (PST)
Received: from [192.168.2.226] (104.194.78.75.16clouds.com. [104.194.78.75])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790ae603282sm21321087b3.13.2026.01.07.18.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 18:23:48 -0800 (PST)
Message-ID: <1d110134-89ab-474b-bca6-cfbfd4b5057f@gmail.com>
Date: Thu, 8 Jan 2026 10:23:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/pgtable: convert pgtable_t to ptdesc pointer
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
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <aV5yIuGi9Ni5YP5E@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_182351_135099_AB049378 
X-CRM114-Status: GOOD (  15.43  )
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



On 2026/1/7 22:48, Matthew Wilcox wrote:
> On Wed, Jan 07, 2026 at 05:28:36PM +0800, Alex Shi wrote:
>> Right, I will fix this. and sent the 2nd version.
> No, the patch is stupid and wrong.  Don't send a v2.  You seem to have a
> hairtrigger resend, so I'm trying to prevent a v2 being sent instead of
> sending a patient reply.

Hi Matthew,

I hear you—no v2 will be sent.
but sorry for a bit confusing, what's your expected fix? is the too 
quick resenting? or the direction to alignment pgtable_t with ptdesc is 
wrong?

If it's the first. the new change for review address Mike's concern.
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index a17f01235c29..a204c3ac800a 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -94,13 +94,13 @@ pte_alloc_one_kernel(struct mm_struct *mm)
  static inline pgtable_t
  pte_alloc_one(struct mm_struct *mm)
  {
-       struct page *pte;
+       struct ptdesc *pte;

         pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
         if (!pte)
                 return NULL;
-       if (!PageHighMem(pte))
-               clean_pte_table(page_address(pte));
+       if (!PageHighMem(ptdesc_page(pte)))
+               clean_pte_table(ptdesc_address(pte));
         return pte;
  }

@@ -141,7 +141,7 @@ pmd_populate(struct mm_struct *mm, pmd_t *pmdp, 
pgtable_t ptep)
         else
                 prot = _PAGE_USER_TABLE;

-       __pmd_populate(pmdp, page_to_phys(ptep), prot);
+       __pmd_populate(pmdp, page_to_phys(ptdesc_page(ptep)), prot);
  }

  #endif /* CONFIG_MMU */

