Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC728C624D3
	for <linux-um@archiver.kernel.org>; Tue,  1 Sep 2026 17:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=StaeALLek35hMlcSHa6BZyUhT0ljTsLx6yTS5xCyYM0=; b=Yo7U4ojefih7ceoNOO/n99UoCN
	B467UVqre48+je1NcOO6seWF9NqSjmEZlLuoR9r8GyktpQNCA7y5lMMLDO44zS0/foDnugAwufUTD
	ehSS5WtH6wZXlFJr19T5iRxL5CCS5UB4mOIyoIl+p7J/DSRySx/vMye3+coZCQURWI52JvZmQy4UZ
	OZBMVgGyCvdW5fqgzbXoRDitL52myCQZa1lqmuoT2zR/JBFRh8ed5higF0sJLmpDKiRwroBlOvMgg
	akixBMPNnVWywla3npbYrnf2hDX2pyq1OiPEURj/6hu0zEkYx06Xq+xaGenis/Ceyeik8wEkr10yk
	Ap9IFvxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1S25-0000000CmEB-2oUn;
	Tue, 01 Sep 2026 17:12:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1S23-0000000CmDY-38by
	for linux-um@lists.infradead.org;
	Tue, 01 Sep 2026 17:12:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1B9756013A;
	Tue,  1 Sep 2026 17:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567FE1F000E9;
	Tue,  1 Sep 2026 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282742;
	bh=StaeALLek35hMlcSHa6BZyUhT0ljTsLx6yTS5xCyYM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Juse0t2CRnLclkizU3JyDowVdwlJ0iiAypCeeJBRrMzUuWkIA48/zZoxvPY8ynax5
	 93+gzbbaOxxd6yRhV4ql7Earf9bVYAmXcQp1apsMu+Q9JCQPkIM5y0xSMnEsDYvX6v
	 2m2QIAum85lWmt97me6fz/S83bX8ZzmWfL6Pp8nqNuVU53FW4YvFM/T1Z0XmItrBzv
	 p6K4CvlNWhstOGcDUrFY3zM/GkKi/mg9QppuB2k3p3kNMWoWTsRRNuS43+ZRnbktrm
	 AeAAbLVSoNyYJvnqJHEpn+uT3X0IsBTxymX/qrlQ/JRx2E0I3Zfvz6CmO5Pa+TDLJo
	 ZP4Nl5FijSGRA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 509151980082;
	Tue,  1 Sep 2026 13:12:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 01 Sep 2026 13:12:17 -0400
X-ME-Sender: <xms:YQeXarupuu8lP4hODV4Kl4cTBMZRESUvNFli0neseEvSVdU6eTqegQ>
    <xme:YQeXaujYR-JcqcZ5XRB19_Sp4AidO5MknnGtlz5Ss_8D6FAekB1GDKTys9TKm5dQ7
    9-CzIWyGX5yW7Y4wxP7-FxE2PboOlz7Sija6KJsrP8cvzQQUwq3uQCR>
X-ME-Received: <xmr:YQeXapWFsxw_1UNeqnO8z4EZg2oOg-FIVaehIEwbl2C9sTmSY05S5RPiU9I>
X-ME-Proxy-Cause: dmFkZTE95wHRzu4Jku/uqR1uWajKbrR5zJX2cXnYtALksDxTaOWWCUqT0ALShYzFchhR19
    jABbL3NMpQdq2Q4yk1wxABfpkhz1tXbwJ0ETPbBKtnkrOsetjBDE6HJPSHCSzQ+lV8p7hR
    m8B5tw0NCYc8nr5KG+JJnI7EqrKbJ9j/iB4uBQ8v3yh2BnmhuMnsKxLkWZCbcUsikaiaIb
    afOgG11+NHa8fIFfGiaQPV11ZUcZ/PxqcPGfORQq/nrNuM+iA2OtyKWdZtMIzuN7Y+Bitk
    xOhO/HMBDeF+31R8MKrPNSYAO9QueQgK/MZ6ZozJxRSVjUBLpeca5t06PFY2rHErDLj+iW
    2yn2As7fL8DmU2YIyhDqY4qqwa2/ZrsmjL2YjjyNf5Ut5V+o1Q2jHYwdnRpVE4qQekDIlA
    0QFGDvxUI/D1PW8k3h1xG2sm2CMe+07Xc1+6x36TyY7o9SD12A1XaguCEJgvlOl/E4/LPo
    GFNx+zoYsO4VdClgp1h7hc4suTeM5K0X91cofeEj76CiP8ubXYR9unXAMBRmzaTibsCFRl
    htnRbe1HGqYqK8cW0PalkL3qgmd3CH6stsr7YLE6PHlCrh2N2VCi400sm4iXeFTUQOgmsx
    q+kN/77vj/DcD2YNv53dz8Mkn5XTiexA6E9lSNNFtklTEqyElGj/pD/1naEQ
X-ME-Proxy: <xmx:YQeXaiCrGQOdc0DQyRgUDZV_Q7rbwwtsvYy_6612aWm1Dw459aKeLg>
    <xmx:YQeXak3aszLb-RuoyQQti3VDFiBgP4eq84UZpaU9PzzzbGI3kIPqQQ>
    <xmx:YQeXagyRzlL5sf79pX7TX42r92YD-ITwLJRci3UCGMw3KLjWYgQL6Q>
    <xmx:YQeXan2N5VeJKbhgyOObCD-q2vQfw0NbQQLabtDLgtNHoJWCeTl7HA>
    <xmx:YQeXanzxgCScGaao3xUiAb6wqDwwmrMtpplfWrXaivHsO8SbqI1rMQni>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 13:11:59 -0400 (EDT)
Date: Tue, 1 Sep 2026 18:11:57 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
 	Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 	Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, 	Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, 	Usama Arif <usama.arif@linux.dev>,
 Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>,
 	Geert Uytterhoeven <geert@linux-m68k.org>,
 Dinh Nguyen <dinguyen@kernel.org>,
 	Simon Schuster <schuster.simon@siemens-energy.com>,
 Jonas Bonn <jonas@southpole.se>,
 	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 	Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Paul Walmsley <pjw@kernel.org>, 	Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 	Alexandre Ghiti <alex@ghiti.fr>,
 Russell King <linux@armlinux.org.uk>, 	Vineet Gupta <vgupta@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>,
 	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>,
 	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, 	Peter Zijlstra <peterz@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 	Andreas Larsson <andreas@gaisler.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 	Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 	Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 	Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 	Sven Schnelle <svens@linux.ibm.com>,
 Richard Weinberger <richard@nod.at>,
 	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, 	Arnd Bergmann <arnd@arndb.de>,
 Vlastimil Babka <vbabka@kernel.org>, 	Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, 	Michal Hocko <mhocko@suse.com>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, 	linux-hexagon@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 	linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org,
 	linux-arm-kernel@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
 	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org,
 loongarch@lists.linux.dev, 	linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 	linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
 Hugh Dickins <hughd@google.com>, 	Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH 01/12] mm/huge_memory: zap deposited page tables after an
 RCU grace period
Message-ID: <apcFUthh0XSFg3JQ@thinkstation>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-1-5456a81c8212@kernel.org>
 <apbOlyF77yDCV4cF@thinkstation>
 <apbcoMTVlL42G5tg@gremlin>
 <20260901142408.GA56830@ziepe.ca>
 <apbiB51hjm-9pRzf@gremlin>
 <apbuO_QveZNAz3ns@thinkstation>
 <apbvoN6ttgHfI_xg@gremlin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apbvoN6ttgHfI_xg@gremlin>
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

On Tue, Sep 01, 2026 at 04:45:14PM +0100, Lorenzo Stoakes (ARM) wrote:
> > munmap() of 64G worth of THP should be enough to demonstrate the
> > problem.
> 
> I mean you're going to hit that from RCU freeing page tables already, which
> most architectures already do right?

Not at the same rate -- tlb_remove_table() batches into struct
mmu_table_batch. One call_rcu() per MAX_TABLE_BATCH.

> So if RCU saturation is a problem, that problem already exists, but I've
> not heard of that being a problem at all?

I did quick test and I don't see a measurable difference in munmap()
wall time of 40G of THPs. I see ~17x more softirqs, but this is
expected.

The objection is retracted.

We can return to this later if it is going to be visible anywhere.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

