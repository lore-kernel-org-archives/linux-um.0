Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AA2C9EC8C
	for <linux-um@archiver.kernel.org>; Tue, 13 Jan 2026 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=; b=HIfZls56R68tuAkOeBKUMVoIUM
	BwbfIoPSfcBLsE9pXZFR6dsXhJxx9Hc/aks7bRRtes/Kc2UItfcCCaCzRAcfDtIkZhFzuz980inzW
	cgbHc9sTrd9NaSw3exoMODy5kbVBKtBVDALThezc9kKHODbSYORqjMuLbFdxTcjwahtyY7gthxOVE
	5AhOEuTwUBKOWSLFekfhp5cRRtz5DsbM63Tutro7TgEyXVbTShtfNI2CDzhM9Vn2ASS4vAM88c97y
	XJSbt3yKMuQRIcLvn7vpYZ2cqn/7jcNjteB0tUf/ywMlZ0meppW+bQRAG9XfaSnLbKEK3g/xrmOpW
	dweM2SRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfbLz-00000006sgO-0zzJ;
	Tue, 13 Jan 2026 10:10:23 +0000
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfbLu-00000006sg2-3Puf
	for linux-um@lists.infradead.org;
	Tue, 13 Jan 2026 10:10:21 +0000
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-3831c18b23bso34567791fa.2
        for <linux-um@lists.infradead.org>; Tue, 13 Jan 2026 02:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768299016; x=1768903816; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=IKMgzNjuiKHlKM02Eradz0/zRy3MMJEFkq45nq4SI2MIePpvNxSSHbFCEpmc/sgxwF
         /1QdCSJB02kszadG/kpiDkQaR64jxxCOfeI3it53Xg2dqVXWbMksFl2vrHFSAVYUG4Vw
         59NplNunJU+lPB89E6VwZq4WkBBGw7otJeOnWjXU2oU+bq/3BoupRM9/SI0BqFTt4bNm
         AyFDPaS8Kp6v+HCGJezAKDwYI5F0G6SG/k21QU0kno8jysetXMGXb4XkQhymQptt6op/
         93xBm9bKbDxl/QT+/g+BCeOu4vvm8dFkrljDxZ3whPeR1MDy/K9efUSF/nToZwMoycpF
         zmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768299016; x=1768903816;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=hwrsJp9UJ4DBEiR+w/WB8jZrRIWJsomI0rY01HZFTqDkF7uXyCw81zTbM3BGgZYWLH
         NtLhLmgnjeTzp1u7dC8TggMfODRugGrw6Yc7FGkyHNgAXK4vDPF0ReuGEVwbsixXHdJ1
         8Y6N3S0BrHYAwTcPuEDkxEu8+BszLJLZmYnABlBuD4NfRlN8NhcAmV8/QojEFvmlj+ve
         eEbaXbzXM1Vh4UDZfDk5p0s9WG62mWFLLdPCBTqu08xFUCL07cdzmJp36+ntWUhtnYYZ
         3GtrV/yi4YZOHVeGq6HaQDlyE33J1APyL5rQ60MfhvAAfgODuZU6fb/HgkQdIjP1W/nS
         23pw==
X-Forwarded-Encrypted: i=1; AJvYcCUzx7mHi4Y16n43uscA0oSoenxkQPCfNA6SXCl0JwVlaeRO8HiW8p5+jbi4kAMIELYKgJ8/qoD3Ug==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxz2cGlTHSxLPnObUcLgHRuakV+PHrmmvAxqXtpH/6qXDmpbDfY
	yabixON3bBKeYD2VKVZS/0RtOaObZPbqUxcaeVoDWxzO8Z+W+noGCFWi3+l0OA==
X-Gm-Gg: AY/fxX4ToR90xNKZT4bB+InYMS6w6FdK8CX7f78PbWcTROFWziqtRIgF0FdJF2W5pv9
	ST97sXXzqNGKSOzElzZ16x2rLcM61fpXnm4AL/6ffYL1eeWB9AG8ZrkEhTK5frh9MAKEWnzQTeP
	aslEEEoqZnETiVNd6JRCo5ClxPCFDfZNnwXs3FkLhCfgqf95bu3YXJpMTe86lSnSLhBmleFBV8P
	WBWqYa1JrbWgc0XRZzERki1f2tAIhjLuRj8Mi84K4uvcQI4FJPlS0ILUhi0gnldiBXJ11lLcExD
	Xm3rMLvS3IUBB5ClOCLSWsra5g0tuP9xbEqMk/gJTXJmyY9fdvLfrC8AzzcbE1El3W+YHDigC2D
	pXoPKwyu1RvyHrvFskD0B3tqgXW5/8WBthlfCzs1lIi+SNFE/35LijewrYrMF8A0yD3t3BZSGH3
	mDxmCQJjQC3cQVOH/gzY8/9sKzrKJkQSl4ra2eq9aKYxVRsY+qht5ys5X2vQ==
X-Google-Smtp-Source: AGHT+IEOoK2sWcGzQ5k4NJjsFR/RmdeWAB9vvZrFfNJ0u+S6dsEFK74/fdYnqiqEV2XmHMt6sJ390w==
X-Received: by 2002:a05:6512:138b:b0:598:e851:1db3 with SMTP id 2adb3069b0e04-59b6ef05760mr8236951e87.11.1768293628066;
        Tue, 13 Jan 2026 00:40:28 -0800 (PST)
Received: from [172.20.10.9] (mobile-access-c1d2ca-216.dhcp.inet.fi. [193.210.202.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b72f3ae82sm4416299e87.71.2026.01.13.00.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:40:27 -0800 (PST)
Message-ID: <f861a1c6-7ec7-477c-bc42-f9aaf6724bed@gmail.com>
Date: Tue, 13 Jan 2026 10:40:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/29] arch, mm: consolidate hugetlb early reservation
From: Kalle Niemi <kaleposti@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
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
 Jonathan Corbet <corbet@lwn.net>, Klara Modin <klarasmodin@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Ritesh Harjani <ritesh.list@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
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
References: <20260111082105.290734-1-rppt@kernel.org>
 <20260112142323.495fc43e662e7d276b0fa371@linux-foundation.org>
 <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Language: en-US
In-Reply-To: <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_021018_894981_927E7FD3 
X-CRM114-Status: GOOD (  11.02  )
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

On 1/13/26 08:50, Kalle Niemi wrote:
> On 1/13/26 00:23, Andrew Morton wrote:
>> On Sun, 11 Jan 2026 10:20:34 +0200 Mike Rapoport <rppt@kernel.org> wrote:
>>
>>> v3 changes:
>>> * fix empty_zero_page initialization on arm
>>> * fix ZONE_DMA limit calculation on powerpc
>>> * add Acks
>>
>> updated, thanks.  I'll suppress the ensuing email flood.
>>
>> Kalle, can you please retest sometime, see if the BeagleBone Black boot
>> failure was fixed?
>>
>> Seems we haven't heard back from rmk regarding
>> https://lkml.kernel.org/r/aVrUDeSkqqY9ZCtS@shell.armlinux.org.uk.
> 
> Hello!
> 
> I will test this v3 patch ASAP and reply results here.
> Collective sorry for the delay; I have been busy!
> 
> BR
> Kalle

Hello!

I tried this patch by cloning 
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=hugetlb-init/v3

Boots succesfully on BeagleBone Black!

BR
Kalle

