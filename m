Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB03FD9E1A
	for <linux-um@archiver.kernel.org>; Thu, 26 Feb 2026 22:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ilvamkoK822H0OMpkLt0O2v/cHCUl9aKFe1v6Kcca4=; b=OnTpQgf2lo0LCjE4SL8IzBur+J
	e78j+hEz/3S4qpGLvNV1ADc2Rb1In49XMcsX6ZI4sYRTPpDfVu2CjYPCc1MjxjORtd723sbjHvv0M
	nRllB0k6aqvKA3PNXdONAf/W9TTx2NmdgwiAQfu2x5O014FW9O/UbiOuxNEku5CepjWPSwNFXwekB
	WkpIwx7ACtlndvU+zA+wm7lMgNF+KmmRCGugJbMcol81f9faJInTrLZiU7Wp6rM5NQEpw9ItV5J+f
	QC80cpMiT4XhJNMdhZZzwCoHcUjBPvDISz3IGy09sLD5biHhUsz6eXstHpdNYpVuCCU1902+OOU6C
	5DMwmx1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvjPh-00000007HL9-43F1;
	Thu, 26 Feb 2026 22:00:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvjPe-00000007HKe-3ho6;
	Thu, 26 Feb 2026 22:00:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3731168C4E; Thu, 26 Feb 2026 23:00:39 +0100 (CET)
Date: Thu, 26 Feb 2026 23:00:38 +0100
From: hch <hch@lst.de>
To: Richard Weinberger <richard@nod.at>
Cc: hch <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>, will <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
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
	Sven Schnelle <svens@linux.ibm.com>, davem <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	anton ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, mingo <mingo@redhat.com>,
	bp <bp@alien8.de>, dave hansen <dave.hansen@linux.intel.com>,
	x86 <x86@kernel.org>, hpa <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	dan j williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>,
	linux-alpha <linux-alpha@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	loongarch <loongarch@lists.linux.dev>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	linux-s390 <linux-s390@vger.kernel.org>,
	sparclinux <sparclinux@vger.kernel.org>,
	linux-um <linux-um@lists.infradead.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>,
	linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH 03/25] um/xor: don't override XOR_SELECT_TEMPLATE
Message-ID: <20260226220038.GA15172@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-4-hch@lst.de> <445921547.2198.1772142326749.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <445921547.2198.1772142326749.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_140051_067374_DC1ABC15 
X-CRM114-Status: GOOD (  15.92  )
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

On Thu, Feb 26, 2026 at 10:45:26PM +0100, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "hch" <hch@lst.de>
> > XOR_SELECT_TEMPLATE is only ever called with a NULL argument, so all the
> > ifdef'ery doesn't do anything.  With our without this, the time travel
> > mode should work fine on CPUs that support AVX2, as the AVX2
> > implementation is forced in this case, and won't work otherwise.
> 
> IIRC Johannes added XOR_SELECT_TEMPLATE() here to skip
> the template selection logic because it didn't work with time travel mode.
> 
> Johannes, can you please test whether this change does not break
> time travel mode?

I'm pretty sure that was the intent, but as I wrote above it worked
and still works on AVX-supporting CPUs by chance, and already doesn't
on older CPUs, and unless my git blaming went wrong someewhere already
didn't when this was originally added.


