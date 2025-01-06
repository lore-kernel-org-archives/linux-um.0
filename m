Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2159E77188
	for <linux-um@archiver.kernel.org>; Mon,  6 Jan 2025 03:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/q466ctbH84kLf48L1cXJtHFTRzDl7be/n0cI3LGmOM=; b=LQkhiWQH1wdYfCFOgfqf96jdMd
	+ZlpszYp/sZHVlCLJtAzfzYm6C9L5u1LV5B/mnUcdI+whRffofSKeqA/QtI26e0K6S1mYN2TreMX+
	bUxmy0+41/EoLxYgXg2mLG1N7dAPlEzCm8LVmk1FbvRodyQpNbdxr/MsuvwcN3/GRv+Xonb0zwshY
	NUK5vKIcsPJ9cjmBcd3D9k6uL2Y4eC3qKQwHJBlj44Sjfre/zYcUsEdoSzFnNztUuxh3Lp9+yJAKe
	VdqKfEmucXo3Wkibx/lxjedO5zZj8eBNOz0mGTlQ74iJGfsygPZy5AN5UdEiYBrx+3AcxDhctoFbX
	Za7hNgfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUeCo-00000000AHd-0rw1;
	Mon, 06 Jan 2025 03:55:06 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUeBb-00000000A8g-1BLc
	for linux-um@lists.infradead.org;
	Mon, 06 Jan 2025 03:53:53 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2f441904a42so20367441a91.1
        for <linux-um@lists.infradead.org>; Sun, 05 Jan 2025 19:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736135630; x=1736740430; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/q466ctbH84kLf48L1cXJtHFTRzDl7be/n0cI3LGmOM=;
        b=isoXtO3CuYLqt2tyJbp+2B5dmXhmABhJ9wZmXt2QOme+TqUw/AraFkM8Kt+m+Iu866
         moWp8FhZ1aMm/ejkaK180kDGL5OW+KMOvYUbCejAbRc+ZXFfYxr18PHfX1m34qC2T+fM
         wY9It39AP4+BxYIMkX3jvLhF3dDahRttZqsGZj4jq9R/v3LRVeFykTqDSFvZ/VWF7COS
         5F0gOA3N3ua6eFjmwnzVh/wBD/efKXcczvrPhgimM4vLnfFnXOzB7ypZUuMgrMcdCnau
         F0y665LbLVlUMTNJvZeqBRu+0+6BWeCuBBqLKkQxxOGaTPNFUfV+QWC4l+jdjRiSmDZk
         amdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736135630; x=1736740430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/q466ctbH84kLf48L1cXJtHFTRzDl7be/n0cI3LGmOM=;
        b=bo/Eiga7+buJ9+WwjD49HMIO+hnIVw91UqmwzPeNVKRrBb2tDRNkYAuYtjxypfXmdh
         icqooOsB1W7Lo+NEnUbey/7TVFXd3DfDkxEqzfjIMVcgZ2S9rTdGtxKwqk+g5jO0IY35
         YTc33xc9I1//gg5U8Cu23v8husWQosTpEtmYtmZIyC3dzi/Fj0vF5Lbgh9XYa8gCo6vC
         979+yU2bTF53Ub8PeCnlywN8gGnGA08jCJK/6u1xXoCSvZ7hOg0a4h7r8uu5W3pXaEq5
         vMO6/TzjAUlObGQ+pdQx+LVmulcsKS7GwTNpxT55k3Azt3mU7YlMWRpuBK4qPl9zvCPv
         y94Q==
X-Forwarded-Encrypted: i=1; AJvYcCXE+6zgs35yyByUfnOsaLapw4asO1YvRgVNFRAghr+dYtBhxLpDR+3VencEdrEoNb8neYE9GxdWOA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxVkJfeV6+5WlPuYVsoNde7v15raH5v/4rCBvdMwDfPG8TpkCnP
	uKTdViHDqsN16kM0OlzEyOPpCqiCWyhRsscNPFe1ZFoL1LvYWRjkXDRCgeOSKKQ=
X-Gm-Gg: ASbGncuxsTgiDubApPTepkL/IQAliWdYyWWvpSJ2m8+lhz3lAjuJNc+zRWQ5mDdtEJ1
	2c93ADcfBrd55wUU76H/bbeEpbwOQuHG/73cY9sud4e2ftc+cGSjE4HaL1r4canyeuEJZxv7yuF
	lJm0h1e71A74sdhyejiHQr+xXbmxJZtGPMR3r/aTvLckVeIL1YFR/F41V7ax0Tl8D3arOW/5Mu7
	bVTC08WqpK8h0ulf8y28L8qxScK74yGhy9RglYvfbmBa54xk54aPnr1eBDQK95VJiKHTqjyxXS8
	TsWC8Q==
X-Google-Smtp-Source: AGHT+IE2eKUVGb+J7TSGZASTVnkByt6mt8YLIy++PUNY+VFfsnF7zlybMe8WL3Umwm8kwi4ry/BkkA==
X-Received: by 2002:a17:90b:54c3:b0:2ee:a127:ba8b with SMTP id 98e67ed59e1d1-2f452ee83d9mr71788615a91.36.1736135630440;
        Sun, 05 Jan 2025 19:53:50 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02f72sm283551435ad.249.2025.01.05.19.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2025 19:53:49 -0800 (PST)
Message-ID: <a84a7b0f-dad5-4100-9d0c-3b515e7fb71f@bytedance.com>
Date: Mon, 6 Jan 2025 11:53:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] mm: pgtable: remove tlb_remove_page_ptdesc()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>
Cc: agordeev@linux.ibm.com, kevin.brodsky@arm.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, rientjes@google.com,
 vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
 <b37435768345e0fcf7ea358f69b4a71767f0f530.1734945104.git.zhengqi.arch@bytedance.com>
 <Z2_EPmOTUHhcBegW@kernel.org>
 <20250103111457.GC22934@noisy.programming.kicks-ass.net>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250103111457.GC22934@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250105_195351_364422_5E06C237 
X-CRM114-Status: GOOD (  17.64  )
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



On 2025/1/3 19:14, Peter Zijlstra wrote:
> On Sat, Dec 28, 2024 at 11:26:22AM +0200, Mike Rapoport wrote:
>> On Mon, Dec 23, 2024 at 05:41:01PM +0800, Qi Zheng wrote:
>>> Here we are explicitly dealing with struct page, and the following logic
>>> semms strange:
>>>
>>> tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));
>>>
>>> tlb_remove_page_ptdesc
>>> --> tlb_remove_page(tlb, ptdesc_page(pt));
>>>
>>> So remove tlb_remove_page_ptdesc() and make callers call tlb_remove_page()
>>> directly.
>>
>> Please don't. The ptdesc wrappers are there as a part of reducing the size
>> of struct page project [1].
>>
>> For now struct ptdesc overlaps struct page, but the goal is to have them
>> separate and always operate on struct ptdesc when working with page tables.
> 
> I don't see how the current idiotic code helps with that at all.
> 
> Fundamentally tlb_remove_page() is about removing *pages* as from a PTE,
> there should not be a page-table anywhere near here *ever*.
> 
> Yes, some architectures use tlb_remove_page() for page-tables too, but
> that is more or less an implementation detail that can be fixed.
> 
> So no, please keep these patches and kill this utterly idiotic code.
> 
> The only thing that should eventually care about page-tables is
> tlb_remove_table(), and that takes a 'void *' and is expected to match
> whatever __tlb_remove_table() does.
> 
> Flipping those to pgdesc, once its actually a thing, should be fairly
> straight forward.

Well, since I've already sent v4, and that patch series is mainly for
bug fix, I'll send a separate patch series to do this.

Thanks!

