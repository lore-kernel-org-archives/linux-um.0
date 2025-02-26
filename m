Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362BDC021BF
	for <linux-um@archiver.kernel.org>; Wed, 26 Feb 2025 02:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=faw8k4TIY5A7eHVQZOGgzqUSa20esi5XC3jgrNGM418=; b=if9LjVrdgDNaBc7/TFHHZSGh25
	+pNo6dCYI/JoVjRC2xlWiNKXAnksV3zhOY2yPwbonkBpx2cbabFDZjv53tlhNhZlEejcHAu0c2ET4
	ZAphgVAsW/++7T+t+f+/3k0welmbkUF2tCgkZmSm1/cERKzPBcifhwdDwoTLJE6ppbG0LhVMgKJBJ
	e+mSTWIIVs5Uy6o/Qvl2bXB6NMffUlqYqC1wWLVEPw8WCjCmh3wXlBK5QBzBDtTJjir0C+8bEL1Lo
	ftkc3eHxySXo9P58XxH6fvoYDEN8ywiD4KsFTlJ9WSqtMhtgfhCjMpjjzSXT97x41ymOJz5XtYOgV
	KonkIwew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn7MA-00000002CAj-1i4H;
	Wed, 26 Feb 2025 02:41:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn7M8-00000002CAW-3aIO
	for linux-um@bombadil.infradead.org;
	Wed, 26 Feb 2025 02:41:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=faw8k4TIY5A7eHVQZOGgzqUSa20esi5XC3jgrNGM418=; b=HsuZTonoXX+5yrSNnVRt7on46P
	e9XZF8ABBPURW4bTqOBlJWnFZiT7oS7mvUbBjbtM7KaaJT+4PjKecZblfj1BvhCdKv9IcyEgaKFYx
	9k5ATL7wc+DfIE8shLE7imsCQFoNqwNzN70r5sBh7b9MD52iaeFoQEgMnxXssOQ0dJNa3gENeTiEs
	mRnDlP23JrT9yFhAGro3oX39dA/7x9VSn3dDK2xGTDDBjUX6iHVidJIGqJkx4nD3/syNIyQwkPsXh
	8yctkz75O+C9uCfn4yLUJAcbxxcnak9b4/d35/M7U2ufbht8fJdzFXVwxOqY0nhUFpbuMynK44P33
	cPCYp3BA==;
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn7M2-00000003Utr-1eQX
	for linux-um@lists.infradead.org;
	Wed, 26 Feb 2025 02:41:02 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2fc3027c7aeso12443045a91.0
        for <linux-um@lists.infradead.org>; Tue, 25 Feb 2025 18:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740537654; x=1741142454; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faw8k4TIY5A7eHVQZOGgzqUSa20esi5XC3jgrNGM418=;
        b=adTEbqWQuaMb5KvOhIDE2nDNNYo3I+4WUIyz39VKa2W6OdN/XEp7ycdhG5/hq19U3c
         UHckt29rq8Q1k4IP8iXxCAHruvyVzkQiVx7EO+tvATzxF0YCzrsimuB7kJEykqxidssR
         Y9m5DcQKejEqMKxrM2hLf5M4b9+r2zUFkXpgtOxNw/CEy1mk3C84NfFdoIjkXTwNGYN2
         e9nPOjZKlEyw6vA55adqHo/YA7UWD0zfQ02MKe6TWD3Getbc5u3/xLr9E7dLo0d1Gsn3
         s4UDaGqbekqi2W9MKaCcTzsY83q2688cxAg51zVl/5b5iNEwpfscJQjekK9xthRuffLa
         f1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740537654; x=1741142454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=faw8k4TIY5A7eHVQZOGgzqUSa20esi5XC3jgrNGM418=;
        b=iKq+lp52+QJ+K5dg8SxaTpq5ojOlvokaDlCYzH8Wmv4plHsAD5lGaxmPA6XtYv301q
         j+E5P/im6iW9t8hqDtYe9D39jvU0C0vht/qO4efuuW2CJi6GBooXqHlLSzpR1zTBCmVv
         e/OUMr4QdJnqe56fjLILt2UsWQf5GOMPdzFtDijwFIixJCe9LMWFceHnNuVeXGdrAJol
         kmJBF+QFk96qNyAy1w+o2YvBqkTY9mFQ8el5wBr2Y+xQP10FTL7IdH5lQZgAQ+1wxgP7
         jZzWEK3SULQrTR+6B5jZMQkSXSVlbYN8grKw/HYEArN0Nz1z0Ns8p2CnP6dKm5+3zWNy
         Rt6w==
X-Forwarded-Encrypted: i=1; AJvYcCXZXwOz3nS8JNAPqtgK02fCKA6NdT1LYXsoQdZgTRHtYR0xWMF3NPaGP5F0rwf5qugs2WR9cGM3SA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzJmyFxnydXLjIe3CtvHlOXevVT+qt+MDGbEOMxcGHLgqCCy0Bz
	wTd/ezcKY2OuQI74/xRcmmxvwJfU6kfb3QW6vpKPeyJKSGByAKD72Dx0giuSZk0=
X-Gm-Gg: ASbGncuDS/SF8Gb78akQqn/BGspezJoY2C5g7MN6nwTrl1Xsc99qCS/o77XtXTA+Z0X
	1PIDFjz+tSP1HPsw3xuuFC7FUfGVFqIM+8cdXemeFo1or3z8/TJAISJ0NVIXqg/bna9XuzopvVF
	aFGnVXuS4+FmX8EGmakZ+ANVSDjofrvBxjf5H4fHTBlvpmCBjmi3Gb+H36KZLG+umwhBXB1PUcW
	h0fXIeeUYk0e1UTujglEUqNfScCKbd0Nhmyo0CYV5CQRkBPT3LKlTPma8+CMGRXlFapXAznOZDk
	7HfxmKcK1vuGfKXkvBeDux5zNPIOPSwBXW5/EF+mScvT58QqSA==
X-Google-Smtp-Source: AGHT+IGBavOro6p44pm0knw7epDm1Ms4/cRCm5nI7A9v1bvB0aFlwIUaa3TK9A89BXdQQHklrRCMwg==
X-Received: by 2002:a17:90b:2242:b0:2ee:ee77:2263 with SMTP id 98e67ed59e1d1-2fce868c4f9mr34212880a91.7.1740537654049;
        Tue, 25 Feb 2025 18:40:54 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a000a01sm21742845ad.40.2025.02.25.18.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 18:40:53 -0800 (PST)
Message-ID: <3e3ab5b0-4669-4d7a-a7bd-6f5963662757@bytedance.com>
Date: Wed, 26 Feb 2025 10:40:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] x86: pgtable: convert to use tlb_remove_ptdesc()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com,
 vishal.moola@gmail.com, david@redhat.com, jannh@google.com,
 hughd@google.com, willy@infradead.org, yuzhao@google.com,
 muchun.song@linux.dev, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, arnd@arndb.de, dave.hansen@linux.intel.com,
 rppt@kernel.org, alexghiti@rivosinc.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, x86@kernel.org, linux-riscv@lists.infradead.org
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
 <36ad56b7e06fa4b17fb23c4fc650e8e0d72bb3cd.1740454179.git.zhengqi.arch@bytedance.com>
 <20250225183519.91a5b75b13c0df6954c68576@linux-foundation.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250225183519.91a5b75b13c0df6954c68576@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_024100_256140_07A073F0 
X-CRM114-Status: UNSURE (   8.69  )
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



On 2/26/25 上午10:35, Andrew Morton wrote:
> On Tue, 25 Feb 2025 11:45:55 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> The x86 has already been converted to use struct ptdesc, so convert it to
>> use tlb_remove_ptdesc() instead of tlb_remove_table().
>>
> 
> This is dependent upon Rik's a37259732a7dc ("x86/mm: Make
> MMU_GATHER_RCU_TABLE_FREE unconditional") from the x86 tree.  I'll add

Yes.

> Rik's patch to mm-unstable also and shall figure it out during the
> merge window.

Thanks!



