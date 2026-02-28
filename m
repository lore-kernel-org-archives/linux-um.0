Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46045FEE4C4
	for <linux-um@archiver.kernel.org>; Sat, 28 Feb 2026 04:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y3L+qGVzTsCJQnoG5TCi8Lc0DlEfyMFXUAiYCFvEtfs=; b=iYANKaUj5PBiuDHIbVpbJnVP+9
	nXSECYW1QCnY61eQC3Gdu6++vqRFxRFucqGp2LvsPJbDmra8uo3TGszb/Yt/Wy+tfDUdh+M1QZxhS
	KjiWc7Ht8YVcdwDg/hNwVFaIUnWk4hZ4XNbHlIeT50EYXuM8m1/zwJCJu9ytfYfj7Q0AVmqZJqegF
	FUJswyl/HGSlsiMCz/cv5EN0tWD4GkBAhftUHylBDhLcUsjFQSW7OVXvQr4Qw9pOHCmBgJdQMvJR9
	bEcFExxUiOFyRXW96W9pjNYeDuLib+EGTNnEwxs6nEhtgBwv+t2FoY0zgO0D97O+ODEzodn+SVogj
	mIk+mzOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwC9L-00000009UeV-1hVz;
	Sat, 28 Feb 2026 04:41:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwC9G-00000009Ue3-0QZ4;
	Sat, 28 Feb 2026 04:41:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F247640067;
	Sat, 28 Feb 2026 04:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A79C116D0;
	Sat, 28 Feb 2026 04:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772253708;
	bh=GTl5b4pj52hP0KVBkFlgMlumLNdyDtznBRe/1mAWWQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOKkIgOdBSzVWSzHxw5DOhxNn03a0Ygaw1woVlTjin4KLowyLELOm+OVhIowZs3Mi
	 dqJMT1De+b8BARm6gDQusg4IahSRzGUQaRpIL79MWyistCvbIiMZ6GQa64miu3ZcRZ
	 cmMCGr06kdASJAnWQFN5T5HEhrn2CSG3d0wt7lfBrAFCfHwD8AHIT6zDjcjgyWpudZ
	 1T16tuC8Ef/5l0VtYfOtBa3/4cAwxmH1U8wP9gZSK6LcugatbAZqq7cuamim+FKLGl
	 QGX36uRgBg/t7BIN5Yg+65x2RyzeJ36b/t9uuoaV9NMPtIM82r7BkkP953pZJg4x7P
	 1Tdp6OJiWNiZw==
Date: Fri, 27 Feb 2026 20:41:43 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 06/25] xor: cleanup registration and probing
Message-ID: <20260228044143.GC65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-7-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_204152_121694_9D25AF9D 
X-CRM114-Status: UNSURE (   9.97  )
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

On Thu, Feb 26, 2026 at 07:10:18AM -0800, Christoph Hellwig wrote:
>  /* Set of all registered templates.  */
>  static struct xor_block_template *__initdata template_list;
> +static int __initdata xor_forced = false;

bool instead of int

>  	b1 = (void *) __get_free_pages(GFP_KERNEL, 2);
>  	if (!b1) {
> -		printk(KERN_WARNING "xor: Yikes!  No memory available.\n");
> +		pr_info("xor: Yikes!  No memory available.\n");

pr_warn() instead of pr_info()

- Eric

