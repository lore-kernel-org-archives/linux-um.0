Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91ED7D4A5F4
	for <linux-um@archiver.kernel.org>; Sun, 18 Jan 2026 14:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AqDJGvudyOS3k99PpLPEmecPUls9OZTpXwxY9UHrGPM=; b=kceL9TECubWRvCbaWXGrysaM8k
	NkPI5B+OWH1+SLiDCds+r8QaUA8wIYCjxy1VLVDICplKSk7VJk+KnVNLDZZxx3FMgmJV4f+Mtw7Ht
	53QmBOWx1rj4wABxrKbsrLmAO3xkbStj6F/wPkPMoRUWiI0rfuDco5YCuaV4uc2pzPiYGiiu5dvqM
	dRVePDXqn2BHZXQmLGNlzhwTvBrW60mZjpeDEUKixjTnaRO3hI50wtHcv1EeWPiwHe9wbltAJ5Hnc
	KiZgIGv21/H1NlvEnSfN+YxQkMLmvsenKRTMPH/dQqyLzM6antdAqJuo+QAU93A8at8fkiYmVTNue
	QuR0WIBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhTV8-00000000D6y-05zV;
	Sun, 18 Jan 2026 14:11:34 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhTV1-00000000D4W-02lI
	for linux-um@lists.infradead.org;
	Sun, 18 Jan 2026 14:11:30 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-c1e4a9033abso1894332a12.3
        for <linux-um@lists.infradead.org>; Sun, 18 Jan 2026 06:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768745486; x=1769350286; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AqDJGvudyOS3k99PpLPEmecPUls9OZTpXwxY9UHrGPM=;
        b=mBVyIC6wb/WjByrdzSYZIAHkAIcNsGWBrFYRp6GIchZm7ixehNN2lNmeMC6jWp5D6O
         w7uZmBWVochKGrqhmmpZiq/7+cjBsA64Pg88WuwOpKeZiPgCYWKjO1PfzbXxwbZM273M
         SS6N9CKvo3GFKdpRn1sNa++EBEGNYqAjhqojY/CUFIZGNnBJ7oygd/4dKpDZmp2nqgB2
         int6DfXSQjDWs1TvBcj+z8ghIgy8XojVB2P68n+X47OdZeuWeXv65caOYidLALB1ieJ0
         tM4StHMCxObcRwnW75LLRcEahIN6Y1XBtH0Gqnc5hYlVctnH40vaA40jMOHWXyPhqX0x
         Iwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768745486; x=1769350286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqDJGvudyOS3k99PpLPEmecPUls9OZTpXwxY9UHrGPM=;
        b=PV5NjPbm1vfpvXPkxoMNaNXgOJoqscKdjJ+97128gQzhKeGGXPTgVv6vZbkPGtwT9v
         gT+x4vhFT1Dqj6cr0lrStQ0Hy7SLvHkSACrkwFngB5Bovo8xAZuX1vktT/4w80kUZg7y
         vS4Xk5yuwDT2RFt/N6MObgmuTN+7kkUqIMgalicf1itOGa4+dnjz+Os44sZ04cWZ7OXB
         BkAgxbww1LUc+9YPX7164115Hk+bwN4XJNuxMvVdNX0X2ZhkycrbPZ2QIbNWKuEXhxF6
         kyUsZQyyuIhOjI3Ur3PDcvYoqeVJW5zlRMLZt+BOZ/3qkpSOk4hfCVE1bYJRSmvBmpnA
         0Tqg==
X-Forwarded-Encrypted: i=1; AJvYcCVzLEFBtYtCCj7Rj1HyjCEdP2mdGlpJdc3KAg6fwxqUcW7jncUQjpYmlOBQjzG7K7ezvXs6cLSDBA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz8WjYcMr/Y5hGF8s56Kg44hNUvqCrpSV8H3KS5fuZNptaYpWEP
	Zt3paTb/tZxZQec/7U0laNlP29C0ioTtn+lAUMUbvWiofzKFte+oGSE4
X-Gm-Gg: AY/fxX6NY31S2wJVPzR8V4wAuhTRZG8dfr6pqrYvIf9M3emU02+//0YXs3yH5im/EDh
	Wa/gvCSz5ow5WGI5Nkd23rYTRzEXYL2Z+CVO1k22TUuvMe1xdn9rce6wPbgD9CMVPZG3GTetvry
	81UcKz5vmTMWHyxaWfZV24AmxzjnerbeYcSCJoXExO/Ai74eFBKloz9CdfIRgvdUkFAHoRy9WOc
	FSm6DH8JqO5WGPyhJwz+TAK02q71+c76t4Am6wUmaueltyVNIFYFqwzn2k8cD+Mke8koTwjxIO+
	iAVXwxKpyNgSKVKFWm9eTe2OCgbe4+ndl7HWBoXaxjoi/7bxcwARMGrhs8Ywr12ZSpWBg+avtpl
	HN7TF4np6ejQOKJENawYdim7XzcbUnIgAq9KiIADETyjKStREIdjEJbbvhd1zJ6g7qjJKnjNZkZ
	LZSjt66CTs
X-Received: by 2002:a05:6a20:a122:b0:37e:61fc:a896 with SMTP id adf61e73a8af0-38dfe7c3042mr7636975637.66.1768745485767;
        Sun, 18 Jan 2026 06:11:25 -0800 (PST)
Received: from [192.168.2.226] ([114.92.45.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d1f1sm6549138a12.22.2026.01.18.06.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 06:11:25 -0800 (PST)
Message-ID: <b27b8bc4-8730-4ce8-bf39-0ca8459feecc@gmail.com>
Date: Sun, 18 Jan 2026 22:10:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/pgtable: convert pgtable_t to ptdesc pointer
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>, alexs@kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 "open list:MMU GATHER AND TLB INVALIDATION" <linux-arch@vger.kernel.org>,
 "open list:MMU GATHER AND TLB INVALIDATION" <linux-mm@kvack.org>,
 "open list:C-SKY ARCHITECTURE" <linux-csky@vger.kernel.org>,
 "open list:QUALCOMM HEXAGON ARCHITECTURE" <linux-hexagon@vger.kernel.org>,
 "open list:LOONGARCH" <loongarch@lists.linux.dev>,
 "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
 "open list:MIPS" <linux-mips@vger.kernel.org>,
 "open list:OPENRISC ARCHITECTURE" <linux-openrisc@vger.kernel.org>,
 "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>,
 "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>
References: <20260107064642.15771-1-alexs@kernel.org>
 <aV4h5vQUNXn5cpMY@kernel.org>
 <080e493a-e4f1-4c97-a3e1-f76f126b5213@gmail.com>
 <aV5yIuGi9Ni5YP5E@casper.infradead.org>
 <1d110134-89ab-474b-bca6-cfbfd4b5057f@gmail.com>
 <85a0be43-3598-435d-a50e-9403b7e963f7@gmail.com>
 <4fd1610b-acc5-4c17-a227-4d63272d3718@kernel.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <4fd1610b-acc5-4c17-a227-4d63272d3718@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260118_061127_484594_0CF63BE4 
X-CRM114-Status: GOOD (  18.70  )
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



On 2026/1/18 18:51, David Hildenbrand (Red Hat) wrote:
> On 1/18/26 09:13, Alex Shi wrote:
>>
>>
>> On 2026/1/8 10:23, Alex Shi wrote:
>>>
>>>
>>> On 2026/1/7 22:48, Matthew Wilcox wrote:
>>>> On Wed, Jan 07, 2026 at 05:28:36PM +0800, Alex Shi wrote:
>>>>> Right, I will fix this. and sent the 2nd version.
>>>> No, the patch is stupid and wrong.  Don't send a v2.  You seem to 
>>>> have a
>>>> hairtrigger resend, so I'm trying to prevent a v2 being sent instead of
>>>> sending a patient reply.
>>>
>>> Hi Matthew,
>>>
>>> I hear you—no v2 will be sent.
>>> but sorry for a bit confusing, what's your expected fix? is the too
>>> quick resenting? or the direction to alignment pgtable_t with ptdesc is
>>> wrong?
>>
>> Hi Willy, Do you mind to share the detailed concern for this patch?
> 
> I think we recently had a discussion that we should much rather rework 
> core code to consistently make pgtable_t a pointer to the start of the 
> page table or something like that.
> 
> Because the way you change the code just means that we will not be able 
> to handle code that fits multiple pages tables into a single page 
> (s390x, ppc) consistently.
> 
>      arch/s390/include/asm/page.h:typedef pte_t *pgtable_t;
> 

Got it. Thanks a lot for the explanation!


