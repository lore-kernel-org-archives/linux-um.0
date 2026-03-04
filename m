Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DE2EF8FF8
	for <linux-um@archiver.kernel.org>; Wed,  4 Mar 2026 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dozotgLjCkx6YfloJbc2dUGdgLVASeazqMNufNecUOk=; b=0bL41Q0ohSCL+1aZgIgxy7SuKi
	kCz9EWowBZo1ZDF4Oep74A4p+L6z4u03E+ruzvydVPZ5fOd8hpPuo2mmns2aKDVw3UoNKRnWh6EI4
	TdmE3wCkUxHzdoIcaQ1GUBdGyUMvRP8nh4fIuILQlOCdq4cNYOeCPAVuM0dHeMzElrpvbOYZ1t7hR
	E2b6CPFqtU/hk6/oS4uFZ9xgMznrmxN+bWFDmUgYVEmI1JBQwv0jv/qX9EKft0EJmttbBFvXPaaOu
	lM3YbVRpML0u5hSGTL/cLZqRniBUfJh4FbYk8fHmaRfmVPCxLuckzfFfjjS9CkUgnaZfGRK8VhyE7
	lkDNmVtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxoNA-0000000Hb2r-1tMU;
	Wed, 04 Mar 2026 15:42:52 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxoN8-0000000Hb2J-158T;
	Wed, 04 Mar 2026 15:42:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dozotgLjCkx6YfloJbc2dUGdgLVASeazqMNufNecUOk=; b=YV9ctmTco1BeitXxs/aCgHAR3R
	8xV6ldv972mxVnFDyj0uwchrv8YiTY+3snMYgluKmNackBY7/QtYTkHkKnsxuQ9+madk/IqtO1w5w
	qV0rRUujDgQ6XL6OyMkn5zBVrcqnVTlPJ7NPAzEGWwa85jNrKM6m+MKkW9EWFVpspSBz5DsFmwbhh
	WfjQXOvyPv1oi9Ynjg95d5t472bLozGmWdbPxD/y81EVWvm8oCWQQ8cn4hfrlh4mYduM2YCcJ277T
	Iz1W7ldTvWuQZYv0XJAiAgQbHRrM8RLIvk1p4DObxaQQRzRKfEZXJE0c4p8csE+8uxUmtXJfXZ6Dl
	R2zAH9CA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxoN5-00000004ybx-1G4q;
	Wed, 04 Mar 2026 15:42:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7375068AFE; Wed,  4 Mar 2026 16:42:41 +0100 (CET)
Date: Wed, 4 Mar 2026 16:42:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 01/25] xor: assert that xor_blocks is not called from
 interrupt context
Message-ID: <20260304154241.GA26451@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-2-hch@lst.de> <20260227142455.GG1282955@noisy.programming.kicks-ass.net> <20260303160050.GB7021@lst.de> <20260303195517.GC2846@sol> <20260304145134.GA21983@lst.de> <20260304151548.GN1395266@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304151548.GN1395266@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_154247_490447_DC57DC7B 
X-CRM114-Status: GOOD (  17.87  )
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

On Wed, Mar 04, 2026 at 04:15:48PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 04, 2026 at 03:51:34PM +0100, Christoph Hellwig wrote:
> 
> > > How about "WARN_ON_ONCE(!preemptible())"?  I think that covers the union
> > > of the context restrictions correctly.  (Compared to in_task(), it
> > > handles the cases where hardirqs or softirqs are disabled.)
> > 
> > Good enough I guess.  Peter?
> 
> Sure. The only caveat with that is that for PREEMPT_COUNT=n this might
> not work, it unconditionally returns 0.

That's a pretty good argument for the lockdep version...

