Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D01E7718D
	for <linux-um@archiver.kernel.org>; Mon, 23 Dec 2024 07:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ecGpjQJ+dPTMtl9IS6T8Zx3DPG9sUHrYzmuZ6ugsSWw=; b=MCO7OTcR2VtCfju/yoB4r995qq
	Pn5ShOMlaxsl+jpgObS5kGk+Poa/qio3L63tl+H+Zc3PZxG7rBVeJ8XttfoQbjYG+Na/UTImnNQC/
	Y+8ftCi1CPrPqBsUfadZttXsQz9l8D11YmB4YxmPwwGic/38Ubq7U3BTQPqF9o8y3jc3h86Mqzyce
	FkIuaJChQ2rY/RuGursdLpTuSsYA9MFS3yKCV/NtXRxXeUM0dLpU8SnW+TzSVouBeH67GJ3Bl74vn
	VEZp9Gdp1J2yF5adEZxyCc51mqVYAjVs3908IKOMRWWdO8JlxV3GCXLyrEar1Ix59X9TfDDjuBa4J
	EdBeE1Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPcfp-00000009VKV-0dtF;
	Mon, 23 Dec 2024 07:16:17 +0000
Received: from xry111.site ([89.208.246.23])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPcfl-00000009VJ2-2n4k;
	Mon, 23 Dec 2024 07:16:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1734938153;
	bh=ecGpjQJ+dPTMtl9IS6T8Zx3DPG9sUHrYzmuZ6ugsSWw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dYLhBandMXiOWoijdab1gHiwxN4eR/VOe1BsVjVz9qXmRVOFQ3esRLy431bdS1dZk
	 XfvgNo/mfzBUiJSkzYWjXUz9VNZqGIoxmAEmuMRQld4Umwy3a2m4Fwo8gIpR4U1JmC
	 QNQagNSSgXTyOhRij3RWOWxKAWCl+3mSvRV2S1v8=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 1944F67671;
	Mon, 23 Dec 2024 02:15:35 -0500 (EST)
Message-ID: <6ac0e0f71990e5a8dc52f00c737cdf56916e0d4e.camel@xry111.site>
Subject: Re: [PATCH v7] mm/memblock: Add memblock_alloc_or_panic interface
From: Xi Ruoyao <xry111@xry111.site>
To: Mike Rapoport <rppt@kernel.org>, Guo Weikang
 <guoweikang.kernel@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven	
 <geert@linux-m68k.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo
 <tj@kernel.org>,  Christoph Lameter	 <cl@linux.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Sam Creasey	 <sammy@sammy.net>, Huacai Chen
 <chenhuacai@kernel.org>, Will Deacon	 <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
 rafael.j.wysocki@intel.com, Palmer Dabbelt <palmer@rivosinc.com>,  Hanjun
 Guo <guohanjun@huawei.com>, Easwar Hariharan
 <eahariha@linux.microsoft.com>, Johannes Berg	 <johannes.berg@intel.com>,
 Ingo Molnar <mingo@kernel.org>, Dave Hansen	 <dave.hansen@intel.com>,
 Christian Brauner <brauner@kernel.org>, KP Singh	 <kpsingh@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, Matt Turner
 <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, WANG Xuerui
 <kernel@xen0n.name>,  Michael Ellerman <mpe@ellerman.id.au>, Stefan
 Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne	
 <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Nicholas Piggin	
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen
 N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Geoff
 Levand	 <geoff@infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt	 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrey Ryabinin	 <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino	 <vincenzo.frascino@arm.com>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik	 <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Yoshinori
 Sato	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John
 Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson
 <andreas@gaisler.com>, Richard Weinberger	 <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg	
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar	 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen	
 <dave.hansen@linux.intel.com>, x86@kernel.org, linux-alpha@vger.kernel.org,
 	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, kasan-dev@googlegroups.com, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, 	linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 linux-omap@vger.kernel.org, 	linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mm@kvack.org, 	linux-pm@vger.kernel.org
Date: Mon, 23 Dec 2024 15:15:34 +0800
In-Reply-To: <Z2kNTjO8hXzN66bX@kernel.org>
References: <20241222111537.2720303-1-guoweikang.kernel@gmail.com>
	 <Z2kNTjO8hXzN66bX@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241222_231613_732765_B26F4318 
X-CRM114-Status: GOOD (  16.27  )
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

On Mon, 2024-12-23 at 09:12 +0200, Mike Rapoport wrote:
> On Sun, Dec 22, 2024 at 07:15:37PM +0800, Guo Weikang wrote:
> > Before SLUB initialization, various subsystems used memblock_alloc to
> > allocate memory. In most cases, when memory allocation fails, an immedi=
ate
> > panic is required. To simplify this behavior and reduce repetitive chec=
ks,
> > introduce `memblock_alloc_or_panic`. This function ensures that memory
> > allocation failures result in a panic automatically, improving code
> > readability and consistency across subsystems that require this behavio=
r.
> >=20
> > Changelog:
> > ----------
> > v1: initial version
> > v2: add __memblock_alloc_or_panic support panic output caller
> > v3: panic output phys_addr_t use printk's %pap
> > v4: make __memblock_alloc_or_panic out-of-line, move to memblock.c
> > v6: Fix CI compile error
> > Links to CI: https://lore.kernel.org/oe-kbuild-all/202412221000.r1NzXJU=
O-lkp@intel.com/
> > v6: Fix CI compile warinigs
> > Links to CI: https://lore.kernel.org/oe-kbuild-all/202412221259.JuGNAUC=
q-lkp@intel.com/
> > v7: add chagelog and adjust function declaration alignment format
> > ----------
> >=20
> > Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
> > Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Acked-by: Xi Ruoyao <xry111@xry111.site>
>=20
> If people commented on your patch it does not mean you should add
> Reviewed-by or Acked-by tags for them. Wait for explicit tags from the
> reviewers.

And:

 - Acked-by: indicates an agreement by another developer (often a
   maintainer of the relevant code) that the patch is appropriate for
   inclusion into the kernel.=20

I'm not a maintainer so I even don't have the right to use Acked-by :).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

