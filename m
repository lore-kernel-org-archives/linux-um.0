Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A71C5DF82
	for <linux-um@archiver.kernel.org>; Wed, 19 Aug 2026 02:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5mBZvCeN2//ZyvUUsC1lfsgAjSbsE53j1pTePzGlSm0=; b=T81V8NertzOO02FD6rabHjt2R1
	p6t2rMrqwYsXrhU9YTbITbx5oHdQ+WMEVOYOG/oNLG5aOWWOi7EROwZroEN0c2ZArC61hcx0P0Qjk
	J4ZJ9bIOk0Vvu+oWTSk37/yG5jIa08mN2qquesqMlMV66XaMAYQZ4fnPLvT8gHEOx88uIEeEDBMvG
	JXSs8cLx6Q3siTL72ghNe3bmTh75IRmZyGFpZ/VSJWACILcGP995VuHrTisP0KHcDJ9YeEz83gynT
	kzskKY2FwiUiYYn19xFVUeliPWLUUL+Tfro/SpnvqsOKXWf2xbEe7k9iTRJWuV6LV5hrAOSGcsRhv
	K85C2siQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwWMr-00000008uKE-1Xi2;
	Wed, 19 Aug 2026 02:49:29 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwWMm-00000008uIz-2B2g;
	Wed, 19 Aug 2026 02:49:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7DA416A3;
	Tue, 18 Aug 2026 19:49:18 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E01DD3F66F;
	Tue, 18 Aug 2026 19:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787107762; bh=oAq7LZNVfuWLyY8F6bgNDhoqq4F1x7DlAd3a+zTStqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJl0n3O768ihB63yzY/C3psnBKMwgj31m+kzmZIZlkySfUrUB1m+qr/j5JU5c9Afe
	 eXlqYLfwodRGlGGDBoPRCFbNWaxAndC9cqljsF8lDwcjTwNIut2KUoxp62ngsl8nn1
	 zy9caih5g0LTIVBgKUQNdkShhYRX1qD1/PYrFpfg=
Date: Wed, 19 Aug 2026 08:19:19 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>
Subject: Re: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
Message-ID: <mc5cbirsrv24mwu4bg35ksxjyzfoydlgewq4tt7uu3ij7f642o@m4w7dm37nmdh>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-2-anshuman.khandual@arm.com>
 <55d92b3e-ad3f-464f-b2db-a2552353223e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55d92b3e-ad3f-464f-b2db-a2552353223e@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_194924_795888_6BB543CE 
X-CRM114-Status: GOOD (  11.12  )
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

On Tue, Aug 18, 2026 at 07:25:07PM +0200, David Hildenbrand (Arm) wrote:
> On 8/18/26 06:00, Anshuman Khandual wrote:
> > Move ptrval_to_str() inside a header thus making the helper more generally
> > available for new users which are being added later. While here, also move
> > another related string size macro PTVAL_STR_MAX inside the header as well.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> 
> I would have placed that into include/linux/pgtable.h. Any particular reason for
> mm_types?

Yes - that works as well. These declaration and macros need to be moved inside
#ifndef __ASSEMBLY__ block in include/linux/pgtable.h file. Will do the change
as suggested while dropping the RFC tag once v7.3-rc1 is released.

> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> -- 
> Cheers,
> 
> David

