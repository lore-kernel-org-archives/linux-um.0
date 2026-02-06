Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DACEE209F
	for <linux-um@archiver.kernel.org>; Fri,  6 Feb 2026 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6hsfkV5IAQfqxDKV1tC+TSjJcSOAFRAAcjIKt6tdM2Q=; b=n5WVU6fiWrfX+OfDUKgkBwkSA3
	1cxpJGFKeMHfJ6u+F8XT3Ql06ZRFyOodtexr0uS/GKYPMclteZVz6g032lT65hbcCtuphMDCBFYsb
	7RmHB67BFz8bNiYH0m2F2I3rwTU//SHuDV9+kYnKE7swEv1bvaWJhMhJb/aKc/cqY/dw3rdnkqyIc
	NbtThKVoYIZfYer8g+HNJ615sgca+U1VQuMJzBRY4zoc4JVAvoNX/DpIkMV/1woZkhTFgyaa09A4H
	P7OxZe8m+s4s8I8K93hptJDrcoK1WWWsuSXWA5rY6Sq9WxFxV5J6k0Ju/tbl5RrJERYY/6FKtmC50
	vkztWgwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voLR2-0000000BKhx-0Jf5;
	Fri, 06 Feb 2026 12:59:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voLR0-0000000BKhj-0MDC
	for linux-um@bombadil.infradead.org;
	Fri, 06 Feb 2026 12:59:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=6hsfkV5IAQfqxDKV1tC+TSjJcSOAFRAAcjIKt6tdM2Q=; b=dAr7Ko3SVjRP1WLbjsU1HqtlN0
	n88W7ZtYb9uDQy+A8AvXlB0jGbA4LsBvjWXN8uyxOVU2L06GybU0wNEf8JgNycBuimzjtG7ZZLr7a
	ByCv7+G6psS6W0YVg6vvzoTZ7dCLMUKKBfuDivnoSxx9tUNuJyHD1K4SVEmbbySsTCp/l93laNBk4
	HMVzBXNJ8rz0KROA9TXQJM0xRpqb1wKPiLRdDhtbNJaS6OVFuSWyiY2sLh8SPO7zsL3oOy4sMK8ki
	DgHs0l6bt7uzOCr8+0hmfIWU7OdDgZgz1aA+Q0/dPcPiD2Bk32qr+RAyVtngEfzF43wRTfYpifldj
	K9NyHfXA==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voLQm-00000003oNB-1UV9
	for linux-um@lists.infradead.org;
	Fri, 06 Feb 2026 12:59:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F36564360E;
	Fri,  6 Feb 2026 12:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A91FC116C6;
	Fri,  6 Feb 2026 12:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770382766;
	bh=nmOlDsmcEuee8gUixqxPotvngOzcy39WDO9c3AhT2g0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dfXlSi3xfznad/FmG0SCZLMafBjxDR/Lda1fAMWYelEvVJo+i4rC0KL2kaxDxe/Nm
	 o4hd4e01aneUG0v+WeNJ+XCvIbBONAK1FfYC9cN8ZZkHJy1wnzS/Nk7m3dVuTuOoYx
	 Gx3yMfF/A/3paZtby+moTo3+91ZGDXlbB6xC2/erHz7Su08ptQhecAnGy/N9dpg3n5
	 dW6JBTXZPsoYUL2bJsuPl4y6MvtbTdxYd/UwKZfIa6rLBcu2GE3AA64I+2G92Ttkss
	 xdUWLWWuOMSTsg6JrtyvYMVdXc8ZLMpbPzc+ltf7loOSrrbKeSVtTQxpCNP/BkSLYo
	 pIVR/oT1x0/vQ==
Message-ID: <c24c32bd-085d-460a-833a-a982eb5becaa@kernel.org>
Date: Fri, 6 Feb 2026 13:59:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] mm: convert __HAVE_ARCH_TLB_REMOVE_TABLE to
 CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config
To: Qi Zheng <qi.zheng@linux.dev>, andreas@gaisler.com,
 richard.weiyang@gmail.com, will@kernel.org, peterz@infradead.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dev.jain@arm.com,
 ioworker0@gmail.com, linmag7@gmail.com, akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, sparclinux@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1769515122.git.zhengqi.arch@bytedance.com>
 <5ebfa3d4b56e63c6906bda5eccaa9f7194d3a86b.1769515122.git.zhengqi.arch@bytedance.com>
 <a404e9ec-35ff-44b1-b321-9cc4fbf72060@kernel.org>
 <1663ae90-3247-4e12-a25a-049fc3281e19@linux.dev>
 <538fef61-3903-407e-8486-538a28b99e9d@kernel.org>
 <53a1bbdd-26d1-454d-af06-169172278718@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <53a1bbdd-26d1-454d-af06-169172278718@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260206_125936_310882_C7CD267B 
X-CRM114-Status: UNSURE (   8.70  )
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

On 2/6/26 12:58, Qi Zheng wrote:
> 
> 
> On 2/6/26 7:45 PM, David Hildenbrand (Arm) wrote:
>> On 2/6/26 12:13, Qi Zheng wrote:
>>>
>>>
>>>
>>> Ah, It's just simply aligned with the MMU_GATHER_RCU_TABLE_FREE above.
>>
>> But does that work as expected for !SMP?
> 
> In the case of !SMP, tlb_remove_table() will not be called:
> 
> static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, 
> bool is_page)
> {
>      pgtable_free(table, is_page);
> }

Ah, okay. Confusing stuff. Would have been nice to document/mention that 
in the patch description.

So if it compiles, all good

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David

