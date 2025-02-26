Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74353C021B8
	for <linux-um@archiver.kernel.org>; Wed, 26 Feb 2025 08:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VzFLUv0z/EwZ8puFlNA21YpnnKh3HRPwIE+WN0pXlG4=; b=m71FpRhCxgupxeIItSklOsdeX+
	cYkGOJ9tAkd7IiOjOQycM+/qpJGp6hBHfV1CETNZ8o2ZuvoolZxHyeY6Gv33v5Ki0ohwhAH57nqhP
	JpM8vOKq6bQFnZf3wB/fB0aXRWM5pCFOXxZ1nXPzrTwiV3v9Wh+XbRad8csbgELcC5NWs5TVLTBhk
	3P/+TZqzlkvnx7vWkpwgf/Eu3WqI4aDb8+tw+ya146PP65uAX6gyWBjv6RedBtYg2tIQHeRPeB/GB
	GDuHuoF6iLjF3KEwLoiHNH/4OBBRefq+6uworPxNJeX49Vgl8eRzrPOuiEow1mIgjHiTZr/5G9UmT
	6IghZfyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnCrp-00000002uEj-0s7b;
	Wed, 26 Feb 2025 08:34:09 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnCpt-00000002teG-1TXv;
	Wed, 26 Feb 2025 08:32:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC3A71516;
	Wed, 26 Feb 2025 00:32:24 -0800 (PST)
Received: from [10.57.78.248] (unknown [10.57.78.248])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C0533F673;
	Wed, 26 Feb 2025 00:32:02 -0800 (PST)
Message-ID: <3f6c1872-cec8-4a7a-ac18-f5a426962a11@arm.com>
Date: Wed, 26 Feb 2025 09:31:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] mm: pgtable: convert some architectures to use
 tlb_remove_ptdesc()
To: Qi Zheng <zhengqi.arch@bytedance.com>, peterz@infradead.org,
 riel@surriel.com, vishal.moola@gmail.com, david@redhat.com,
 jannh@google.com, hughd@google.com, willy@infradead.org, yuzhao@google.com,
 muchun.song@linux.dev, akpm@linux-foundation.org, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, arnd@arndb.de,
 dave.hansen@linux.intel.com, rppt@kernel.org, alexghiti@rivosinc.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 linux-riscv@lists.infradead.org
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
 <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_003209_434268_AD5946B1 
X-CRM114-Status: UNSURE (   6.96  )
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

On 25/02/2025 04:45, Qi Zheng wrote:
> Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
> nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
> and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
> tlb_remove_page()). This is the same as the implementation of
> tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
> convert these architectures to use tlb_remove_ptdesc().
>
> The ultimate goal is to make the architecture only use tlb_remove_ptdesc()
> or tlb_remove_table() for page table pages.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

