Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED77DFEE4C6
	for <linux-um@archiver.kernel.org>; Sat, 28 Feb 2026 06:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wQMyDOvMSNktzNNveysU2n4Fnu4+Lg8kOQ3nNBMOreA=; b=ZE1uRleQZVo0D9bFYspzyr/nIp
	+/6UsE+4v86taebR36yUqwwPbe5LTDcJ3f2UATmcWexSkt6qZvI2lOXyXsuVZZgAi+CXV4gboOApf
	EHXW/XCdTIukQ7jSgeJ3V//J6bhwgtEmZRX6CB7XJMfQRFqBy871yi8Myi7YKjKWTQyV1Bfv7XdLY
	iqR+wkF9ntEd0f2kmE3MkgoUqiaxkM5iJ5TTD2gnlkFQER3heT//VbnmEscdHROGV+2vlwkONTou6
	Q0HWpJl1xqscU5eosGS+hT/OMyp9xBUIue5xKM9OOOrXf1oe8WNzfuuEQk/Pbo7+ydwiXPdgSjh69
	SoLNmjpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwEEy-00000009ZfZ-0slS;
	Sat, 28 Feb 2026 06:55:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwEEu-00000009ZeV-3V5y;
	Sat, 28 Feb 2026 06:55:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9C63540830;
	Sat, 28 Feb 2026 06:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A1AC116D0;
	Sat, 28 Feb 2026 06:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772261747;
	bh=b4wWycMp/qA51ETIBAMbd3c8O+W0qcQO/Vfxz7HjaAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psiiY+mjJy9NDUUzgU6LpECxATrYP6E6WdOer+42b5zCn8ow/eyJXB/ug0mExA9cv
	 6ePYSGlmoaHtHOi7qoSg0Q3QsHkOGGPNWPHKY6G4BOjm8G543wF1gbRSWkuG2NNNoX
	 iKjLmRNvDQFISHuKPxgVP1X34FieZC9G4odogCmXjbvadUHK8R5eStFkTiEhfNFMtU
	 4FNEJ616kUSHbRZxM+m3jm1NVk176WszihcTfvBODu+/0eL6+UG2HnIgUPOZLNLSj1
	 WxX5AcZXlMJ9kqMb4ogEhdlpTjXL93m1Gw4Fm2Ba2sZDjbueHKzehZlPdBX5J/XiRb
	 igjWvy5k/xF5A==
Date: Fri, 27 Feb 2026 22:55:43 -0800
From: Eric Biggers <ebiggers@kernel.org>
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
Subject: Re: [PATCH 22/25] async_xor: use xor_gen
Message-ID: <20260228065543.GI65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-23-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226151106.144735-23-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_225548_895243_73D617ED 
X-CRM114-Status: GOOD (  12.73  )
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

On Thu, Feb 26, 2026 at 07:10:34AM -0800, Christoph Hellwig wrote:
> Replace use of the loop around xor_blocks with the easier to use xor_gen
> API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  crypto/async_tx/async_xor.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)

There are still comments in this file that refer to xor_blocks.

- Eric

