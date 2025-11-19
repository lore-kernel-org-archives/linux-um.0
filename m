Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD43CF3185
	for <linux-um@archiver.kernel.org>; Wed, 19 Nov 2025 10:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=szA32RJyVbeRYTjJ7Ow9x4Y9um0eAlyuuRKChzXOWH8=; b=zE52Vkz+On21FgUoJifBDICng+
	ssuyG14Z58gOZ1nJaqiMUVU2VJg4Pkb4MhnenHAgvOFgyDjgpNxa4u1tQyQhXPn+5dtYgDXDuDSZv
	DnlmOV8JCWhw3zkkg+H/04b3m1z+xWquW3EXtoqVw60TOSkgXadtcUkzfRnBA51ESw0Jdia3W+YQu
	zzRplHXWAlvNl538Pw6fF7Igp1SKKx0RJgw21L+fg4BkWF/RnAr7s6kukqy3C8O6KDP7CEkrJcSNq
	bhMy3v8xf1fsecw0RdEaLSNYy1z2TnirwGsPlZFYC1rTg6L6Pw7fFGwna9U95KKAiHmWtwZASrAAF
	iJHdoGzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLfCC-00000002wl2-3Ghv;
	Wed, 19 Nov 2025 10:13:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLfCA-00000002wkX-0iuW;
	Wed, 19 Nov 2025 10:13:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8355C43FA7;
	Wed, 19 Nov 2025 10:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB52CC16AAE;
	Wed, 19 Nov 2025 10:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763547226;
	bh=8IYxu/C3qrGid3n3xMVLRSBITnzao99XRln0ciNWneY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LdGoDxJt9h1Tlf1FCndkLyh+OwHFWpLYja9EnuhCaStGYdTO/u/3+Fxjm8oCvXk2/
	 E35KNa8rkDsQ4bPiZhB7BvC+7G9u3vv2O95UQNcf+uUOrfyBdK3uT+eewjqJwxMg6f
	 O1rm2iLUscQJgkXdhNOc9AFc9kCFpZIhNjSzZINyqhCmWVFyFPOvsz8HJeqmQXW4+H
	 s7XMLF+PxrmhzX0byFy0OOO5Djr+zth+JdHGDpKJGZ+dUbNfoMyOEIkvtSt3VTig0u
	 DjN5MNM3mx4xWC+cutnpwm7m5sszHgWntNoXn6IOKKCqq/T/Yv6HJIdQv894sJyfel
	 bVNiG5QRYn7SA==
Message-ID: <afecde77-a4af-40f1-a905-9de8a1bdd783@kernel.org>
Date: Wed, 19 Nov 2025 11:13:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] enable PT_RECLAIM on all 64-bit architectures
To: Qi Zheng <arch0.zheng@gmail.com>, Qi Zheng <qi.zheng@linux.dev>,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org,
 ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <83e88171-54cb-4112-a344-f6a7d7f13784@kernel.org>
 <f7f0ca8d-bca2-4a3e-8c45-85cba1b0ff18@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <f7f0ca8d-bca2-4a3e-8c45-85cba1b0ff18@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_021350_236115_154830E8 
X-CRM114-Status: UNSURE (   8.66  )
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

On 18.11.25 12:53, Qi Zheng wrote:
> 
> 
> On 11/18/25 12:53 AM, David Hildenbrand (Red Hat) wrote:
>> On 14.11.25 12:11, Qi Zheng wrote:
>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>
>>> Hi all,
>>>
>>> This series aims to enable PT_RECLAIM on all 64-bit architectures.
>>>
>>> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
>>> empty PTE
>>> page table pages (such as 100GB+). To resolve this problem, we need to
>>> enable
>>> PT_RECLAIM, which depends on MMU_GATHER_RCU_TABLE_FREE.
>>>
>>
>> Makes sense!
>>
>>> Therefore, this series first enables MMU_GATHER_RCU_TABLE_FREE on all
>>> 64-bit
>>> architectures, and finally makes PT_RECLAIM depend on
>>> MMU_GATHER_RCU_TABLE_FREE
>>> && 64BIT. This way, PT_RECLAIM can be enabled by default on all 64-bit
>>> architectures.
>>
>> Could we then even go ahead and stop making PT_RECLAIM user-selectable?
> 
> OK, will change to:

Was more of a question: is there any scenario where we ran so far into 
issues with it?

-- 
Cheers

David

