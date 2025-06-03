Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AFDC5AE59
	for <linux-um@archiver.kernel.org>; Tue,  3 Jun 2025 12:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r0f0rDdQI9JtcODUz8UbT4rs2Gv29SPYkIxKjn9q+Vk=; b=myZTmYXO8MoqF9+kkGcxUAYxxW
	CYS+fJk1wgDVdH4f7kCcdtjCYrz3vQaTYp5HhCtxBPrRGgsjfXrr7hMgEll+TWFu4rGO30euwW7az
	/+a1Ejwy2+P5FRm0XS9alqtpeDGoFSnDRjl3zgnD3jtlmJrmGRnhC6bAu5C8tD9r0jPHQbBX7T+eP
	4d8RR92jCwZ3TJKR9/m3pdvB8Ftwh1deA7qdOxrF6CSJVMqeHa/6AM6xvcp2BDxnaKEJZeDsVz09G
	LPK8z346lSbd0JmKyMp+65+bDp7MvfkuzaOZJVO8Dm+T84uampLHtNDCHMa4TxBopR2CV3YkjNjBV
	ArU4/D4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMREW-0000000AyXc-1TRF;
	Tue, 03 Jun 2025 12:59:12 +0000
Received: from out-177.mta0.migadu.com ([2001:41d0:1004:224b::b1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMRET-0000000AyVQ-0IhG;
	Tue, 03 Jun 2025 12:59:10 +0000
Date: Tue, 3 Jun 2025 14:58:47 +0200
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andreas Larsson <andreas@gaisler.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chris Zankel <chris@zankel.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonas Bonn <jonas@southpole.se>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rich Felker <dalias@libc.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/2] arch: use always-$(KBUILD_BUILTIN) for vmlinux.lds
Message-ID: <20250603-sturdy-gaur-of-security-7effbb@l-nschier-aarch64>
References: <20250602181256.529033-1-masahiroy@kernel.org>
 <20250602181256.529033-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250602181256.529033-2-masahiroy@kernel.org>
Organization: AVM GmbH
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250603_055909_243231_B0C1203F 
X-CRM114-Status: UNSURE (   9.29  )
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

On Tue, Jun 03, 2025 at 03:12:54AM +0900, Masahiro Yamada wrote:
> The extra-y syntax is deprecated. Instead, use always-$(KBUILD_BUILTIN),
> which behaves equivalently.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  arch/alpha/kernel/Makefile      | 2 +-
>  arch/arc/kernel/Makefile        | 2 +-
>  arch/arm/kernel/Makefile        | 2 +-
>  arch/arm64/kernel/Makefile      | 2 +-
>  arch/csky/kernel/Makefile       | 2 +-
>  arch/hexagon/kernel/Makefile    | 2 +-
>  arch/loongarch/kernel/Makefile  | 2 +-
>  arch/m68k/kernel/Makefile       | 2 +-
>  arch/microblaze/kernel/Makefile | 2 +-
>  arch/mips/kernel/Makefile       | 2 +-
>  arch/nios2/kernel/Makefile      | 2 +-
>  arch/openrisc/kernel/Makefile   | 2 +-
>  arch/parisc/kernel/Makefile     | 2 +-
>  arch/powerpc/kernel/Makefile    | 2 +-
>  arch/riscv/kernel/Makefile      | 2 +-
>  arch/s390/kernel/Makefile       | 2 +-
>  arch/sh/kernel/Makefile         | 2 +-
>  arch/sparc/kernel/Makefile      | 2 +-
>  arch/um/kernel/Makefile         | 2 +-
>  arch/x86/kernel/Makefile        | 2 +-
>  arch/xtensa/kernel/Makefile     | 2 +-
>  21 files changed, 21 insertions(+), 21 deletions(-)
>=20

Reviewed-by: Nicolas Schier <n.schier@avm.de>

