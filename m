Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E60CC83F22
	for <linux-um@archiver.kernel.org>; Wed, 16 Jul 2025 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j/rIFur3u1rTJo3mQ89YHapN8kPR0kc82DFGfxLgJOY=; b=W+qPy3DAveCTQlgatWFPehRuGv
	ztzUxl/p6B+9oAz0gsDbHivqoimqunwBriTBtNM3gias/Y9ZVFBI2Mw/r1mOFh3IkornRHt2Ielp3
	Ef3FlzI3dcpgXpU2re2f5J+GFegDO7xf+7i/S4Bch3zCgbQ96yCpBMi0bRpgpsZnMCYVfwcw00Pir
	C3m2pkq8AWR6GYrctP/2dDwCAZEGtWBL4WKqwKCdmK7S05u15G6F/cxnZP08XY+hRxgIkEsMMvLlF
	7Sh2Kz/fQsd4ExALHp9I+8Lwn0JI5fCyksiYvHcYjq4WClfqQeS65KYsfLURQYMNUac7mAw9FZbMs
	od1cj2jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc6UP-00000008M0o-1f7o;
	Wed, 16 Jul 2025 18:04:21 +0000
Received: from pandora.armlinux.org.uk ([2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc6PH-00000008LQO-0Zge;
	Wed, 16 Jul 2025 17:59:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j/rIFur3u1rTJo3mQ89YHapN8kPR0kc82DFGfxLgJOY=; b=nRf9s6BLgyLZd19Zq0n8/XzeaT
	LdIYLNiW4z4oi4MA3w2BCBek25oSOrhZ8XcpzyleTM/5SuM2dnCE8X2IN1fY4XF02MN0u0o/w7o+/
	BXK5tT7Nngm6VEQKAzarLu64KjC1zHm0osARGnNBRaSOJzAQTBVqTSgVCUR5io769aa33pkqg0Klq
	UjjCl8EoyWky+K3kmjxhwmz+159ClWBAoAk+GeDtMb/6pA/oHGkodOfSrEn4YCwUGtQ02pz9D/Oym
	S4R+vEsvs+G9YBBJckDetnAWXJTk+T1i0vJw0SDz0Cd6j6QJIV/W8Xmfday5WtRq/NdxL7Nikft3h
	+JKcvcMg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49400)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uc6Nh-0008HA-0J;
	Wed, 16 Jul 2025 18:57:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uc6NT-0001JC-1H;
	Wed, 16 Jul 2025 18:57:11 +0100
Date: Wed, 16 Jul 2025 18:57:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.osdn.me>, Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-arch@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH 1/1] uapi/termios: remove struct ktermios from uapi
 headers
Message-ID: <aHfn9z9_oIVgNGgx@shell.armlinux.org.uk>
References: <20250716164735.170713-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716164735.170713-1-hpa@zytor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250716_105903_170377_FA78EBE3 
X-CRM114-Status: GOOD (  11.43  )
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

On Wed, Jul 16, 2025 at 09:47:32AM -0700, H. Peter Anvin wrote:
> diff --git a/arch/arm/include/asm/ktermios.h b/arch/arm/include/asm/ktermios.h
> new file mode 100644
> index 000000000000..4320921a82a9
> --- /dev/null
> +++ b/arch/arm/include/asm/ktermios.h
> @@ -0,0 +1 @@
> +#include <asm-generic/ktermios.h>

Isn't this what arch/arm/include/asm/Kbuild's generic-y is for?

Ditto for other arches.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

