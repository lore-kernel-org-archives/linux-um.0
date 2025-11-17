Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821DECEBF92
	for <linux-um@archiver.kernel.org>; Mon, 17 Nov 2025 16:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AjBcC8MJ5ncNRd+FxyETkJed/HhN2WH8VIoZ1KVckmI=; b=b/VYXxiiAg8zV98oGachwg4cEu
	c91S7ozSqPOT6aptsrrLdj53Zw/vKlN9B78hajqFETnoLSaEvgSyLP/KWNejtB1ZfE3DXWQWK/NH0
	s76aNubfnMcN3/ptGbKXSTNv1W7m7+KthDPL7rRyVHBolGAW9YhCo1bID9T3vxwN16xLTCllrTMy1
	9EGyUwFeEJN9PFD9g6nrjMnH4BQ/qcP3TJeQQZbH7+3DKc3Lc3WpvqTjUkBajXXDwmjqQxu92MDEh
	NyA9mrLUtFA0uzO06jNUnjz5UN195TqSmC0xq9WtQY6TMeIQv2P65mcnuT63s1bdPoZh/F2rUJGu4
	KnSlarag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL2UF-0000000GQsk-3azc;
	Mon, 17 Nov 2025 16:53:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL2UA-0000000GQqL-1Mfl;
	Mon, 17 Nov 2025 16:53:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 504284062C;
	Mon, 17 Nov 2025 16:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD96C4CEF1;
	Mon, 17 Nov 2025 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763398429;
	bh=xcaskcSeK6dNzaCv0moe8ATxJ9XohqfqvmJEObNmum4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=auYCSxxEolEdVdPP5hVqXRlt7AuV/UT6WrPa29QCtPBvB6LhWtxK/veNm59+tg6iq
	 rWqGh7NFp27ucHsHpE+PxOZC6j5PxVDjo5pOnD0QHkrYbGowV5ij7ERUBYhkkveU8s
	 Qzg6TBFQc+DUeNZ14jTGRDww4CnIYZTFis12VZGpJEwzucgudCK3WO/qGAhAPMC7y/
	 uuneSx1mR/5L0/EYwLyIp6CPdn57YNuXiEoHNjZnllcUZGQFacQDKvwPIybR0ThFFp
	 q5NSzE8k0Nzvt6Mn+oVgHtGvj1wYQsVXpn4r7yvTJbgDFs0FNmoLC3DfEgh3t0L6cE
	 NX3xoTtWTQtMg==
Message-ID: <83e88171-54cb-4112-a344-f6a7d7f13784@kernel.org>
Date: Mon, 17 Nov 2025 17:53:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] enable PT_RECLAIM on all 64-bit architectures
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
 akpm@linux-foundation.org, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <cover.1763117269.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_085350_388300_011DED89 
X-CRM114-Status: UNSURE (   8.01  )
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

On 14.11.25 12:11, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Hi all,
> 
> This series aims to enable PT_RECLAIM on all 64-bit architectures.
> 
> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of empty PTE
> page table pages (such as 100GB+). To resolve this problem, we need to enable
> PT_RECLAIM, which depends on MMU_GATHER_RCU_TABLE_FREE.
> 

Makes sense!

> Therefore, this series first enables MMU_GATHER_RCU_TABLE_FREE on all 64-bit
> architectures, and finally makes PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE
> && 64BIT. This way, PT_RECLAIM can be enabled by default on all 64-bit
> architectures.

Could we then even go ahead and stop making PT_RECLAIM user-selectable?

-- 
Cheers

David

