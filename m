Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E3BC8302F
	for <linux-um@archiver.kernel.org>; Tue,  1 Jul 2025 00:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/NU/cotq6f4HONcmMyxBEeQIjUm7DS3sDb6SMT+k9uQ=; b=QK2Gn1ADHuW15OftU7UWi0Qx/F
	tlgKaFTKSWYRCybJhWa1ZkXx/ZwVJ/8T+cQUcszEP5Fftl1N5B2y2h9K/uBNgJjmcNfl9Ux0+sQcb
	6SVN8P7ozvVlohi3hIEDAvxwVKpExHFMPJlKg5OE6o5As505cRNlj2Y/bJqxkfarzqUW/ba+FhDUh
	dCi0H3qmIc+/Ex7zxAN7i0+wmCTIYizbHjQTKYDNpqwt3BgfxXygnvMQYWojL4R/D6rP5aDoGjfvN
	YE8g/sDL7Y1ppVlgzxo1Z95YRDPoR5LH4iKpqYP76zoyTayj1Y4w/L/LkAoehYSJ1acidixtgsDCm
	RyX18VVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWOVT-00000003iJ0-2qto;
	Tue, 01 Jul 2025 00:05:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWOVP-00000003iHM-2Ruy;
	Tue, 01 Jul 2025 00:05:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 893A344B19;
	Tue,  1 Jul 2025 00:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEDDC4CEE3;
	Tue,  1 Jul 2025 00:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1751328345;
	bh=qPg3TzNq6BpmYEZilw7ZTkiMjD24Iia3o39EQ4M66Vw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XbWONMuUrvz7T0Gq7YshVCh4gFQdvVevhuOhWKtFa8TmjgHwkc/w8ws5DNH5TGSks
	 Up2E/6UPAIGTQbT/oyMflhWrYdheKmsjDkuf1SuGhV56uHAYqrE1Pj+gCiIWQWTtKV
	 XJRP+qO/YfjkDDyNSfnZEETNqJc3s8u5cN7tglT8=
Date: Mon, 30 Jun 2025 17:05:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
 will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 arnd@arndb.de, rppt@kernel.org, geert@linux-m68k.org, mcgrof@kernel.org,
 guoweikang.kernel@gmail.com, tiwei.btw@antgroup.com, kevin.brodsky@arm.com,
 benjamin.berg@intel.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 01/11] kasan: unify static kasan_flag_enabled across
 modes
Message-Id: <20250630170542.f4da6e3908f66b822408e699@linux-foundation.org>
In-Reply-To: <aGKDhPBgDv2JjJZr@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
	<20250626153147.145312-2-snovitoll@gmail.com>
	<aGKDhPBgDv2JjJZr@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_170547_982104_448DAD49 
X-CRM114-Status: GOOD (  11.41  )
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

On Mon, 30 Jun 2025 14:31:00 +0200 Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> > +/*
> > + * Initialize Generic KASAN and enable runtime checks.
> > + * This should be called from arch kasan_init() once shadow memory is ready.
> > + */
> > +void __init kasan_init_generic(void)
> > +{
> > +	static_branch_enable(&kasan_flag_enabled);
> 
> s390 crashes at this line, when the whole series is applied.

oop.  Thanks, I'll demote this seres to the mm-new branch for now, which
takes it out of linux-next.

