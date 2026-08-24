Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B46C5DF9D
	for <linux-um@archiver.kernel.org>; Mon, 24 Aug 2026 07:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hpXldSP37oQmlhckItfAzwUOG6JobW41WzP0kSdLesI=; b=hCLiehzqplinFyKsZAIsXn/Pv+
	H/wFC3yhWt/1n2QZ20uRfWv66ofXcWj+/PzBULSvf5pjfE3xKjPi4sOTxmbysbiiOBs3bD43BOHeG
	0U2+UA22Bql5k25V0BQIUy9FGVDMFqOGAf0YTQ8LgShYpnChZnONaftTRSXZKJCgY+IJyprbETbcO
	F5DdE+PhGzRcecn9+PaO1DdcYMszlWIXhFKgYGhgMir51apNaM4qbnUc+96myhPR1NdODprk+Eaq9
	2HcSJ1y/iKzSePniqSVVNmNVillTUH+zSy7ORLuJt6f1jc6qn2P7I2z4Knps+iDHCWl9b5JJY0Owt
	mFaAUrug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyP5v-0000000G4aM-3vSc;
	Mon, 24 Aug 2026 07:27:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyP5u-0000000G4Zf-18TH;
	Mon, 24 Aug 2026 07:27:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 300B1600AD;
	Mon, 24 Aug 2026 07:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B017B1F000E9;
	Mon, 24 Aug 2026 07:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787556464;
	bh=hpXldSP37oQmlhckItfAzwUOG6JobW41WzP0kSdLesI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Hghfi3F3hhjgblfEVPUEEPHALjTTBAgKBK8MbewWtmMLpyrYB+8Jo29/224FAiShM
	 0SLcU5txHHDDVRBQmZbs0Km1ZqbqYphsVzR3okw73rVZzhWFSwmbPshMJk+4ij8Gwk
	 wBlW/tVqVoMXtxSb8VWH+7r37m/WC7KmAwdV5lxYZr50+jzu/iInwaVg4PoIgWPYV+
	 C5co0jxq4J2+miGm/bYP5+zECjtlCOUz+jUuPUU4mw1mdcjIPjf5Qqh658+sfYqF50
	 oCrhxE7AzAMSOiSyXc8TzEpXzk6qb68sZUnHfTQBzsRUMB6GzKuCnUN8V+wutnGyd3
	 qgVllw8rmVK3Q==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC V3 0/8] mm: Drop pxd_ERROR()
From: Mike Rapoport <rppt@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
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
In-Reply-To: <20260818040041.1891769-1-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
Date: Mon, 24 Aug 2026 10:27:34 +0300
Message-Id: <178755645423.3606540.14531883744138096395.b4-review@b4>
X-Mailer: b4 0.17-dev
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

On Tue, 18 Aug 2026 09:30:33 +0530, Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> mm: Drop pxd_ERROR()
> 
> pxd_ERROR() macros have been provided by all platforms, which are very much
> identical and can be dropped off completely if these pgtable printing could
> be moved to callers in generic MM aka all pxd_clear_bad().
> 
> But first cleanups and re-organizations are required in some platforms that
> are using these macros internally. Afterwards [pte|pmd|pud|p4d|pgd]_ERROR()
> macros have been completely dropped from the entire tree.
> 
> [...]

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


