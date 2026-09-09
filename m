Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E29C79FB8
	for <linux-um@archiver.kernel.org>; Wed,  9 Sep 2026 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YX/JSkYghr9nrINIMWcFmmh29g3GmX1nU9kCwJO/qRo=; b=cKkuX1x0UBzPRXIqSkrg94HxPw
	qZej0Fkoqvfn5YAMBOCuuQYjAZModN9kFwQWlKPwBqFXzJ4w6L/mV4Lv7TPOPJQg//55JzHaagbxo
	QyamYq6ClrOKvb+la+gOmd07MIMhvJGmQ371B6V+Ri5EntaO6j2/ey7r/6v03u8Y/+EK/BosHNKZ5
	uWrrqwy/LPDnrBPuXG47d/zeomyzfUCqlr/VvxibAdKvA9qTRa8TEdItHGjLBLxmBVLa/6R4u14Ir
	2dl2RZ1YtnJrHOjY4lkF0WvTrBlF9kDbmNl2TNAWUB/SobCiF5WTiH7xtNiVn+euyEsTi4x9BXDlK
	JyrCcqjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4EZc-0000000BHRx-1ixL;
	Wed, 09 Sep 2026 09:26:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4EZY-0000000BHR9-2AWV;
	Wed, 09 Sep 2026 09:26:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 84049601FF;
	Wed,  9 Sep 2026 09:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337F81F00A3E;
	Wed,  9 Sep 2026 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945987;
	bh=YX/JSkYghr9nrINIMWcFmmh29g3GmX1nU9kCwJO/qRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I3hNuKz3OgOosFhevpA/IqX36FPKhUlyv3lVsw0nO4Q+4iBZl/clJgolxkJENxlW+
	 t6saypoG4p8f2rOaIqxJouXLfbwGSBJmqkhTA9IoVq2e8cdm0lDPKvINT3bQYZ1OCx
	 WaM9SWYsHM40rBkUpzpJin5l0bvytMAcZJNPrVD1ZG0kQjBHOgqAl8kRnLHclGAK4u
	 2GvxIgrqW15jpgq6k0V9Z3OGDWN8Llv18W9TYZPgWGAcuRDhj92SSf+69DAkaT17id
	 633vQ8gtKuc4OEm1aRtDRgQTtxgqkZRsnMJadehXtqzhErBkyngMzyHilQbpi7ZahO
	 Z3SURmZp6fL+Q==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 36DE6198003A;
	Wed,  9 Sep 2026 05:26:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 05:26:20 -0400
X-ME-Sender: <xms:LSahakXWIT_tvMZpAA4tisSYzPACPbNz90sUvrKt6CnZT7f0bznCEQ>
    <xme:LSahag53DfWVoWKflreXJqLcFkpU92hBAWTzNjRTqAW2ze0rgIAhIsSChKIn5Ti_6
    KANr8G0vz3pvYzhqK6VUilcolUQhOTSLzW4l2jvSqWcWV7i5Wr00qmD>
X-ME-Received: <xmr:LSahajm1t3WFULvmjgrvyoRWrSpX6TH6JtiTt4jZbvxEM0QXBcnMCsVPuQM>
X-ME-Proxy-Cause: dmFkZTG4Xf5HQCh02zpqVvbKCxDxzvOSSyHgHOP3uMLvoamU0KCtlJg5G7fmz9Cf9LwJ4+
    u43d35HyzgT45XS4YAKZHukESCUbAy6ZShLloStMpjHT/y6x5XvWA6PxDLOyWt9+ikMKjc
    zETlWFHuSZ8ORVsn+jAlUAvv2EBzWWsscPi4QFgDlrLa3yw68FIjtTKVaZqM0eJSg/GuFG
    PATxH5LCPqzMkEKCwvoxWevBpaE5KCPic5zvLKY5EIapHD6v0GUJQwsC7esq16fDb0nPXf
    16/0Hsa4P7Gc/AUvOZ0A8A9rcDB4OFqVFmJGna/qdlpcowZ2nVhVucQOP/2UhdOWkjcsJG
    bn5bMQWMV42DveAl7CVcZkwPb5GLbvc1Cf0IzGc9irZASBEiK3FCaxRyq1M73CWs3bmbiy
    ff8K3sgP/N5TIqIlCpWMeIHRSWHEI6dt3xf82VJDupYGSlhNmr9yqFk6w/2dorxNJoWXbf
    YgPEiAWDmBrJh7NfpaNcz3nd9MaiqYGNbDW6RIkrAkS9QWCGiiWtJzvkou0Tm89GVe3kCZ
    2dXCb88A9l1toZ6Oe2eQbItaBH+l/shJecWdB3aE/wGnes1LHEntmse3E+X5e88WLWEJXk
    LTYzE9igbNTFH2Vdd7kfG0gwnEhXZFP9DLJvxDWPIoXNnK4NDvajy5q5fhuA
X-ME-Proxy: <xmx:LSahaqZiJgtSP1S1SXg4ApLr7vjawzMbaok1DlQFBAfjnNWf23YTSQ>
    <xmx:LSahavGJasYuwmK-LtmlKjypYyuDUaWGs252xt1j5xv93UHUhE-04w>
    <xmx:LSahavvD36JEO0uwWjWHHIu5-ZNg6oK3QNWBiPqsc3XTl13vJahNcQ>
    <xmx:LSahasNhB-3rvAirGtHcE-v5Ps2Pehi66hIVbkaqldNeNCBRdVfH3w>
    <xmx:LSahan07FiGk0MNCDzy03CWVja0Qnj4KqABWoK0gdzZFR-lpCNl87xrf>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 05:26:03 -0400 (EDT)
Date: Wed, 9 Sep 2026 10:26:03 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
 Jason Gunthorpe <jgg@ziepe.ca>, 	John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, 	linux-m68k@lists.linux-m68k.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
 sparclinux@vger.kernel.org, 	linux-alpha@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, 	linux-um@lists.infradead.org,
 Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH v2 00/12] mm: make userland page table freeing RCU-safe
Message-ID: <aqEl9zv8M_o1yW62@thinkstation>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
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

On Tue, Sep 08, 2026 at 01:32:09PM +0100, Lorenzo Stoakes (ARM) wrote:
> The majority of architectures in the kernel defer page table freeing until
> an RCU grace period has elapsed, this series converts all remaining
> architectures to do so too and eliminates CONFIG_MMU_GATHER_RCU_TABLE_FREE
> altogether.

Apart from few nitpicks, the patchset looks good to me:

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

