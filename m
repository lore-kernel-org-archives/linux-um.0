Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117D0D1D483
	for <linux-um@archiver.kernel.org>; Thu,  8 Jan 2026 19:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tzrq+4BiaeS9zeQ5BXLg5bAaN9WKhQUuxGsqtXMKVv4=; b=CiiZ2PgKvpLNDGW8GHEQ7lEKW8
	sh7YG6/iDGz9GueseXEN3Q0qCNiUbGnYoAGFeq3R4KTiaM3KO9mwwd8XA+xOh4LP37V2qa+FWgRDZ
	VjVgd+i6H4vpZodoWAT24DXcin3gxBAuGxwPXes8oGeYQDwQZ4dMzr1UukypkOVF3M5RRxOOue4Gh
	pYDZAbw5GW9wvqa/94LJENyje3LxCvEx5eVQttOoeQh55NiHAqRQq3F/5UhktKhCBpZ0+HJ0WXxVv
	97UBGqmxPeVVV3sqKI0YIIQqKIFsuGgIUBjDmUOhJshcwFqly2qsQhudz2e5BewvUPvY7EY8Y28H0
	icxZurEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdvXb-00000000k2P-0ysx;
	Thu, 08 Jan 2026 19:19:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdvXX-00000000k1f-28ev;
	Thu, 08 Jan 2026 19:19:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DD4D240732;
	Thu,  8 Jan 2026 19:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE9CC116C6;
	Thu,  8 Jan 2026 19:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767899961;
	bh=fSg1rFUc7Lj8obCBDIiOBzwmsy2PDWnpS6aiVKuno6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CVumgl5uYfQfaLqYgweLov8FT7OgO1ch7qHlwuZbONKicqb+bmGFoLIsYAxoWfRsr
	 6BxVTZH+QFJx2xSpWVk0NUrA2Ddxjwu2/Wcc1JG/gPIWft2fVjXp2CIt9nEHIpeVml
	 fnOoO4sO6q/7KPmJQudmyHeHcLC9E7nvlzSuO+ys=
Date: Thu, 8 Jan 2026 11:19:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Klara Modin <klarasmodin@gmail.com>, Alex Shi <alexs@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson
 <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, Brian Cain
 <bcain@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller"
 <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, David
 Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Heiko
 Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen
 <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, Johannes Berg
 <johannes@sipsolutions.net>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Magnus Lindholm <linmag7@gmail.com>, Matt
 Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek
 <monstr@monstr.eu>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
 <osalvador@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav
 <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>, Russell King
 <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Suren
 Baghdasaryan <surenb@google.com>, Thomas Bogendoerfer
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
Subject: Re: [PATCH 3.5] arm: make initialization of zero page independent
 of the memory map (was Re: [PATCH v2 22/28] arch, mm: consolidate
 initialization of nodes, zones and memory map)
Message-Id: <20260108111919.ac5f811132672e760f47fbab@linux-foundation.org>
In-Reply-To: <aVpWpLV4Dut5Muo2@kernel.org>
References: <20260102070005.65328-1-rppt@kernel.org>
	<20260102070005.65328-23-rppt@kernel.org>
	<aVhN2NgQEKe0yzva@soda.int.kasm.eu>
	<aVll339wim7dCIaQ@kernel.org>
	<aVlwOyicOLPB9SOa@parmesan.int.kasm.eu>
	<aVpWpLV4Dut5Muo2@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_111923_616195_15DF1EE9 
X-CRM114-Status: GOOD (  16.02  )
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

On Sun, 4 Jan 2026 14:01:40 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> Can you please stick this between patch 3 (arm: introduce
> arch_zone_limits_init()) and patch 4 (arm64: introduce
> arch_zone_limits_init())?

Did, thanks.  I made this a standalone patch rather than  a
squashable -fix.

> >From 35d016bbf5da7c08cc5c5547c85558fc50cb63aa Mon Sep 17 00:00:00 2001
> From: Klara Modin <klarasmodin@gmail.com>
> Date: Sat, 3 Jan 2026 20:40:09 +0200
> Subject: [PATCH] arm: make initialization of zero page independent of the
>  memory map
> 
> Unlike most architectures, arm keeps a struct page pointer to the
> empty_zero_page and to initialize it requires conversion of a virtual
> address to page which makes it necessary to have memory map initialized
> before creating the empty_zero_page.
> 
> Make empty_zero_page a stataic array in BSS to decouple it's
> initialization from the initialization of the memory map.
> 
> This also aligns arm with vast majorty of architectures.

Russell, can you please update us on your concerns with this change?

