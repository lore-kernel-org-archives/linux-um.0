Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A3AE7718B
	for <linux-um@archiver.kernel.org>; Fri, 20 Dec 2024 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Od24o/cE3dtNorFseNwnS40GUx5zkUNJ9JRmngZ+A8=; b=j+HDaMbN797bumR2GITchzZc50
	HUvPHG45QtzaPbuxgs+waxHw88Bc7vd1s7XQU3cqNkZzUI53u0QKRwjO6knF5V+yaq9X1cPYMqLN+
	dLUNByAYsrqZTeSDw1Z9AYXXwXMX+Ou3gYYdQwK+/QP+avnDra0vKeaVPra2guQCZx/9CqXBO4a92
	rKtePEATUemI4rEQ+e4R9fRS0oGTTNHAqzlMgul87Ve50aQBcrf6UQ8HVcaLFTpAddU7K1Gkt/LzW
	ErYA9Dkhxt9wHPL0sBpuoUcZ/1Nmsl1+dA3WS9vjxICCGvdX3O9DJjAgPKdcGWM9N9SjXHSyPP144
	GwaLoa6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOaxN-00000004iHz-01v8;
	Fri, 20 Dec 2024 11:14:09 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOaZq-00000004djy-4404;
	Fri, 20 Dec 2024 10:49:52 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D0A81480;
	Fri, 20 Dec 2024 02:50:18 -0800 (PST)
Received: from [10.57.72.191] (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8254C3F58B;
	Fri, 20 Dec 2024 02:49:44 -0800 (PST)
Message-ID: <75cb4ff8-eb0c-4519-a30a-f8be717ba278@arm.com>
Date: Fri, 20 Dec 2024 11:49:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm: Move common parts of pagetable_*_[cd]tor to
 helpers
To: Peter Zijlstra <peterz@infradead.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Ryan Roberts
 <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 loongarch@lists.linux.dev, x86@kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
 <20241219164425.2277022-2-kevin.brodsky@arm.com>
 <20241219171920.GB26279@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20241219171920.GB26279@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_024951_055240_4F7713C6 
X-CRM114-Status: GOOD (  13.38  )
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

Hi Peter, Qi,

On 19/12/2024 18:19, Peter Zijlstra wrote:
> On Thu, Dec 19, 2024 at 04:44:16PM +0000, Kevin Brodsky wrote:
>> Besides the ptlock management at PTE/PMD level, all the
>> pagetable_*_[cd]tor have the same implementation. Introduce common
>> helpers for all levels to reduce the duplication.
> Uff, I forgot to Cc you on the discussion here, sorry!:
>
>   https://lkml.kernel.org/r/cover.1734526570.git.zhengqi.arch@bytedance.com
>
> we now have two series doing more or less overlapping things :/
>
> You can in fact trivially merge the all the implementations -- the
> apparent non-common bit (ptlock_free) is a no-op for all those other
> levels because they'll be having ptdesc->lock == NULL.

Ah that is good to know, thanks for letting me know about that and Qi's
series! Fortunately there isn't that much overlap between our series - I
think we can easily sort this out.

Qi, shall we collaborate to make our series complementary? I believe my
series covers patch 2 and 4 of your series, but it goes further by
covering all levels and all architectures, and patches introducing
ctor/dtor are already split as Alexander suggested on your series. So my
suggestion would be:

* Remove patch 1 in my series - I'd just introduce
pagetable_{p4d,pgd}_[cd]tor with the same implementation as
pagetable_pud_[cd]tor.
* Remove patch 2 and 4 from your series and rebase it on mine.

Let me know if that makes sense, if so I'll post a v2.

Cheers,
- Kevin

