Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB97FD5307
	for <linux-um@archiver.kernel.org>; Fri, 27 Feb 2026 07:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6J0SL9RsbUQWhN8iu+ey8pLnEs4VtLYMczUYtzIoAc=; b=llRPtZjEocy5kgWE/ZHmVlMq14
	bfy6gYzxGcGAqdaQm0atVAt68tNoVqIL7vb/VhUeUWMejGDzdiAWWX5Y6/IqgvheTRpCUVca4pZAZ
	FyQo0l2R9vodwnc/F1SRKYfFCECl9IWJ2GPeqNM0s/5VDsT9N+F6JFL65Zw3Y8RrGQLRc39w29wiK
	Z1ZIhfj4TZ+hTdIwBZi9q5lEQppw3bbAg9nY6N+NdEbvZh/XSXfR8Eh+YlkAh3AuvbAvYLED7M3jl
	l0XgTeovIa37avjvAGTpJV/CfI1nhF1OjiJHpo+benL/qWG6qSD6JFkuquowZyyoGPCKZBtyBt1rj
	fEWpPQiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvsSp-00000007uDh-16Fw;
	Fri, 27 Feb 2026 07:40:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvsSm-00000007uCN-04HB;
	Fri, 27 Feb 2026 07:40:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=V6J0SL9RsbUQWhN8iu+ey8pLnEs4VtLYMczUYtzIoAc=;
	t=1772178039; x=1773387639; b=ocma0MZIuXziW7lVh/1E1Go3lVZm87iiHWwbamFyj9KsjK2
	ihnkU0Xkjll+4MCeX6dkwdr7neACMPj1Vu7HQhfI24NqjBGFJGCzf9CFfNz3L8UAEXWpLvDXw5h3q
	HkPk3AUrl0JcsVIcbtBpTP/6Aife6hS0USV6ITM/HpUwgdNr1k1sK6OYhTATIkVgc/km7CpMGDazi
	Y5J5wlYaL5p5OH+nFQyysOTLMBaHIvV2pf/+YSBpXqi5lIjTHh2ojJmlrMpeye5W3u3pMaYzPd03e
	AXrU831528yWeev6QzQuJ/b+s9hs0kgENclbwfzC8lrpYO5gzKOCnblALSiivpYw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vvsRx-00000003Eus-2oGQ;
	Fri, 27 Feb 2026 08:39:49 +0100
Message-ID: <4f69d30f952bc374e69f44786f662886c30058e9.camel@sipsolutions.net>
Subject: Re: [PATCH 03/25] um/xor: don't override XOR_SELECT_TEMPLATE
From: Johannes Berg <johannes@sipsolutions.net>
To: Richard Weinberger <richard@nod.at>, hch <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Henderson	
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Magnus
 Lindholm <linmag7@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas	 <catalin.marinas@arm.com>, will <will@kernel.org>, Huacai Chen	
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Madhavan
 Srinivasan	 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin	 <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,  Paul Walmsley	 <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou	 <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Heiko Carstens	 <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev	 <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>,  Sven Schnelle
 <svens@linux.ibm.com>, davem <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>,  anton ivanov <anton.ivanov@cambridgegreys.com>,
 Thomas Gleixner <tglx@kernel.org>, mingo <mingo@redhat.com>,  bp
 <bp@alien8.de>, dave hansen <dave.hansen@linux.intel.com>, x86
 <x86@kernel.org>, hpa	 <hpa@zytor.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, dan j williams	 <dan.j.williams@intel.com>,
 Chris Mason <clm@fb.com>, David Sterba	 <dsterba@suse.com>, Arnd Bergmann
 <arnd@arndb.de>, Song Liu <song@kernel.org>,  Yu Kuai <yukuai@fnnas.com>,
 Li Nan <linan122@huawei.com>, linux-alpha <linux-alpha@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>,  loongarch
 <loongarch@lists.linux.dev>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-riscv	 <linux-riscv@lists.infradead.org>, linux-s390
 <linux-s390@vger.kernel.org>,  sparclinux <sparclinux@vger.kernel.org>,
 linux-um <linux-um@lists.infradead.org>, Linux Crypto Mailing List
 <linux-crypto@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
 linux-arch	 <linux-arch@vger.kernel.org>, linux-raid
 <linux-raid@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 27 Feb 2026 08:39:47 +0100
In-Reply-To: <445921547.2198.1772142326749.JavaMail.zimbra@nod.at>
References: <20260226151106.144735-1-hch@lst.de>
	 <20260226151106.144735-4-hch@lst.de>
	 <445921547.2198.1772142326749.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_234040_079165_9AC218B7 
X-CRM114-Status: GOOD (  14.21  )
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

On Thu, 2026-02-26 at 22:45 +0100, Richard Weinberger wrote:
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "hch" <hch@lst.de>
> > XOR_SELECT_TEMPLATE is only ever called with a NULL argument, so all th=
e
> > ifdef'ery doesn't do anything.  With our without this, the time travel
> > mode should work fine on CPUs that support AVX2, as the AVX2
> > implementation is forced in this case, and won't work otherwise.
>=20
> IIRC Johannes added XOR_SELECT_TEMPLATE() here to skip
> the template selection logic because it didn't work with time travel mode=
.
>=20
> Johannes, can you please test whether this change does not break
> time travel mode?

It does work, even if it reports nonsense (as you'd expect):

xor: measuring software checksum speed
   prefetch64-sse  : 12816000 MB/sec
   sse             : 12816000 MB/sec
xor: using function: prefetch64-sse (12816000 MB/sec)

I think it works now because the loop is using ktime and is bounded by
REPS, since commit c055e3eae0f1 ("crypto: xor - use ktime for template
benchmarking").

The RAID speed select still hangs, but we've gotten that removed via
Kconfig, so that's already handled. Perhaps raid6_choose_gen() should
use a similar algorithm? But for UML it doesn't really matter since
CONFIG_RAID6_PQ_BENCHMARK exists.


As far as AVX2 is concerned, yeah, I guess that was a bug, but evidently
nobody (who configured time-travel) ever cared - what _did_ matter
though in practice is that the boot not get stuck entirely... Two
completely separate issues.

johannes

