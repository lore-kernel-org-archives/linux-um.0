Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3F4FEFB58
	for <linux-um@archiver.kernel.org>; Fri, 27 Feb 2026 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sd4Dk0zWsQwDRJSs7bWqIQywpiYjqUPgxmAIc0fK68w=; b=q/MH/SZnmvCFNhKrX5BxFWO501
	JGfgy2gDBPAyC7L6vlGRdW0FHPxge4Y+VtKyXiHad0v6B4iA7pegw3PPQdozRJdUhkI5p4a2K3Z9J
	kB6FE5JmPdG9mQUxsHKxNtUCKiDCwBcNvV+w37/4Bw8oxH0wzCKHrtqx93BdyYIhidBimQpyZv5gt
	BIIJxc0exMXV9gaQ1EoJ8eZ+d4vsENF2skx3E4vJwd0nlh31XZxjbKk3P3ScXQymJ2IazvpOkCJvv
	mtk2GWG0IyMsTx0PCn6gw6eeYZZb6OohCOnP5xyS+c/ShxVtzjr1DROzGmyOWtB7Ffy5EbDqZfNBS
	RjBSdgFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyx3-00000008VMf-3KTI;
	Fri, 27 Feb 2026 14:36:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyx2-00000008VMC-2x4V;
	Fri, 27 Feb 2026 14:36:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sd4Dk0zWsQwDRJSs7bWqIQywpiYjqUPgxmAIc0fK68w=; b=KD1L4Etwagd1eSmxZlo6KzsMbM
	fONwzvtpqLYChdBJfr8NDHR8cZXcrwPHL+6MIUnFqjzp0jZOeTwkR++VxiE9mZ1Fxo7dbV/s6M719
	JXFDIXO8UCIWQEeT56dTega0MPjMh5tY7+yrFo7oX79K+n7Q70KOFxLusSqDmlcp0JTF6MuobaJLg
	ZSmFE4SvOnGKM4aBqQQdA/ZFNBGOvBjLR8Shx1hs85uSqO4Qz/GeLsp1DyW7Ixx3MzD/enr49FEf0
	39cX6Lvq4zVc/FsVzQUKO0QukCMVTZ+GAl9JRmO5cYgboNvRfsG10Yh9iL/+2tvOLVN16tQiiLj7h
	ldkMSYYw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvywq-0000000DG9M-0aeA;
	Fri, 27 Feb 2026 14:36:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AF18E300462; Fri, 27 Feb 2026 15:36:06 +0100 (CET)
Date: Fri, 27 Feb 2026 15:36:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 25/25] xor: use static_call for xor_gen
Message-ID: <20260227143606.GI1282955@noisy.programming.kicks-ass.net>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-26-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-26-hch@lst.de>
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

On Thu, Feb 26, 2026 at 07:10:37AM -0800, Christoph Hellwig wrote:
> Avoid the indirect call for xor_generation by using a static_call.

Nice!

