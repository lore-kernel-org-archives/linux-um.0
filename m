Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7810FE7718D
	for <linux-um@archiver.kernel.org>; Sun, 22 Dec 2024 05:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=73Spy65y75EOyPTSc0iJv9YfbS1W2aMnBGueFT4LSeE=; b=jrIVzNuuD9+z9acYPn8Fbd0OXj
	eiKJ98A2WaiVFniA3eQUfgfmuRGvzgeOqO+wbyvRuOutH2muzBJW0hHhYOtIBnA5QhbeAAegDdOo0
	tC4/kdJ6NPHyFV29oBtyWUAjNcZ09IJKgOGB8sv5GOWdQCQ+Yjzdto0XeKjUFG8ckxaVqx2LpgqHI
	ZLxsDE5bc9oPK92s9xAwYOMuHKH2iY/VdYRVcNsl7UcdZCUtaeKC69R4MxbISYoRoQ2b5jkTyA5n6
	+75lN00wWKimBOv7VEop0YY8jGogbf7VghjF34R1+Y5MqK8hP6STgWtO1XEcJ4Hdsevjds3ohZvL9
	RD/SSf+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPEsS-00000007rjK-09L7;
	Sun, 22 Dec 2024 05:51:44 +0000
Received: from xry111.site ([89.208.246.23])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPEsO-00000007ri6-3AjU;
	Sun, 22 Dec 2024 05:51:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1734846684;
	bh=73Spy65y75EOyPTSc0iJv9YfbS1W2aMnBGueFT4LSeE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nZcUQW1TlcYe19vjpWVYF7BGYQbKeGDAvUbN+K0Gsvt9rhGMN7GsZfs/zdpj2lzl1
	 MbBsClXT3mJifINJ7gn7htQxIFD/roKSs0ciA+vaO6anVxMZbCRqy5Nv6Ocs9F+wxn
	 hZMWv9smlpVCNBPl3ehSuaSPQ+cU8zGg2WHY6b7I=
Received: from [192.168.124.9] (unknown [113.200.174.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 16E7F1A3FB1;
	Sun, 22 Dec 2024 00:51:09 -0500 (EST)
Message-ID: <02d042a6590ddb1fadb9f98d95de169c4683b9e7.camel@xry111.site>
Subject: Re: [PATCH v6] mm/memblock: Add memblock_alloc_or_panic interface
From: Xi Ruoyao <xry111@xry111.site>
To: Guo Weikang <guoweikang.kernel@gmail.com>, Andrew Morton
	 <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph
 Lameter <cl@linux.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sam Creasey	 <sammy@sammy.net>, Huacai Chen <chenhuacai@kernel.org>, Will
 Deacon	 <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Oreoluwa Babatunde <quic_obabatun@quicinc.com>, rafael.j.wysocki@intel.com,
 Palmer Dabbelt <palmer@rivosinc.com>,  Hanjun Guo <guohanjun@huawei.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>, Johannes Berg	
 <johannes.berg@intel.com>, Ingo Molnar <mingo@kernel.org>, Dave Hansen	
 <dave.hansen@intel.com>, Christian Brauner <brauner@kernel.org>, KP Singh	
 <kpsingh@kernel.org>, Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>,
 WANG Xuerui <kernel@xen0n.name>,  Michael Ellerman <mpe@ellerman.id.au>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne	
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
Date: Sun, 22 Dec 2024 13:51:08 +0800
In-Reply-To: <20241222054331.2705948-1-guoweikang.kernel@gmail.com>
References: <20241222054331.2705948-1-guoweikang.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241221_215140_822628_FA517A4F 
X-CRM114-Status: UNSURE (   8.09  )
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

On Sun, 2024-12-22 at 13:43 +0800, Guo Weikang wrote:
> Before SLUB initialization, various subsystems used memblock_alloc to
> allocate memory. In most cases, when memory allocation fails, an immediat=
e
> panic is required. To simplify this behavior and reduce repetitive checks=
,
> introduce `memblock_alloc_or_panic`. This function ensures that memory
> allocation failures result in a panic automatically, improving code
> readability and consistency across subsystems that require this behavior.
>=20
> Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
> ---


Please try to avoid bumping the patch revision number so quickly.

And if you must do it, you should embed a ChangeLog of your patch (below
this "---" line) so people can know what has been changed.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

