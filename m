Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E57C02181
	for <linux-um@archiver.kernel.org>; Fri, 24 Jan 2025 13:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dId7b4yz8t9ytNzoIMZDzDyU9S5trP6VQ+ykZ7MFw3k=; b=ZQNbGPki1amEVI3GuA5ioUG6h0
	eQg4lhKCUKTpqGE6KKtRqLXPZTmOo5xeuvS8LHBL+OUfITumC/W+Z4pwyJDEXmA88mIecqUBKS2hg
	3h7KVxfaL/UL/Z73PoG8S9Q23AezdvT5nQWphZyQLxG9saMQiUhV9yMiQ1RHPDR6OIETKarCfXcG7
	d3cb+Q3AM6rR28L4Bm3gFeNNWlrUKQJsvaTLzcU/oFXWn7iuJVu+L2i0c/B2XdCbL/IPcXjwGn0tg
	ZJ4+CpgKQ/PhKPaWiLsWGQBVLSQzmzz6o/6rqRhbcEvGnZn7GWBRLa7QEHsxO/umxncEL1+RFyofn
	xjl1A6nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbJMB-0000000EiAA-1jpe;
	Fri, 24 Jan 2025 13:04:19 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbJM7-0000000Ei7x-325J
	for linux-um@lists.infradead.org;
	Fri, 24 Jan 2025 13:04:17 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so3730306a91.1
        for <linux-um@lists.infradead.org>; Fri, 24 Jan 2025 05:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737723855; x=1738328655; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dId7b4yz8t9ytNzoIMZDzDyU9S5trP6VQ+ykZ7MFw3k=;
        b=D70ZZ7RnTzPzRDuA0rQ6QV+dumzbgk0yvVucaO2JY1G/YpWtsP8s8o7CmzFPWjh+VM
         acCrppt+59ikSNO3RBFwYt3ZUft2OItuDLMZv8hl3mcFi6I9sWhDf6KODp1w4zj3pxOY
         5I+uJxBUN/7t5HcbWHyKKpWbb+GJ5FnpkM7KyXtepV0+0T75NkqgCF/R4ogV6JRLAODo
         HZR4PL1vPFewqdge6uMauZR2PSK1OoeRR7Hl+ARPV8yyC/DkL82NfTkEyQDqHbddrwzG
         1/+fH1lIvx5fMo0rRl8uA2Sk2m49TTFEsclPymcS8yJ8UJwXvtM4OsqnGCNPqpoADT9Q
         iatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737723855; x=1738328655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dId7b4yz8t9ytNzoIMZDzDyU9S5trP6VQ+ykZ7MFw3k=;
        b=uqPXySSoQvj9Dim+YphT3suvWuLw7VKpUWe+4b/o+6+LViHA2+SzadZhSala7l6XjV
         t4RervoJZ3j5smindS9R297z1S8eejpZpfvK0NYP4VTnNHAejIsnrLk7ohvfsUV0EPUY
         sTYbZaeIl5pluXeAtoke2ptXbigjlVmf5DugVsNfuDmLOHPIJtkdyPBvPJBlOJTzdmOf
         FEW0eHH7Nz6nEM5r5ttcbobmGQ3ISWQDvBWwMoln/0KfZ9eim55iPZDQe7vv6YHWK+XN
         8LVhmBKoATsOP2klLuMrXm1wCW8ZCyUEyb/902CsU969xUC4EUDXppHSWo5VrW58TG2L
         EDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWeb52ewXWfklbe1nLbJusLoNkf6+kpizZsiwIgmwLYuSvVrW2tQzzkG7/JVIRQOE8mKIjU1XTnQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx6uFLqd5YU0H0/JEbptscdqaT7FtWBChEMheLpjXBCYXOfptyc
	FauINg5x3SShPpAo1Oat5hCju3r9COhCIPXWmWojRuNarJnjWtMr1aRS800Jv6Q=
X-Gm-Gg: ASbGncuNUapNhWwEyvvXixnkCtyTAelNqvC5IarjUkqzCRZk2iqMooURXJe5qLwBkmC
	fENwiuB9x3Yg2smQxipHhOiESpHS04+8ZwvYPD0BhRamwDsGLmlvdqLP0P4cS+9Bz4cfJ5fk2X0
	p8K4JibdrqCfM38eAaLdZjJrZh49xmu08cTtkRJh3NE4zjU4tK7vTgmgMz3uB5Ezf/RT5G7+1nc
	oJ6zdGEYE5xnZfZKXUFtOCuwU6t+d5G6GnIEIJ15RT9HIfCwfCoEWRnFm2wcp6LFtN1N33qCfjP
	KI1sboBdl1FAVhqazzA/N6l8O5/xkaOJcPp3UeNpUoM+H3aITlG9QWe3YYAvboF1VaRfYjjKioo
	uVfrz
X-Google-Smtp-Source: AGHT+IGZTgGY31e/1k/dTmcJmo/YDWxdXL7RglCap7bUypXHuwXLFHjK5+LGZw2OAN+HVTY4hEX3Xw==
X-Received: by 2002:a17:90b:2d88:b0:2f2:a664:df1a with SMTP id 98e67ed59e1d1-2f782c628bbmr47170073a91.2.1737723854887;
        Fri, 24 Jan 2025 05:04:14 -0800 (PST)
Received: from ?IPV6:240e:370:8b13:5250:f0b9:2326:6cb0:b423? ([240e:370:8b13:5250:f0b9:2326:6cb0:b423])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5a975sm1776638a91.15.2025.01.24.05.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 05:04:13 -0800 (PST)
Message-ID: <65710478-4ee0-499e-9f66-dff81e226042@bytedance.com>
Date: Fri, 24 Jan 2025 21:04:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] remove tlb_remove_page_ptdesc()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: kevin.brodsky@arm.com, riel@surriel.com, vishal.moola@gmail.com,
 david@redhat.com, jannh@google.com, hughd@google.com, willy@infradead.org,
 yuzhao@google.com, muchun.song@linux.dev, akpm@linux-foundation.org,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, arnd@arndb.de,
 dave.hansen@linux.intel.com, rppt@kernel.org, alexghiti@rivosinc.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 linux-riscv@lists.infradead.org
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
 <20250124114759.GB15996@noisy.programming.kicks-ass.net>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250124114759.GB15996@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_050415_759360_419F4028 
X-CRM114-Status: GOOD (  19.19  )
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



On 2025/1/24 19:47, Peter Zijlstra wrote:
> On Thu, Jan 23, 2025 at 09:26:13PM +0800, Qi Zheng wrote:
>> Hi all,
>>
>> As suggested by Peter Zijlstra below [1], this series aims to remove
>> tlb_remove_page_ptdesc().
>>
>> : Fundamentally tlb_remove_page() is about removing *pages* as from a PTE,
>> : there should not be a page-table anywhere near here *ever*.
>> :
>> : Yes, some architectures use tlb_remove_page() for page-tables too, but
>> : that is more or less an implementation detail that can be fixed.
>>
>> After this series, all architectures use tlb_remove_table() or tlb_remove_ptdesc()
>> to remove the page table pages. In the future, once all architectures using
>> tlb_remove_table() have also converted to using struct ptdesc (eg. powerpc), it
>> may be possible to use only tlb_remove_ptdesc().
> 
> Right, so I don't think Sparc and Power care to use ptdesc, they're
> using non page page-tables.
> 
> At the very least we should do something like this, the only point of
> having tlb_remove_ptdesc() is type safety, there really is no benefit
> from it in any other way.
> 
> ---
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index dec030cb1210..a6731328db6f 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -504,7 +504,7 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
>   	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
>   }
>   
> -static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
> +static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
>   {
>   	tlb_remove_table(tlb, pt);
>   }

Ah, make sense. I think this can be added to the patch #1.

Thanks!


