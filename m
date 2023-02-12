Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D45AC05027
	for <linux-um@archiver.kernel.org>; Sun, 12 Feb 2023 16:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8+NP61fhjfY1LmjPzd5k61AzrGGIwYTsbHT93TAZYwM=; b=VITLbAJz9264FH
	OTCcSxQoj2Pna60KLZeClRqvvl9hNI1qyobDY6Kr6mPqIk0FUw1iWdWlg1MVb1mO2Y9ud6Vp0bG0W
	EZklexBsfR8a6xLA676J7EU6djKNx13WlcnSoQdzqDiiJQqg3iOPOehKzkQRJQcNRJSVdvxej7BPD
	f0h5f85VxIdha4cE+51nYbCtqEa6U6sqY3LQ9pgG/GhgmNP2wGHAnkNTKJrbRv3RB1IxfFV84TKCp
	J+hqG2dBiLLObu6+AVOj5FIdyidjnpOE0miKNYPaRpFaWJr00ZMqPiHGR4f3iPZwmBPYSRoPsL84g
	2ZfmgqgrIkv32mCPQPhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRFBi-00Br9Y-7j; Sun, 12 Feb 2023 16:26:50 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRFBR-00Br3A-IY; Sun, 12 Feb 2023 16:26:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A62E8B80D33;
	Sun, 12 Feb 2023 16:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8E1C433D2;
	Sun, 12 Feb 2023 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676219190;
	bh=PHaVWIiDiKuPiyj9CpZVeYgSGEpSXGrmMvcZSQN2a1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHZ1dOpcNlciKJV60ceMatG/ln4gwqhaZjp3ZE5RHjwYiIsNbKgPfiLOmHrkEtBNT
	 0LBqZ54vZ15wL/dO9fbXmNbGA5IZXywhsLgmuVeT8Mxh6nsVQ2XXz5mIslqXmGe9/g
	 AzIa8vrmuhuYMA0WsrKUzqY1iJ2X6VnzRjkJW1xeJOjb+i+e+3nJ6w3tM54rnCLk9r
	 bZn+yK6CEohAWfFi7LJuH0EYEVZLCz4dM4UGrtoZL997U+pcfquEEXsVB3fsWZbkQi
	 9pDJGG+mrF8objq54yFjgqFeB5zDvEOjRdynh9jYkrT7/GybhbLGr2AHJa/rTTFxa0
	 QsuwvU4Larsqw==
Date: Sun, 12 Feb 2023 18:26:06 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Vineet Gupta <vgupta@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
	x86@kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v2 4/4] mm, arch: add generic implementation of
 pfn_valid() for FLATMEM
Message-ID: <Y+kTHsaq8FAG72CX@kernel.org>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-5-rppt@kernel.org>
 <20230212161320.GA3784076@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230212161320.GA3784076@roeck-us.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230212_082633_789082_4A3CE7BE 
X-CRM114-Status: GOOD (  13.85  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi Guenter,

On Sun, Feb 12, 2023 at 08:13:20AM -0800, Guenter Roeck wrote:
> On Sun, Jan 29, 2023 at 02:42:35PM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > Every architecture that supports FLATMEM memory model defines its own
> > version of pfn_valid() that essentially compares a pfn to max_mapnr.
> > 
> > Use mips/powerpc version implemented as static inline as a generic
> > implementation of pfn_valid() and drop its per-architecture definitions.
> > 
> 
> With this patch in the tree, sh4 and sh4eb qemu emulations no longer boot.
> Reverting this patch fixes the problem.
 
Can you please test with only partial revert for arch/sh?

> Guenter

-- 
Sincerely yours,
Mike.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
