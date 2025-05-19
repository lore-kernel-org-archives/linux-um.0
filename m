Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5914EC54756
	for <linux-um@archiver.kernel.org>; Mon, 19 May 2025 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=82Q3lnjfEFrzEMTrgCM5r+zlsMR9gpMlajn90gQ21MU=; b=FZmrDMZQ3kDxjmINBP4kPZ8Ijp
	8G/fn40zsQrqrS9bktisck+GBfcUanEE9co3TeRWXrPODzXgc9cwa5wLvaX1Zf5wpX5eFCkXFlxkk
	+T1FaXtf9ZkL3F2wxrzGNICQWWKYyJW5vxPEvsKapT4urPfwpX/kR2UvlS+/TytpOXRra11pZXct2
	tNzaeDQBTW682lM9fMZQ8G2MiTKqvCV6R0e8L8jbMxXGdauPjG17B1at8jJnfNWfYdpXZN4ezm4Gs
	cLpy/c/tNII9TjsuPd2dqnp/A+aAC2zdu53e18Xa1Lixf+FazUubw6vOc++JvQMEQIoxYBBmbO8eE
	YqdSBf/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH4qN-0000000A4Zt-3E1i;
	Mon, 19 May 2025 18:04:07 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH49q-00000009wrU-2WTC;
	Mon, 19 May 2025 17:20:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 984855C5516;
	Mon, 19 May 2025 17:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0486C4CEE4;
	Mon, 19 May 2025 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747675208;
	bh=/qDPGAJe6QWZQRFh5mkIaN3rUECBPrvhVDophOu0STQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nv6a6o/9GXqFce+WdqziKMZrgOnXd14Xk3g4S1nNlUHZltfdV2rEB9RDQCOmCeSgK
	 ebQsjcpfmgR6sWVWBw5dta/I6m1xLYkae6rTJ4OSb859vEywgddyloj50eaFEjRTPe
	 8FJ2qDU6rfYPGiDk1ORLqVzTGk/lQ8qlSrYclPnaRHuqKyuUafe4DFZ6lMgRdY6Wt1
	 dRptEgZtQ8qGZDrQUwGD8JbkbioWwAY9aSpa8iIJWxNVsecoqluy1Xci9uIALX28U6
	 ObnLi7IgFlid4DAXOMe7kw3cQbAB55J7ruXkv/fKErQRWuv0MXWPHfuo3pZS732DBZ
	 yyZPReh2t/BVw==
Date: Mon, 19 May 2025 20:19:48 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
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
	Mark Brown <broonie@kernel.org>, Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Praveen Kumar <pravkmr@amazon.de>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 10/13] arch, mm: set high_memory in free_area_init()
Message-ID: <aCtoNLf1FbtqijGr@kernel.org>
References: <20250313135003.836600-1-rppt@kernel.org>
 <20250313135003.836600-11-rppt@kernel.org>
 <mafs05xi0o9ri.fsf@amazon.de>
 <aCdveN2w9ThjVhae@kernel.org>
 <dc4e60dc-9b78-473a-9c18-3a2f128a02d2@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc4e60dc-9b78-473a-9c18-3a2f128a02d2@ghiti.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_102010_750718_9EBB6E1D 
X-CRM114-Status: GOOD (  13.70  )
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

Hi Alexandre,

On Mon, May 19, 2025 at 05:54:23PM +0200, Alexandre Ghiti wrote:
> Hi Mike,
> 
> I encountered the same error as Pratyush and the above diff fixes it: do you
> plan on sending this fix for 6.15?
> 
> If so, you can add:
> 
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!
Here's the patch:
https://lore.kernel.org/linux-mm/20250519171805.1288393-1-rppt@kernel.org

> Thanks,
> Alex

-- 
Sincerely yours,
Mike.

