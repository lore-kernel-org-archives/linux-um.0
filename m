Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B569BC61CE5
	for <linux-um@archiver.kernel.org>; Tue,  3 Jun 2025 08:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ll9HQg8JHducpOZaqvXxVZxIxZ1+gNQW3g36PYXusgc=; b=Xnomi0huRtQm5o+WBGNqX2ohHV
	6od9BL5miQxJOYjtvwPZdjuweyCdT+wHUvxw0iOPiresQLx5eV8u1f+5yIjmvVSlBLK0/pLrMr8+o
	S2aeykAXYZ9QMpoGCYJcaBUm2I3yMUwnT69nYrKVyscirj/wvGbX/RIT2U1FZt9ra75jn/KiEoIS+
	Mn+JF05lqm7gbI3q23etr353zxtYq6pOyukgYDN+7zUqJpTY67LzE0tpSEVfftbfpd7xB+5PPjgiC
	MQ4N5oYU4cwrO5oTUznUMjgxa7M7hyi0kdhER7B+z/MwbfzLYOsqMSNRxM6CNrGwG7sQ/+Y462VGz
	vfR9TVjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMNK6-0000000AOEh-3IMj;
	Tue, 03 Jun 2025 08:48:42 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMNJC-0000000ANwN-06K5;
	Tue, 03 Jun 2025 08:47:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ll9HQg8JHducpOZaqvXxVZxIxZ1+gNQW3g36PYXusgc=;
	t=1748940464; x=1750150064; b=kjwtRzhfzQgmwHrbnjMLjG0b7aTSwY2Ton8MclKxW4sLZr8
	zxFfnuy3e6WuwJXN5gj1jeERjCRoKgRcGrbwuJNhonNKZICBAJX5alrx94XD4sShMB4S3WOQUEapN
	pkUMmC75w7YvBecHePFvIhEaZOcqK6Nbjet/vJTjt3EDtNkxSPM2brCNeJw+8mfCG4CZDmcOtFlyM
	xRsyz9PWny42OhEpSTtOMtEH7uYuoGPv/pNaKyBPtoIW/Jpmn8i6UW7f4QNRq6orp9UahMHJHeyIl
	vuuJ6ZK5t8gVhTOzM5EvlgS/2iTveuxoURJOLoQzTwhCdFKW6PAqVZwVBfdjCqhg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uMNIR-00000009mC8-119O;
	Tue, 03 Jun 2025 10:46:59 +0200
Message-ID: <b4fe62d12be677dc047ee2fce4a65284a5f915e8.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] arch: use always-$(KBUILD_BUILTIN) for vmlinux.lds
From: Johannes Berg <johannes@sipsolutions.net>
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev	
 <agordeev@linux.ibm.com>, Alexandre Ghiti <alex@ghiti.fr>, Andreas Larsson	
 <andreas@gaisler.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Borislav Petkov	 <bp@alien8.de>, Brian Cain <bcain@kernel.org>, Catalin
 Marinas	 <catalin.marinas@arm.com>, Chris Zankel <chris@zankel.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Dave Hansen	 <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren	 <guoren@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens	 <hca@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Huacai Chen	 <chenhuacai@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, "James E.J. Bottomley"	
 <James.Bottomley@HansenPartnership.com>, John Paul Adrian Glaubitz	
 <glaubitz@physik.fu-berlin.de>, Jonas Bonn <jonas@southpole.se>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Matt Turner <mattst88@gmail.com>, Max
 Filippov <jcmvbkbc@gmail.com>,  Michael Ellerman <mpe@ellerman.id.au>,
 Michal Simek <monstr@monstr.eu>, Naveen N Rao <naveen@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley	 <paul.walmsley@sifive.com>, Rich Felker <dalias@libc.org>,
 Richard Henderson	 <richard.henderson@linaro.org>, Richard Weinberger
 <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Stafford Horne
 <shorne@gmail.com>, Stefan Kristiansson	
 <stefan.kristiansson@saunalahti.fi>, Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner
 <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,  Vineet Gupta
 <vgupta@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Will Deacon
 <will@kernel.org>,  Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	sparclinux@vger.kernel.org, x86@kernel.org
Date: Tue, 03 Jun 2025 10:46:57 +0200
In-Reply-To: <20250602181256.529033-2-masahiroy@kernel.org>
References: <20250602181256.529033-1-masahiroy@kernel.org>
	 <20250602181256.529033-2-masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250603_014746_079824_9A246565 
X-CRM114-Status: UNSURE (   7.18  )
X-CRM114-Notice: Please train this message.
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

On Tue, 2025-06-03 at 03:12 +0900, Masahiro Yamada wrote:
> The extra-y syntax is deprecated. Instead, use always-$(KBUILD_BUILTIN),
> which behaves equivalently.

OK, whatever you say ;-)

>  arch/um/kernel/Makefile         | 2 +-

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

