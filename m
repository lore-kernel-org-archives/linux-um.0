Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39755C021BC
	for <linux-um@archiver.kernel.org>; Wed, 26 Feb 2025 08:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8W1YS7kw1UYuPTog9vP2KQU1oV+SEgE+lxrN/xiMMxk=; b=Y/bLUCXg/nM5k7yzptL76MqrYW
	zcOZIeJj6Mdy6VmSnULEd+Ts0v2ZeWgydGEUUDDQIlsZxifjIYivIsNkJcfaGxQ465o26b9FX5i8i
	UD/jJD2Pzj/JbASjuOcx68Z0gpmRAZgx9c0JoAxActTXpvgcvMjUxr/TqURN1Vfxz3aBglOsp/mqm
	Cbc+bEQCByadWsrmuu1Q6RVAeVur627lz5Zx8Y4gWXBsr1ZBNSHDZFkeR5xAHAIUAD7o+yEQKNvjy
	e+UL4H9WvBHHHFHfQj+PgOrYwsrDCFMNYZNL7YYRah5Ee2g2YkZgCXHDYT78SZU5AooHtoEpkZATg
	x2/oy0DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnCre-00000002u7l-36yH;
	Wed, 26 Feb 2025 08:33:58 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnCoi-00000002tGB-37dQ;
	Wed, 26 Feb 2025 08:30:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4719D1516;
	Wed, 26 Feb 2025 00:31:10 -0800 (PST)
Received: from [10.57.78.248] (unknown [10.57.78.248])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE2A83F673;
	Wed, 26 Feb 2025 00:30:47 -0800 (PST)
Message-ID: <14fefa3a-9522-4995-8e51-662e80ae1747@arm.com>
Date: Wed, 26 Feb 2025 09:30:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] mm: pgtable: make generic tlb_remove_table() use
 struct ptdesc
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
 <5be8c3ab7bd68510bf0db4cf84010f4dfe372917.1740454179.git.zhengqi.arch@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <5be8c3ab7bd68510bf0db4cf84010f4dfe372917.1740454179.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_003056_825824_A5D83107 
X-CRM114-Status: UNSURE (   7.80  )
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
> Now only arm will call tlb_remove_ptdesc()/tlb_remove_table() when
> CONFIG_MMU_GATHER_TABLE_FREE is disabled. In this case, the type of the
> table parameter is actually struct ptdesc * instead of struct page *.
>
> Since struct ptdesc still overlaps with struct page and has not been
> separated from it, forcing the table parameter to struct page * will not
> cause any problems at this time. But this is definitely incorrect and
> needs to be fixed. So just like the generic __tlb_remove_table(), let
> generic tlb_remove_table() use struct ptdesc by default when
> CONFIG_MMU_GATHER_TABLE_FREE is disabled.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

