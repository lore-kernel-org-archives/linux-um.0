Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B240CED62B
	for <linux-um@archiver.kernel.org>; Tue, 18 Nov 2025 11:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9v8UiKRyyvD16t4ENb8APUiQmIzVsGi/FebBj0lOkJ4=; b=1ZOplu+9tqQ7e1MoQQhEhJvmBL
	P29S3pXie6zP5UUltEX0L98/t/KyjWSfrShc54MhhvtUoAoggSfwElPeLZyVGC/ZsGMZmtD386eNo
	preMHR9c+jc6zL3N2UD6xPtN6VchPDxFANHqZf2qbP/cR59HWKO7pxTzl2hcU0BjQEF6OMyzYie2I
	UMD1ngdqohS4sxgNJb2bW5MpjsY/5IJxMHQqmg53W5VPXDRasMlyJX3Svb1BTs1UOh7aHSXmcpxcM
	5GExffjSaL2VFjq8VyDpjIU6XeUDW1CqC6Cbv62zuo2CbDfqblxYxpaWiB5WtlJxnTrDZiuggoW16
	B+ayZqVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLKIr-00000000My6-2Cxq;
	Tue, 18 Nov 2025 11:55:21 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLKIo-00000000Mwq-0T6u
	for linux-um@lists.infradead.org;
	Tue, 18 Nov 2025 11:55:19 +0000
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-2953ad5517dso59613225ad.0
        for <linux-um@lists.infradead.org>; Tue, 18 Nov 2025 03:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763466917; x=1764071717; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v8UiKRyyvD16t4ENb8APUiQmIzVsGi/FebBj0lOkJ4=;
        b=OcMXbNPU7SwW16btakHamAVWHFjnT0RYKRhmNHjvfTA5iTgyj3/88lWZULEH55c4mV
         +l8AfTozGEi1oVy4aKr7z/v7Tb+uoIFiC9KkiB/d3KMkyfhq5T77Cvb6dMh8mSOIqLjH
         nBm2QrZ4anaCfj6257XRs5zAXnaxu8Md4BafRyors8Th+PMQ4KQTE8VwBKDQZCpz81BT
         inv1isUJSJ7nK1cBgEtyqI32i2qWX4GMNUZyn/QZLRU78yYstuq7Jd4PdQwqS0itExOY
         D2VpNqrWZ6XkrxQoZyyTG4meGZpivRF5/3ubdnzQRZ4fVN12uObCnqIKVHhdlNk6zRq7
         E7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763466917; x=1764071717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9v8UiKRyyvD16t4ENb8APUiQmIzVsGi/FebBj0lOkJ4=;
        b=P/bsQmLI0YSzPpTXJfiYATkblzNGmw9Cw4wxLOJM+JK1fvf40VFwqTxlTVmy8l0Okr
         hiERyULO1+H8M4B6qAFtJ+FyNH5zz7GPuk2EHLvC9r1q76dR2JA/vxc2MvBmjsRaxOx3
         aDZgUpa/sBTWteLW52xqkMH0EhHqyBJBnXqVhbo9HSoUYLhv8B7IpAiMLNNvSYV5pB1h
         X1JFAKP1UBoQqacsGUUJYpl+qNOdc4MmUlqAx2iAQU8ubkzYVvkRzsKCA8yNlsRfftEH
         0HmspSAdzzrFDNZoFDQzQdAAeohsiCvP0YsbnQV8jLZmQ7PFHwicYQAr1jeOWp2Uf9uD
         O0hA==
X-Forwarded-Encrypted: i=1; AJvYcCWOGqu25o3QMKEQtQabv9QukO8CpIsfwAA2GP93cFpUHnkUsM5lThfc7qjif5wjC9/mf5wtCniq0w==@lists.infradead.org
X-Gm-Message-State: AOJu0YxNchd1ql/vpjr47VWwKWFmJIhcMoHOBPU8XPrz2EKRqKmNO3dJ
	5yvEMctl1APsATF2u2bM5sJJYZhmJk3SX4cEGSezQINF3IkFz4OUGZ8W
X-Gm-Gg: ASbGncvje1kdjuGIKNCj1D/zEneXmKDPOC1QiX/mMPZFkeC+7MqS4aVOAi33bgAwjsX
	D+H2Idlg8AEVIrpsbHMR11eH5ffn/uRyMfon7XahRK4pvpAeDDtl6xSa7gHBNuLEigYO8DznTZy
	K3DD79548VgZ5eR6/ZtNVeAlBNaSyViW4qDwUhUsws0bj1+66DKkMGhgKwR2O/XAXErK/arNZl7
	4yDgJSDnAi/xPgBr9UWkZB4Ov7zrB9e6ofMlVVVFXlQsGU1KsrAcX6Dy1bqIOIgxJJu2qN7X3Bj
	ZC0p54XbcpBT5YmMPvPd4CEUnESYLSYIbvIFZcVs6oAikGCT9AA2dbIbQ18ndJWvJTZBnFtwQhZ
	1I0MjLf5r1RXhgrwQk820IiSPnLjvZbIt4uT3rX4ZEYk/rDIF0T8DV7SG4Y8dUCz+KKm5z2yM2R
	qgKjT3XXw2hdGt2Sl/tBozRi2tDQTlF0SxgOB0muox6ZeE6g==
X-Google-Smtp-Source: AGHT+IGaNSdLxRla9oY02zDdWZQ+dAcjdxohCbg81uqIYBMI/Z6QJtGDDVm6vwOhGnWyaCl6P1ztwQ==
X-Received: by 2002:a17:903:1b2f:b0:295:3f35:a312 with SMTP id d9443c01a7336-2986a6cfeefmr183341175ad.20.1763466916628;
        Tue, 18 Nov 2025 03:55:16 -0800 (PST)
Received: from [10.255.206.79] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d17sm172235585ad.72.2025.11.18.03.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 03:55:16 -0800 (PST)
Message-ID: <f7f0ca8d-bca2-4a3e-8c45-85cba1b0ff18@gmail.com>
Date: Tue, 18 Nov 2025 19:53:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] enable PT_RECLAIM on all 64-bit architectures
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
 akpm@linux-foundation.org, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <83e88171-54cb-4112-a344-f6a7d7f13784@kernel.org>
From: Qi Zheng <arch0.zheng@gmail.com>
In-Reply-To: <83e88171-54cb-4112-a344-f6a7d7f13784@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_035518_319562_3133FA82 
X-CRM114-Status: UNSURE (   9.67  )
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



On 11/18/25 12:53 AM, David Hildenbrand (Red Hat) wrote:
> On 14.11.25 12:11, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Hi all,
>>
>> This series aims to enable PT_RECLAIM on all 64-bit architectures.
>>
>> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of 
>> empty PTE
>> page table pages (such as 100GB+). To resolve this problem, we need to 
>> enable
>> PT_RECLAIM, which depends on MMU_GATHER_RCU_TABLE_FREE.
>>
> 
> Makes sense!
> 
>> Therefore, this series first enables MMU_GATHER_RCU_TABLE_FREE on all 
>> 64-bit
>> architectures, and finally makes PT_RECLAIM depend on 
>> MMU_GATHER_RCU_TABLE_FREE
>> && 64BIT. This way, PT_RECLAIM can be enabled by default on all 64-bit
>> architectures.
> 
> Could we then even go ahead and stop making PT_RECLAIM user-selectable?

OK, will change to:

config PT_RECLAIM
	def_bool y
	depends on MMU_GATHER_RCU_TABLE_FREE && MMU && SMP && 64BIT

> 


