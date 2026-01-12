Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B9BCF45D5
	for <linux-um@archiver.kernel.org>; Mon, 12 Jan 2026 22:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=51z0RRn6rM0eJ/b6q41tGegeBoCrn/fTIV68gsegujM=; b=3uRdcRibUSQcJSENtcGXP8EJKQ
	eLi/4HmfXYbsJZfty7U+SnJPodpJAL0GpGNyV+jKQTsbwLs6bs7hdVWiALLfRZyi0X0Wgd4+Hjksj
	BTxvs4Sdy7Zjbpxt6w3qL3QIqER5GDBXym4Zr6oJ8LdngBKDiWPyO5oldPzlpqa0oI7NRHa2U/D6B
	sbq2IfvsGb8MDu3Sirb8QJIejIH2OdtP5aEUMhi0EYZEHkuDzUQ82LUy0klK84Xy8PYcHPvfH61Sd
	12kfbiO1pfiTQAZ0VHJAiXH8e/uByrKMt5rlam+4L2ZkXUjicTEw/02RGVnO56TxnnJi/1qYKDDJX
	0/GAmZkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfQJt-00000006FZ3-2u5W;
	Mon, 12 Jan 2026 22:23:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfQJr-00000006FYX-19x4;
	Mon, 12 Jan 2026 22:23:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ED79B6000A;
	Mon, 12 Jan 2026 22:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AAAC116D0;
	Mon, 12 Jan 2026 22:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768256605;
	bh=SpuDKcG9IirDr1Ez2z498LsN8t6S/nWxhPc0slzDnQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cu3Pfm/+1TcchxFM/qGiV5fGrKj24o0e3dohdRVVx8JRBK5f1xTeaKdQe1aN7KItj
	 nSpF4OOybQ5f2IlmddpVi4OD3JNYihOeyIRTxNzuxSiGem9/NnrlLPMv/9xRBenAfz
	 EMoQzi5wVQrdA51MdiCDjlgWkvA7qQuIwG0aa67A=
Date: Mon, 12 Jan 2026 14:23:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>, Kalle Niemi <kaleposti@gmail.com>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@kernel.org>, Dinh
 Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Helge
 Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet
 <corbet@lwn.net>, Klara Modin <klarasmodin@gmail.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, Max
 Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, Muchun
 Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Palmer
 Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>, Richard
 Weinberger <richard@nod.at>, Ritesh Harjani <ritesh.list@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Vasily
 Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, Vlastimil
 Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 00/29] arch, mm: consolidate hugetlb early
 reservation
Message-Id: <20260112142323.495fc43e662e7d276b0fa371@linux-foundation.org>
In-Reply-To: <20260111082105.290734-1-rppt@kernel.org>
References: <20260111082105.290734-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 11 Jan 2026 10:20:34 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> v3 changes:
> * fix empty_zero_page initialization on arm
> * fix ZONE_DMA limit calculation on powerpc
> * add Acks

updated, thanks.  I'll suppress the ensuing email flood.

Kalle, can you please retest sometime, see if the BeagleBone Black boot
failure was fixed?

Seems we haven't heard back from rmk regarding
https://lkml.kernel.org/r/aVrUDeSkqqY9ZCtS@shell.armlinux.org.uk.

