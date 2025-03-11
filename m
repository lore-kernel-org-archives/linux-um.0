Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6BDC28B30
	for <linux-um@archiver.kernel.org>; Tue, 11 Mar 2025 22:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LWqJoM88kHGjOcIG7y4jtQUycMU0Xkkz6/jQHA0YJWI=; b=da8lkVTt34i7vMeQlt8v6fluJm
	VLfOpyjDHHh/TVcNNRbaRzgWDz9DxJw+cFS3Ju5TsUUbTDY5Jlkdho5PxLoKHLTC6cGJEtPlbmHVi
	gVMW6nN7kZJU1gDbZCypVB7h7Vr6xvs3NWD7EpgemBkZWnsehgAxS76Vz6zvTozm/pXydpU4WTgqr
	f856gnkOv9rmca+kZHckC595f2Z2vFTSI79bpFtHzkUMjZCKZyc0uD49fMxqlV/MNYwvToWalGU4h
	eXZiOXTI8XsosK6Vt26qKY8F68acYGzD6L/3VMh4GV5ybgP4UPqpdyK9FQut16AGGM5kX4IzDPXp2
	5ARIxCDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ts7eC-000000073mp-3OPO;
	Tue, 11 Mar 2025 22:00:24 +0000
Received: from pandora.armlinux.org.uk ([2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ts7e9-000000073lS-15Yq;
	Tue, 11 Mar 2025 22:00:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LWqJoM88kHGjOcIG7y4jtQUycMU0Xkkz6/jQHA0YJWI=; b=F1O49JcdrryD+c7bjEti6SJD0k
	5m7yB4f0mnO5oz3PWpTGFZeEDOz6jtfbEDUSGHdJuMJUdyyJrvc8w+axXtk6TDmTIIbFbkuO1ydxZ
	ZkUVQwkCQYx3t/GvJXd0N89ERqlBZ1oyV/qsqt5n8bhxYILHdPBMEdtZh+E3rV1O6LTEgz6NY19dX
	uMkm10gBWDJvLQbGsJ+OV21R+sYmoK2kOuMEJxHVPH/5fNpWBs+wMK5IxvFr7yXp1/8ISm8hB2ZeX
	FrHvjmC4OQ8J8YC0afIQJre6b+7hqinDLiAbLbux5CbnHbe0gdh4CpCr9WT+96+4aXVFDLO7rTs/o
	DeeyVT7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55314)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ts7dT-0004fB-2A;
	Tue, 11 Mar 2025 21:59:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ts7dN-0003qv-0O;
	Tue, 11 Mar 2025 21:59:33 +0000
Date: Tue, 11 Mar 2025 21:59:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mark Brown <broonie@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 10/13] arch, mm: set high_memory in free_area_init()
Message-ID: <Z9CyRHewqfZlmgIo@shell.armlinux.org.uk>
References: <20250306185124.3147510-1-rppt@kernel.org>
 <20250306185124.3147510-11-rppt@kernel.org>
 <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_150021_292205_914B824F 
X-CRM114-Status: GOOD (  22.25  )
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

On Tue, Mar 11, 2025 at 05:51:06PM +0000, Mark Brown wrote:
> On Thu, Mar 06, 2025 at 08:51:20PM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > high_memory defines upper bound on the directly mapped memory.
> > This bound is defined by the beginning of ZONE_HIGHMEM when a system has
> > high memory and by the end of memory otherwise.
> > 
> > All this is known to generic memory management initialization code that
> > can set high_memory while initializing core mm structures.
> > 
> > Remove per-architecture calculation of high_memory and add a generic
> > version to free_area_init().
> 
> This patch appears to be causing breakage on a number of 32 bit arm
> platforms, including qemu's virt-2.11,gic-version=3.  Affected platforms
> die on boot with no output, a bisect with qemu points at this commit and
> those for physical platforms appear to be converging on the same place.

I'm not convinced that the old and the new code is doing the same
thing.

The new code:

+       phys_addr_t highmem = memblock_end_of_DRAM();
+
+#ifdef CONFIG_HIGHMEM
+       unsigned long pfn = arch_zone_lowest_possible_pfn[ZONE_HIGHMEM];
+
+       if (arch_has_descending_max_zone_pfns() || highmem > PFN_PHYS(pfn))
+               highmem = PFN_PHYS(pfn);
+#endif
+
+       high_memory = phys_to_virt(highmem - 1) + 1;

First, when CONFIG_HIGHMEM is disabled, this code assumes that the last
byte of DRAM declared to memblock is the highmem limit. This _could_
overflow phys_to_virt() and lead to an invalid value for high_memory.

Second, arch_zone_lowest_possible_pfn[ZONE_HIGHMEM] is the _start_ of
highmem. This is not what arch code sets high_memory to - because
the start of highmem may not contiguously follow on from lowmem.

In arch/arm/mm/mmu.c, lowmem_limit is computed to be the highest + 1
physical address that lowmem can possibly be, taking into account the
amount of vmalloc memory that is required. This is used to set
high_memory.

We also limit the amount of usable RAM via memblock_set_current_limit()
which memblock_end_of_DRAM() doesn't respect.

I don't think the proposed generic version is suitable for 32-bit arm.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

