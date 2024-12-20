Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAFDE77188
	for <linux-um@archiver.kernel.org>; Fri, 20 Dec 2024 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KO9VGuWdvuRdvvp8WfCovPvsMnVANf+aoBczuD6TfMY=; b=nGuycFMaPpqB9TENtB7ZEx/ThM
	KexXmtSmIUVAJVYRP3mTC9CDKq7BINpOY3U/dZQAd0v+hXCk06oU26MyVI6P2d0SzBycYpFDvXuaW
	jaXzBayctHIeeahH+FZgTDg3Yf13eTy5dETGW5ajBf0dIUof7I+KNXc24tLdcx2KlCHIpR1+NEjDI
	rjB9ixT2ZBEhd9BIWqDiaOXUigeslSFbDYb37T7uZcdKaUJyHU5eAQDLtXw7pF+bPhtBtWog8/Yia
	hYPhbe7dr77F9DqKn7qdG1TMCQyhlahAxftjzdk8zIV1Xs/Ktkr/+VGkps1E0RcB5CgFs5ACwtn65
	wDG0MkCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOaxp-00000004imD-1Uri;
	Fri, 20 Dec 2024 11:14:37 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOai4-00000004ebu-0d7j;
	Fri, 20 Dec 2024 10:58:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DDC71480;
	Fri, 20 Dec 2024 02:58:47 -0800 (PST)
Received: from [10.57.72.191] (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0C613F58B;
	Fri, 20 Dec 2024 02:58:10 -0800 (PST)
Message-ID: <765aec36-55a4-4161-bb30-4ff838bc2d98@arm.com>
Date: Fri, 20 Dec 2024 11:58:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Account page tables at all levels
To: Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, loongarch@lists.linux.dev, x86@kernel.org
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
 <a7398426-56d1-40b4-a1c9-40ae8c8a4b4b@intel.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <a7398426-56d1-40b4-a1c9-40ae8c8a4b4b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_025820_242382_2E756891 
X-CRM114-Status: GOOD (  12.96  )
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

On 19/12/2024 18:13, Dave Hansen wrote:
> On 12/19/24 08:44, Kevin Brodsky wrote:
>>   +---------------+-------------------------+-----------------------+--------------+------------------------------------+
>>   | x86           | Y                       | Y                     | Y/N          | kmem_cache at pgd level if PAE     |
>>   +---------------+-------------------------+-----------------------+--------------+------------------------------------+
> This is a really rare series that adds functionality _and_ removes code
> overall. It looks really good to me. The x86 implementation seems to be
> captured just fine in the generic one:

Thank you for the review, very appreciated!

> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Just to double-check, are your ack'ing the x86 changes specifically? If
so I'll add your Acked-by on patch 6, 7 and 9.

> One super tiny nit is that the PAE pgd _can_ be allocated using
> __get_free_pages(). It was originally there for Xen, but I think it's
> being used for PTI only at this point and the comments are wrong-ish.
>
> I kinda think we should just get rid of the 32-bit kmem_cache entirely.

That would certainly simplify things on the x86 side! I'm not at all
familiar with that code though, would you be happy with providing a
patch? I could add it to this series if that's convenient.

- Kevin

