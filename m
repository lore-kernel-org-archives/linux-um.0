Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A017C624C2
	for <linux-um@archiver.kernel.org>; Mon, 31 Aug 2026 06:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/H8XwUq6/bROzHqqhxbKEvOIJlS9kKt/F3AGQnb3rVI=; b=rN3lzmC5x7qJKSK+USJKkOJBSi
	h3KakeWB87Dx0VSeQEtzWraMRGXoKyyokE0nH7xj0Uif+O6g3yQFyU/y1dwRyHZQcrZ3Dwr48ykP2
	nVWpmOzjw6rWpPb0Ok3/JjMvQ9Zb3de1nF3BCYA9IOAZE0ITPcWALVqN1nmMeEhLuT4stVZDXr2Hh
	G7R0xyeFJzLNeQnQmYONlvJlEuSEcCqSPUWHIwuXdxBhnW2GPRof2Ys/u/7AXW36TiO2yuPvAFzyG
	I9w5uKw1r+R1gDpt3HQFs/NaQ9PknzDhCtfhQuqDUj2qI7yFztUVDSvnwF2UvdzfsLArXuX0zMKjb
	ttFiyiCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0vpc-00000008e1X-10sR;
	Mon, 31 Aug 2026 06:49:24 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0vpY-00000008dyE-1KuP;
	Mon, 31 Aug 2026 06:49:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B591414BF;
	Sun, 30 Aug 2026 23:49:14 -0700 (PDT)
Received: from [10.164.18.31] (J09HK2D2RT.blr.arm.com [10.164.18.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D75643F8C6;
	Sun, 30 Aug 2026 23:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788158958; bh=UzZgy0NWc63K+ko4Xr6TdOnwA9EjAL5aleqBNdt6jY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U7FcIb97JDEewur9Kf4radnvfeDHm6NiB7P5FNYX6eqEzgaSbcLTTz2427bXHEGdQ
	 uo4OFurjcGsPFnWvC+QS8s3MrHKwugc62Aj4Qy9UerHzl+ldPYjUgyGMq+omakELHp
	 zDbAViiLJS8zWjabH0UPjbR/p9ivvj9kKzLGGkiE=
Message-ID: <8ad05b11-5cc3-4682-b921-a0c7820b1f97@arm.com>
Date: Mon, 31 Aug 2026 12:19:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] mm: Drop pxd_ERROR()
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-mm@kvack.org
Cc: samuel.holland@sifive.com, David Hildenbrand <david@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <d766413f91cd778912f6af372d3d5429bac7765f.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <d766413f91cd778912f6af372d3d5429bac7765f.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_234920_406932_707F9C7D 
X-CRM114-Status: UNSURE (   9.58  )
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



On 31/08/26 11:38 AM, John Paul Adrian Glaubitz wrote:
> Hi Anshuman,
> 
> On Mon, 2026-08-31 at 11:13 +0530, Anshuman Khandual wrote:
>> pxd_ERROR() macros have been provided by all platforms, which are very much
>> identical and can be dropped off completely if these pgtable printing could
>> be moved to callers in generic MM aka all pxd_clear_bad().
> 
> If pxd_ERROR() macros are really all identical, why not provide a common definiton
> of that macro? I'm always a bit concerned about such changes as there is always
> a risk to oversee arch-specific peculiarities.

We don't those platform macros any more after converting generic MM into using ptval_bytes_to_hex_str()
which now handles different pgtable entry types.
> 
> Adrian
> 


