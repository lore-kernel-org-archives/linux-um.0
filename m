Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90943C001DC
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 09:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PU3I6LBNTXeWwE1c/kG+D/0AN1SO9bDI83N+cqFy7J8=; b=sn8gXnpg52Lzpb
	gMMaHta65cyHDP1l7xdo6CPGN2znCVpl1oqgluPBGHK9ZHrVZaI6FkqTLtTBt0W/tcqmXcfkS/p4h
	Vh924fC4e/4lau+k+HlVP/s+l5HijOLIG77ePg4G04OXm8LIAMq9qIg+7BvMgU9/5WahEUHq9xaIf
	r9PEODjOU1da4K/i+qj/FZcP/0/vG/BBp5g+Kiy5JSHU3PdYz/QesOkX/8MfH+f4v7WXB49z6RISJ
	c8ilRLs+OXo08OdSb/gJ57y8Vy+BZ8RQbDhW6sH3GfSh6V20uHOLYtUbfSOhrxxf3hbmr0heUW8EK
	AzyMsrcHvaW7RKPzr3Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9NAs-00B8CB-0a;
	Wed, 14 Jun 2023 09:52:22 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9NAo-00B89c-1E;
	Wed, 14 Jun 2023 09:52:19 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686736334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8/kluo4EhxJUN1w8Wkxa+89VuHL9oMdcgH3J0LyeG0=;
	b=Az/2Llqz+IM3XCNfPKYHopkPqaXC+pwMBOIpVA+mJJHPWxSPOIY34kEAIaen1V0Ow+QlxI
	NwXssu9xAGcIJuH9pLqUTwxjEj03zgvfEssBnfsHPEPQIBpsWpsym5MYe87R56oVEK6Ppg
	so8zxD9U3nruzhrdwW2y8dBP09ZrsaczRfdum4KYj2TOgHQWqvaDr8+oKdPXE/SpaX1Vb0
	dUO9xBd0DLIueg+D6EjwtITyCleCX9eGbA0lXl1NQ8rRG3RuKc1Q695iKe085RguBbM6B1
	KehZaYHQ9WpTKOCQntKCcBydTrGOqa6dvjJFZUj8dWdUzmbM7Ell8lih0F5yrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686736334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8/kluo4EhxJUN1w8Wkxa+89VuHL9oMdcgH3J0LyeG0=;
	b=FVmcyAPxnopLQkGRCsMmFInFjSnDHkimejjG/YwNIqrUEGJ3/xx0bziZNTPs5wNfY73Etv
	rMYxWz+Vccq4JaAQ==
To: "Chang S. Bae" <chang.seok.bae@intel.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Nikolay
 Borisov <nik.borisov@suse.com>, "Ahmed S. Darwish" <darwi@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, Huacai
 Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Richard
 Henderson <richard.henderson@linaro.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>, Tom Lendacky
 <thomas.lendacky@amd.com>
Subject: Re: [patch 17/17] x86/fpu: Move FPU initialization into
 arch_cpu_finalize_init()
In-Reply-To: <23dc1c47-88ee-6b2d-1a5a-d6c812bb1761@intel.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.902376621@linutronix.de>
 <23dc1c47-88ee-6b2d-1a5a-d6c812bb1761@intel.com>
Date: Wed, 14 Jun 2023 11:52:14 +0200
Message-ID: <87o7li8j75.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_025218_564760_4847443F 
X-CRM114-Status: GOOD (  11.78  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, Jun 13 2023 at 22:03, Chang S. Bae wrote:

> On 6/13/2023 4:39 PM, Thomas Gleixner wrote:
>>   
>> @@ -2396,6 +2393,13 @@ void __init arch_cpu_finalize_init(void)
>>   			'0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
>>   	}
>>   
>> +	/*
>> +	 * Must be before alternatives because it might set or clear
>> +	 * feature bits.
>> +	 */
>> +	fpu__init_system();
>> +	fpu__init_cpu();
>
> fpu__init_cpu() appears to be duplicated here because fpu__init_system() 
> invoked this already:
>
> void __init fpu__init_system(void)
> {
> ...
> 	/*
> 	 * The FPU has to be operational for some of the
> 	 * later FPU init activities:
> 	 */
> 	fpu__init_cpu();

Well, that's _before_ xstate initialization and I couldn't convince
myself that it's good enough. All of this is such a horrible mess...

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
