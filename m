Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BEFC624CE
	for <linux-um@archiver.kernel.org>; Tue,  1 Sep 2026 02:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PIPRUowfHI6K98aTZtO+bijz6IaH7fRlyyv5nHGo4e8=; b=Em1FE+vunbF+3WRcmhe459+aX4
	jWLkgbcwgY2EdRyTH78bbjN6Vh2ZhpKg74yzRU40lnanbCo8GrIwrlRv9hrtxUxol++6R1A8iZEoE
	M2ceis4HtJv27TVT9MzyUbffnvAfBFAA7LIaT3xzHs07nS8e1Azy46EaZUtG31dKmpZG5A2ZaSUAj
	54pGn7zPgRzsBrnYZNwwCBtBupbHFZIwMPgY5DamXE3caHTgz05jBiHT8m5thffly2ZZ4DJiUKYHh
	8LV9ExPJ1P76g+lTlKQ8xxK/ec8p/hj5OzbrN06/VrEYbly6iF3am3XTVAqJNqsH5rrSMnuKWZHnI
	KzkU9X8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1EYA-0000000AtqD-1cUm;
	Tue, 01 Sep 2026 02:48:38 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1EY6-0000000Atp7-2egU;
	Tue, 01 Sep 2026 02:48:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CD931692;
	Mon, 31 Aug 2026 19:48:28 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5150C3F882;
	Mon, 31 Aug 2026 19:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788230912; bh=it2TzzIDYTIEJor+n+hAx7Y9VTg7srHvqDHPINLC58w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=usDt8rhjPTPyhurOvXc8PdfuSoWH0nYsX72TOilRCeK51T4CARGkosyhwrLBvxyhc
	 l9WrmE/Q4V575jMJywI4lXro08Z3FihKyE+sAH5OZKnsGdk8N6U5ibobJVe6+qJK5R
	 M+KgzpkQ/xqu4+mMb5mvQGSArMljTWloMojjfQx4=
Date: Tue, 1 Sep 2026 08:18:28 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, samuel.holland@sifive.com, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm: Drop pxd_ERROR()
Message-ID: <44crgg3r7p2d26blmgq2ewqan3anfhdo73zxe52rvpcjsdhdvd@xztk7osntzhf>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <20260831185519.66c6e6e83ce62d0fd9aee945@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831185519.66c6e6e83ce62d0fd9aee945@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_194834_790806_AC4B1349 
X-CRM114-Status: GOOD (  16.05  )
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

On Mon, Aug 31, 2026 at 06:55:19PM -0700, Andrew Morton wrote:
> On Mon, 31 Aug 2026 11:13:22 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
> > pxd_ERROR() macros have been provided by all platforms, which are very much
> > identical and can be dropped off completely if these pgtable printing could
> > be moved to callers in generic MM aka all pxd_clear_bad().
> > 
> > But first cleanups and re-organizations are required in some platforms that
> > are using these macros internally. Afterwards [pte|pmd|pud|p4d|pgd]_ERROR()
> > macros have been completely dropped from the entire tree.
> 
> All was going nicely until...
> 
> > This series is based on v7.3-rc1 after the following patch and has also been
> > built tested on multiple platforms.
> 
> *what* following patch???

The dependency patch has already been merged upstream.

092836fedd82 (mm: standardize printing for pgtable entries)

Please ignore this.

> 
> Oh well, I'll queue it all up and shall hope for the arch maintainer
> acks to roll in.  Please.

Thanks !

