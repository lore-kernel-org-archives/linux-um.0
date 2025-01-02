Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A87E77188
	for <linux-um@archiver.kernel.org>; Thu,  2 Jan 2025 17:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DVKtDnv73lkMyTG56buW5+Lz0T+F0ADXYZ01KdwQv9k=; b=mbPRg0fBb+NetmYJfdL6jG3mAK
	vbF+hz37KyUdOgieYHNatKHuB+04cCXD9KLYarlwQ701isH3q046QrKsdG4+oBuS7t250adEIBDac
	whFWhzbRc0pXzUkBZwNXvIvnQPPpjKbUsDxpxXI/7sawMywL/Iw+iM0bowxPQZLHqlG3S8FUhiW7/
	38CSOSrWs+3uMYHnK0YJdAQYCcxK6LGCra5jQi8towOXEi0eXxMCl5CxKajteKuPSAUz068zKLPNZ
	sykZww2z33DokYODjv/arWwtIGXzyxj8rQW91hlbnEdWcr+7Jv0uvT3qerLaOHiVNdAkjnvPpIKdD
	TepquOzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTOZh-0000000Av7B-1F5I;
	Thu, 02 Jan 2025 17:01:33 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTOYT-0000000Auy1-0cJC;
	Thu, 02 Jan 2025 17:00:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4B9911FB;
	Thu,  2 Jan 2025 09:00:44 -0800 (PST)
Received: from [10.57.91.208] (unknown [10.57.91.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91B853F673;
	Thu,  2 Jan 2025 09:00:07 -0800 (PST)
Message-ID: <04b0a778-7a6b-4df3-b40e-ca76adddb243@arm.com>
Date: Thu, 2 Jan 2025 18:00:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/15] move pagetable_*_dtor() to __tlb_remove_table()
To: Qi Zheng <zhengqi.arch@bytedance.com>, peterz@infradead.org,
 agordeev@linux.ibm.com, palmer@dabbelt.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, rientjes@google.com,
 vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_090017_252408_88C78D13 
X-CRM114-Status: UNSURE (   6.39  )
X-CRM114-Notice: Please train this message.
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

On 30/12/2024 10:07, Qi Zheng wrote:
> Qi Zheng (13):
>   Revert "mm: pgtable: make ptlock be freed by RCU"
>   mm: pgtable: add statistics for P4D level page table
>   arm64: pgtable: use mmu gather to free p4d level page table
>   s390: pgtable: add statistics for PUD and P4D level page table
>   mm: pgtable: introduce pagetable_dtor()
>   arm: pgtable: move pagetable_dtor() to __tlb_remove_table()
>   arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
>   riscv: pgtable: move pagetable_dtor() to __tlb_remove_table()
>   x86: pgtable: move pagetable_dtor() to __tlb_remove_table()
>   s390: pgtable: also move pagetable_dtor() of PxD to
>     __tlb_remove_table()
>   mm: pgtable: introduce generic __tlb_remove_table()
>   mm: pgtable: move __tlb_remove_table_one() in x86 to generic file
>   mm: pgtable: introduce generic pagetable_dtor_free()

Aside from the nit on patch 4 and the request for clarification on patch
10, this is looking good to me, so for the whole series (aside from my
own patches of course):

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

And happy new year!

Cheers,
- Kevin

