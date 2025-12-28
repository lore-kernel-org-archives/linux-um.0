Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1758D3B7E5
	for <linux-um@archiver.kernel.org>; Sun, 28 Dec 2025 13:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7lWyQqsYJqWc7lm9cTjRQLwXSVE/IuAz3ei2okz3340=; b=BN5l7I1QiwojpQ7S3ctRW0ebVf
	MFCS79BPFMfkdnNgrabE7tgBHD01kTEMXh6Zho8afX2DdKn03O0aQXEkx0c/C6B3quUH04g9fYJrK
	HNGHXgs+P7AXsnrkaQRnUgWbVJ7zNe1n0k2Q/CyuAhEo6oO5CcJJlt0EjoKwBv3j5NQ9wZqmOBO1B
	m9/Rg8ih5yI8+Ql07Kj3in1/gMPGhT0Mgphxb1gIjtTD0kzYp+TkGbsEc0bY05nyLtY06kjka+Y+3
	2Fwv6q9gjjyNjY5DBoyHP+0PwaAetRXN+XK6F6KoHJzmONMjR0nUVUdwgrpnTEBf8awOxGU85/HNa
	07FfqIEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZqqR-00000002mMS-0tQ2;
	Sun, 28 Dec 2025 13:30:03 +0000
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZqqO-00000002mKd-1iAG
	for linux-um@lists.infradead.org;
	Sun, 28 Dec 2025 13:30:01 +0000
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-597d712c0a7so8663798e87.0
        for <linux-um@lists.infradead.org>; Sun, 28 Dec 2025 05:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766928597; x=1767533397; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lWyQqsYJqWc7lm9cTjRQLwXSVE/IuAz3ei2okz3340=;
        b=QPDgTZsutGviVonp/6FU/JsAA/9QKxAI/C/UENbEiv9cRMO1VVmGHWMRJlopHK4Eii
         10jGkkidUQW4biTHBSH1Uh5W8xLqMvOsdX8AXkMfY2qX0Hi+0tMTz++s+8XQ90eIYlJj
         qx238U1uGNcu2FDGmaqlhSr5ZTsEBmQJ5RK8ioNacSU0c39vfBFRpYr8ojvN/Zosnoio
         meTWDOeDlNp67WRHQdwjDg5eed2jMNVGhnL9+AlhLDHEfr1SBDJ0p3YnQwcJwykpGc9e
         nA6PChYWrwN3vrDS/afBhxdxnbGeFa4kg4INq81HXv0dkYj+cuziFB2HFXgCi2ZGC7UF
         AldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766928597; x=1767533397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lWyQqsYJqWc7lm9cTjRQLwXSVE/IuAz3ei2okz3340=;
        b=BL8ikLmzhpItlqP6fO0JQQoPb5ZTaPfqFRdjlYgKOwGGaOGhBWfu7X8uH4/BugxlYD
         mcJ4UeDK7tNZa0vPVWLbJFypBvmYEaLwrDSAXDcpKHSdAG1lurNwH4sP92ZDs/mHNVye
         BbU0BlYA9b/1Yfd7ilo9n2qnl4PSYZ5r216QukBiHJKMhcuV1hTpv224SxqBLtKTy5cL
         s/1yXuZkBGj55EdO50w6+d/XKX90LuZ2a1dwmVwtaWZJm2AJPvIrCIwVvIytwcOXZ5yC
         Xe6LnyUt/A+E3bdKRBAUGwBRBPVVLAnXMsPrsxF6BIqfJcBiOomarIeMwW4B6/lDEkYU
         2PGg==
X-Forwarded-Encrypted: i=1; AJvYcCWVhIdsGo07vDyzTJbPe+QaW/6DAHC97l9+TXA+v061K26JXxtxhfWXTXu6wJu+PvLOsFO9zDMHrw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyZyRPfV+Mz7AZVAMfMUlnaaxD/15Uus8cCanB0mShVcQ6Gxi42
	9Zad6Fx2G8PJH+NQ7p4dm6alzAnSjC65wajjQfNs+tpMywp/FTqFz+1D
X-Gm-Gg: AY/fxX7KRndWymCiDnrzTkOVzUN0IVsEfhrUYHDSi20xxTOD3w64JMbiLKtm7BNHn6L
	bubw/oiqF4MAQLb2mUjtVWoERNhZUqbSITtR17yDqjIUDmFjdHtYK+vDXO7URlPC6hftHcIv6N4
	yKQrc6rKP5/Vvo5lNC8vbnPwvqZVUPZo0P7PWWx2KXk1nIuCfThWb0GjpJkIe+6Rz6FhR49e6zg
	tOBxX1ogY4oSWFW08jjaDnfqZInWLI8fL9CibSoxzJMuYpVSd5sEbsONft9yxuPkcxWEXU/vZJk
	NyPzqqzjhmRJbXmCFPhBsehQ3ni9iEinddGl1DvDOl6YrZ3reLuUwhjHm2LdkUnSy5w193NZ8cb
	VeKCq0lqOdJcAxDVdOw6+VgkN+dEYm3bq2H6pBelRrIAQhNcHSPtlcAzyCy3biRE5ccWUSQLm35
	afT9NgPhxHEhMP0iCK7jiV6lLUOTcslw4oQjeh9AJSFlCHRIn1RBCOufxRIlCP7NZTw8oLwiuih
	nAQ0EcH
X-Google-Smtp-Source: AGHT+IGo/pr+AQ2VNaaG2TyhewLh2BG0nsRAoXdF/d33J1EZZvYOr8FxE2Re2WZCgj4kGCoIAYrr8g==
X-Received: by 2002:a05:6512:3b0c:b0:59a:11b2:2c08 with SMTP id 2adb3069b0e04-59a17dd5fb7mr9312428e87.43.1766928596662;
        Sun, 28 Dec 2025 05:29:56 -0800 (PST)
Received: from ?IPV6:2a00:1fa0:425c:b771:d34f:d055:3147:bcd9? ([2a00:1fa0:425c:b771:d34f:d055:3147:bcd9])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d602fsm8238417e87.11.2025.12.28.05.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 05:29:55 -0800 (PST)
Message-ID: <d58d6cfa-d9d1-47fd-91e4-533756f3b3bd@gmail.com>
Date: Sun, 28 Dec 2025 16:29:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/28] x86: don't reserve hugetlb memory in setup_arch()
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Corbet <corbet@lwn.net>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Stafford Horne <shorne@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org
References: <20251228124001.3624742-1-rppt@kernel.org>
 <20251228124001.3624742-26-rppt@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20251228124001.3624742-26-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251228_053000_473273_9795C45E 
X-CRM114-Status: GOOD (  15.29  )
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

On 12/28/25 3:39 PM, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Commit 665eaf313314 ("x86/setup: call hugetlb_bootmem_alloc early")
> added an early call to hugetlb_bootmem_alloc() to setup_arch() to allow
> HVO style pre-initialization of vmemmap on x86.
> 
> With the ordering of hugetlb reservation vs memory map initiaization
> sorted out in core MM this no longer needs to be an architecture specific
> quirk.
> 
> Drop the call to hugetlb_bootmem_alloc() from x86::setup_arch().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/x86/kernel/setup.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 1b2edd07a3e1..e2318fa9b1bb 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1191,7 +1191,6 @@ void __init setup_arch(char **cmdline_p)
>  
>  	if (boot_cpu_has(X86_FEATURE_GBPAGES)) {
>  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> -		hugetlb_bootmem_alloc();
>  	}

   You need to drop {} now, no? But seeing that this *if* gets dropped
altogether in the next patch, you may as well ignore me... :-)

[...]

MBR, Sergey


