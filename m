Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FA8EFCE4D
	for <linux-um@archiver.kernel.org>; Thu,  5 Mar 2026 00:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ADx2RpP+mm1y1LiRTs4S1QSiTNxoV3tLrVytq4DK3g=; b=LcV0JOjT9i6Xcyi6YPdlMHV7mL
	YlgxJyukquranZ61SdjgvnDtshCWRwV5Tg2VeL8fCZ65nf3/dy+JkgWWbk3qVltmFgoOblyaYmrBl
	HXSWVAll4Cp+TN774O69WBbDTphVv1WcBh00I/zW4tVWq11/nJdxfSZ6AXO5jf/RemEyGg1IiUaQB
	jgvPKbh/3xIFx/92GmV1NHIH2FVJ8viTie2B1Qcwc58oFoCkR4Ue1vLfbWamLdK878LWzPIxzPt6Q
	D2iwjOqolnfJK9WhVkXiMkgKjMf+tOAOxGsJ2MAKbJfTQMbJQs6/rF8/q6us+9FB7W1BbGR5993bc
	6V3fn0CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxwht-00000000huv-3cUf;
	Thu, 05 Mar 2026 00:36:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxwhq-00000000hu0-1McT;
	Thu, 05 Mar 2026 00:36:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D54F2403ED;
	Thu,  5 Mar 2026 00:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C0CC4CEF7;
	Thu,  5 Mar 2026 00:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772671004;
	bh=dufxbUIyr7d8ExFT8JscxBc90VyX6BXpvMXaMHirGFY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KToGiCmvRjrVNqFH9bmGJHeZ38P88LzG7roLZL+LfIaWcpEiN2r+2cd8LeoKKP35z
	 U1kZMnp2GF5lnZ/nU+B3HGi0hmJYpifkPnaIttjOzC0p4MJWgdE7whcAtStb71A/hR
	 PWMEoeZUETbXXgqKLd947UqscZTCqE7PdSGVXWHEJVzdsA5P/GL+TYntigcrzmPu9S
	 bwFDNJowrmaquHt0GQepYaacF/aqErDIPLaR1+ZJBBxnDoRwltgCLkyg6X/do1S70f
	 /t3wS/hkSXMAn5Ptc3L2X59NGkKMvuLeUJNxpcdH9xAkM1JdLfqBeN7u7tjz5Udo9K
	 2yvhogx3J8MSA==
From: Nathan Chancellor <nathan@kernel.org>
To: Nicolas Schier <nsc@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Vineet Gupta <vgupta@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Sam Creasey <sammy@sammy.net>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Masahiro Yamada <masahiroy@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org, 
 stable@vger.kernel.org, Ed W <lists@wildgooses.com>
In-Reply-To: <20260225-separate-modinfo-from-elf-details-v1-1-387ced6baf4b@kernel.org>
References: <20260225-separate-modinfo-from-elf-details-v1-1-387ced6baf4b@kernel.org>
Subject: Re: [PATCH] kbuild: Split .modinfo out from ELF_DETAILS
Message-Id: <177267099220.1730256.13119170390082704508.b4-ty@kernel.org>
Date: Wed, 04 Mar 2026 17:36:32 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_163646_411626_4EA18CE8 
X-CRM114-Status: GOOD (  10.04  )
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

On Wed, 25 Feb 2026 15:02:51 -0700, Nathan Chancellor wrote:
> Commit 3e86e4d74c04 ("kbuild: keep .modinfo section in
> vmlinux.unstripped") added .modinfo to ELF_DETAILS while removing it
> from DISCARDS, as it was needed in vmlinux.unstripped and ELF_DETAILS
> was present in all architecture specific vmlinux linker scripts. While
> this shuffle is fine for vmlinux, ELF_DETAILS and DISCARDS may be used
> by other linker scripts, such as the s390 and x86 compressed boot
> images, which may not expect to have a modinfo section. In certain
> circumstances, this could result in a bootloader failing to load the
> compressed kernel [1].
> 
> [...]

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git kbuild-fixes

Thanks!

[1/1] kbuild: Split .modinfo out from ELF_DETAILS
      https://git.kernel.org/kbuild/c/8678591b47469

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted. Patches applied to an "unstable" branch are accepted pending
wider testing in -next and any post-commit review; they will generally
be moved to the main branch in a week if no issues are found.

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


