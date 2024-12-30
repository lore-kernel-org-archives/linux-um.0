Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C4FE77188
	for <linux-um@archiver.kernel.org>; Mon, 30 Dec 2024 05:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z71RF7AQSzzvF96cC/aV2tD8Znb4DG916rBbscUdZ1I=; b=WgprqcwuK8dnvP1gXWwK2Y+e6B
	uKPYmxmty5lZ4EDLPt3OEsfX1h0Lx2KftF9qhpNJHdyUohhU39NKhCcpn6AnWt59ZGxgOAeu7Xu6T
	Hw+h7IeINVYbOjZbtGp+qtBVRrc3N8/PXOyCGb2Nz93epnZy0SreKOuFL2Oiky1qfCQ1DWK24BLpQ
	8c2lPkmOl0CMNQ/DEjsO3rimrcyam4bDulkSI98jufaHssJgEvHAE8NRRZ0JpU2BhZPYzy2ooDOC3
	QnDhouGvpCHt3veXwjlwhoQP6YeP9Qci+jM1+wgjJkazDSGtrv7QA+Tm6qqN99foo57hpnm1TxNDs
	Qpth+eeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tS7vH-00000004YVd-10Tk;
	Mon, 30 Dec 2024 05:02:35 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tS7uT-00000004YLA-2biS
	for linux-um@lists.infradead.org;
	Mon, 30 Dec 2024 05:01:47 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-21636268e43so14422205ad.2
        for <linux-um@lists.infradead.org>; Sun, 29 Dec 2024 21:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735534904; x=1736139704; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z71RF7AQSzzvF96cC/aV2tD8Znb4DG916rBbscUdZ1I=;
        b=Fp4cwpkyL4nGSltS6N+5ZH048AyQ5QrEn833KK9BUkefZSKjYJZzehuD2s00Pu6Hxp
         lVhZVe3DdlwJeLwnXaTiuXGib2UWkUsYRYzEGFB0igQAcltl9dVXGX00fBMBgL19CLT7
         /MDVGwQFDoGSYpQhIBgc/BSxe6VpoULkR/hErcVHw5tOJzMD/6irvnH5EmIZwaGTEOu7
         FlorGMNnlzvJugLNgr4C+I8KD4CaW8uknq5Whj54w8WPXOAJxrNFxZ7IE9c0hg/Va3mY
         FCRbQpYgpH46suSXh0Z/+rA4z75NMVBCozwC/rcNqrkQ95R2uwVa2RaKuMRdT6ojcOCH
         s92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735534904; x=1736139704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z71RF7AQSzzvF96cC/aV2tD8Znb4DG916rBbscUdZ1I=;
        b=iJ8YXEkgycJngyd5m24gW/FmUZNrz7XbG263xhKW2amXzwGMEYs9Nhc8BFpNtH7mre
         nrccyghUv9uOfAUsYHvsZY/L3DsBK37nhw3KsGq0sM3qkyGve9XOuDJiZrAlWIl8ay9i
         hc1XxdGoEorJL4npTl6csWHl3ZUuhy/TAGXl7Knjx/HWFnfCgwOVOvcRxkH0i0i0H7oI
         fPm5hcdc+KeAgdjkaYW1bMnnNnj+c/R49/Aq5lrlkffly9z3tql0IzdNiITXAcSE4qeV
         YF3ka+LnjsRr2L4jQ9gcjwg06AvMPf0vsa8Q6p5ZP+8ozYNtJOJOF/ZWSHUM+HZB8aUM
         rDAg==
X-Forwarded-Encrypted: i=1; AJvYcCXBWWCV3yhr43J3t4qGtfv4Fmp2QI3fodywTQgYTOn/seLIhfY1drg/NmgTv/r2fCCMmeU13gBdrg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyztFvH1mMKJXeJrlUIiB4jZuoEeWBZkT9581H2jbZVY8gM7T2c
	pddrlvMvzdfbiqCiazY5FhpdW3/TBB9jLWHrYf2bOTalxU1JgqQ9m3jW/mTxQhU=
X-Gm-Gg: ASbGnctmnFN0o0KCd/Pr1Q3VTzgU+d9VhXF6oGgEAmDjbnNEHHdMn480Vdrdg5ujCHT
	fSb2V0mGfp2j6S+wVUP4eSdAShgOO4zFymbPP5LBh52RyDkLSsgjwbsWlRm8ygdSHO0DhpnYSv5
	cAoQ6oNO0NiiU3gioriEYRv+FLY01xtZCE0XQzu6lzRW38SUjijgE7To5F/4CcGTUKW2E+H0Hpd
	lCRSQ7KqjUJy6NkKULK2Om7Ppr4EmOaWDonZHtwAcUhHjT1y12kSVV1DpBvu90oy4IM+OsnF86w
	KQRTWQ==
X-Google-Smtp-Source: AGHT+IGNJA4bVLowcqsTNcTKWXSt9C1oo/1EXH42Qr0z5K3kcPv3AzGfuER3K4niOaxH4y3G0nd6hA==
X-Received: by 2002:a17:902:ce86:b0:215:a57e:88e7 with SMTP id d9443c01a7336-219e6e89215mr362710865ad.3.1735534904325;
        Sun, 29 Dec 2024 21:01:44 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba7325csm16914771a12.7.2024.12.29.21.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2024 21:01:43 -0800 (PST)
Message-ID: <efd81018-f637-4925-9104-c9586fef688c@bytedance.com>
Date: Mon, 30 Dec 2024 13:01:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] mm: pgtable: remove tlb_remove_page_ptdesc()
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, kevin.brodsky@arm.com,
 peterz@infradead.org, agordeev@linux.ibm.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, rientjes@google.com, vishal.moola@gmail.com,
 arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ryan.roberts@arm.com, linux-mm@kvack.org,
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
 <9cac5690-c570-4d43-a6bc-2b59b85497ae@bytedance.com>
 <20241229205545.e4fa797886f30cb20c38ad06@linux-foundation.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241229205545.e4fa797886f30cb20c38ad06@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241229_210145_688893_56B19F88 
X-CRM114-Status: UNSURE (   9.63  )
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

Hi Andrew,

On 2024/12/30 12:55, Andrew Morton wrote:
> On Mon, 30 Dec 2024 11:12:00 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>>> For now struct ptdesc overlaps struct page, but the goal is to have them
>>> separate and always operate on struct ptdesc when working with page tables.
>>
>> OK, so tlb_remove_page_ptdesc() and tlb_remove_ptdesc() are somewhat
>> intermediate products of the project.
>>
>> Hi Andrew, can you help remove [PATCH v3 15/17], [PATCH v3 16/17] and
>> [PATCH v3 17/17] from the mm-unstable branch?
>>
>> For [PATCH v3 17/17], I can send it separately later, or Kevin Brodsky
>> can help do this in his patch series. ;)
> 
> I think it would be best if you were to send a v4 series.  Please
> ensure that the changelogs are appropriately updated to reflect these
> (and any other) changes.

Got it. Will send a v4 ASAP (remove [PATCH v3 15/17] and
[PATCH v3 16/17], keep [PATCH v3 17/17]).

Thanks!

> 

