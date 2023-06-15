Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE09EB64D9
	for <linux-um@archiver.kernel.org>; Thu, 15 Jun 2023 22:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ewpkaWWMWZLCtEkBcV4mIjA0FBfoLN7zIdZTvBENv2o=; b=RhlwckQlZrfV2c
	xJPERqnKKr942nAPKI9X1FVmf9TnU0CN91MfJjfZ2v+TkZiiN+BMiwDb0VX5xMxnwQCIIZwJLKF7v
	+QXo15JESrJxkf1dtsivEB8+pyRdLB8rFREYvv9RUcm10em3vAvxfrCVcIx+Qk4H7TLV+JDgDq7Ed
	0+scGm6IBasMBjxJehDw6gAzH3597PhdzsuRFRAEFOXSvvJwR42qHZtfowkjB7O6wosKTOIqvnwZg
	Sj870dqMpkFpFULoJpvb+6aSUgPdROL6y3/DopI81c/F4265BdADMHWtk407jC5qcbvCafMWRsWVL
	J6r6GqA86GGm0fx72Djw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9v4D-00GCsu-0x;
	Thu, 15 Jun 2023 22:03:45 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9v4A-00GCqW-00;
	Thu, 15 Jun 2023 22:03:43 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686866611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WePTMyE45qwE++8TRrjkwtysmPUcOS3LgW/k38AkuSI=;
	b=BFrLebSkFNVOCzT2IpgGiJ0Pvwl4C6rJQWMOuiT+63wINu33JzO78MU9TYGFMlnWUXyAUh
	Xhk4wm8ZUtG+W8XJ1HYlTbHql0VJge25Ax5kGvVg+m6ndfrxbxGCAKdspD5x5j4TmDVxGW
	hz23M3Hz+IqqiDWtpbQps8Ylv0FhHNkVJiImy19cXSnE3P8f2RAAZmjZTovqVh5T0zERE4
	P/0Lx/U4+CDx5K5TMi5xFn2XRxKyjm/1lX7z1RJvE4XZO349M91G/jWdnDwbBd8z42Bqhr
	R8YBEF4GMDQ+PIIUcGwC4fRAq2j8jxS43fkmJxExYShf33Zc0q093qDMYhFKxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686866611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WePTMyE45qwE++8TRrjkwtysmPUcOS3LgW/k38AkuSI=;
	b=6iNPBBEFXbFtS5Ao2dawxcNVDyr/qHhbmKNIDyn3HuL1jxxTrLdZSnDkEAT/K1svJmXSNt
	QPnvP4lcgbb0l9Ag==
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "chenhuacai@kernel.org" <chenhuacai@kernel.org>, "darwi@linutronix.de"
 <darwi@linutronix.de>, "linux-ia64@vger.kernel.org"
 <linux-ia64@vger.kernel.org>, "glaubitz@physik.fu-berlin.de"
 <glaubitz@physik.fu-berlin.de>, "Torvalds, Linus"
 <torvalds@linux-foundation.org>, "chris@zankel.net" <chris@zankel.net>,
 "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
 "davem@davemloft.net" <davem@davemloft.net>, "thomas.lendacky@amd.com"
 <thomas.lendacky@amd.com>, "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>, "mpe@ellerman.id.au"
 <mpe@ellerman.id.au>, "kernel@xen0n.name" <kernel@xen0n.name>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "dalias@libc.org"
 <dalias@libc.org>, "loongarch@lists.linux.dev"
 <loongarch@lists.linux.dev>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "linux-m68k@lists.linux-m68k.org"
 <linux-m68k@lists.linux-m68k.org>, "nik.borisov@suse.com"
 <nik.borisov@suse.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "richard@nod.at" <richard@nod.at>, "johannes@sipsolutions.net"
 <johannes@sipsolutions.net>, "linux-um@lists.infradead.org"
 <linux-um@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "tsbogend@alpha.franken.de"
 <tsbogend@alpha.franken.de>, "linux-mips@vger.kernel.org"
 <linux-mips@vger.kernel.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "geert@linux-m68k.org"
 <geert@linux-m68k.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [patch 12/17] init: Invoke arch_cpu_finalize_init() earlier
In-Reply-To: <b0be67b75d1c3f6b0e98b46a56b8588b9b9e4b2a.camel@intel.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.612182854@linutronix.de>
 <b0be67b75d1c3f6b0e98b46a56b8588b9b9e4b2a.camel@intel.com>
Date: Fri, 16 Jun 2023 00:03:30 +0200
Message-ID: <87sfas758t.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_150342_177610_846CB0F0 
X-CRM114-Status: UNSURE (   9.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, Jun 15 2023 at 21:44, Rick P. Edgecombe wrote:
> On Wed, 2023-06-14 at 01:39 +0200, Thomas Gleixner wrote:
>> Fortunately none of the init calls between calibrate_delay() and
>> arch_cpu_finalize_init() is relevant for the functionality of
>> arch_cpu_finalize_init().
>> 
>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>
> I did my best to find a counterpoint to this statement. The only thing
> I found was that lockdep_init_task(&init_task) in fork_init() is now
> called after the spin_lock() usage in set_memory_4k().
>
> But AFAICT, that whole lockdep_init_task() call is unneeded because
> the fields it sets are already statically initialized.

Correct. The call there looks absolute pointless. Peter?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
