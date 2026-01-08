Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57669D185FA
	for <linux-um@archiver.kernel.org>; Thu,  8 Jan 2026 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Onnwl6/+EKiyeH9xjAmodGneCE3rl2mtBrTRBmDbsI=; b=QHjjKEUrpYCDsR9q3YRgzSVyeT
	q12rmKDIzqIHH6MUYqEEIV3OTewnXVhQMCShI8PRpmOHzM2wjiM/DSk3gcum+AZftSgtHW5F/CwK+
	Ths79AoasZLF5Kv0wtU3hPdchKsL9Xq8ujvOHJ9os9cHbFguoXdTPjl/zUyq84pkBRSEssr9EyEqn
	rsULSU1pluaZQDCkwZ6aJDDk3evp0gWQYDSy34e9Mcf0QDAPzBjgDyB8ZOu0eF8xbJjOR1SRqVy+9
	1jtMfTMaVv2iRxD2D+zAzQNNevEbZ/OVOJcwj5chr3kpC8/Q/DNqjYfm6l7n+FbAlcevEKtvEjZLd
	tcnFSGKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdqDK-0000000HBrF-2NDx;
	Thu, 08 Jan 2026 13:38:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdqDI-0000000HBqN-1JSV;
	Thu, 08 Jan 2026 13:38:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8F95860131;
	Thu,  8 Jan 2026 13:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE32C116C6;
	Thu,  8 Jan 2026 13:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767879487;
	bh=VJKhVx5DGpVLVYb2XKJ8mMHhMksRI4ZPi6UFAnGjOes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKSNSmMui9b0uWXSR001Pt88qSwhYL4W2bFV32qwFJ/6CmW/Ao5TYVAY3Z+59376e
	 LGMD9MiGBnRAvJH8NMvzcia4RujNN/Ji55DA7R7FC9V5WsJbqtoAPJTAPUCr5atPUE
	 poGy32Xu92IK7Q6/R8BLK5Dfhvm0ifmZuiuV3C9vgar8FlNP1ez1Sr09T2iAeyAOsS
	 gk385QWtqNoWlz57jEfTxAmmfx4P4Mski6nsScaJkhVKadirubTC5FVXcq8viEItJc
	 1AEPIPxLDV87+Z5JZ+lhld5Il8971MVKAXSlnW8bHrCKUMYsXlt6o7qcTWAv0XBwbd
	 WP7HoXXSByWCw==
Date: Thu, 8 Jan 2026 15:37:44 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Kalle Niemi <kaleposti@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	x86@kernel.org, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 22/28] arch, mm: consolidate initialization of nodes,
 zones and memory map
Message-ID: <aV-zKGYP6EUETaQ2@kernel.org>
References: <20260102070005.65328-1-rppt@kernel.org>
 <20260102070005.65328-23-rppt@kernel.org>
 <5f9a0269-f9d5-4ee0-bf57-62148d762f7f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f9a0269-f9d5-4ee0-bf57-62148d762f7f@gmail.com>
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

Hi,

On Thu, Jan 08, 2026 at 11:24:07AM +0200, Kalle Niemi wrote:
> On 1/2/26 08:59, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> Hello,
> 
> This patch got bisected to cause BeagleBone Black boot failure in linux-next
> version next-20260107.

Can you check if this patch fixes it?

https://lore.kernel.org/all/aVpWpLV4Dut5Muo2@kernel.org/
 
> At the moment I cannot provide any helpful information about this.
> 
> BR
> Kalle

-- 
Sincerely yours,
Mike.

