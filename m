Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F810C624A5
	for <linux-um@archiver.kernel.org>; Mon, 31 Aug 2026 06:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qoFo7+PxqjttbtK92O/ZZGktuuQcYVg2E/w5Dp6VQ88=; b=wkOjjRDAVC9lGOkb2B/vHBUjTQ
	jT41Feal6F5JcxJpH/ws2e/bJztYqXXAAZg0DzWUTOQkPvFbd+8zkypabEag78N4oVymUGxwu4aV0
	E+cm+0l2ff9+rbOd4vgHv0NLHFREki9HaHEwweO4SjLGoQiL8/iiNfPLe122A3EaQ5G2RMmKDH35L
	6apm8Em0KyKbdY1tyXfqnnqSQptm8RUx0lbuLC1wr89Tfx9/OAcsFrFLN7FH0akdgemXPRwPhabEs
	3R2TzUQrnWiQmq+b1PsCxDuw35C0BDGcIEWiZSkkM2Dcv9ixeRXvhjcGetYrnNtLrCDoFr9Y5Q9Uu
	a75Whatg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0vCm-00000008aWX-1Q08;
	Mon, 31 Aug 2026 06:09:16 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0vCi-00000008aVB-1unf;
	Mon, 31 Aug 2026 06:09:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=qoFo7+PxqjttbtK92O/ZZGktuuQcYVg2E/w5Dp6VQ88=; t=1788156552;
	x=1788761352; b=L1/B/MV6CXC1B8PfK2YOmrlUBJwhsYbgXDPZkIEpjOZWB43/r61Ximv57d5T9
	KSH6hnm83I1F4oDY7G9IMuvKamDdvYoDcX4B8NZ1Mc3T8XKh2Le4WeJPiKcNDWO7MoBv+3zvMjTUE
	PT3d77W26lHLpKQ8AVJLNSVtCRvreJaBMzgIraIBX5SbtytPePBomMmHGzQJY6+0TMtQz44b3RteH
	8RwPb5ysLt8foWO4BY1/kjAV76UFFiLZukqYW6BIvDKevEPSpLGluwxnijFFg0OIzKyiRWGX+cRqE
	uJrVKV/WPjnug8PW+fzg+7JBIlFZ7MBKAjbuV6LD3mqGGnGrGw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x0vCP-00000003S29-3Hzv; Mon, 31 Aug 2026 08:08:53 +0200
Received: from dynamic-002-242-195-014.2.242.pool.telefonica.de ([2.242.195.14] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x0vCP-00000000yAZ-2A6t; Mon, 31 Aug 2026 08:08:53 +0200
Message-ID: <d766413f91cd778912f6af372d3d5429bac7765f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/8] mm: Drop pxd_ERROR()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: samuel.holland@sifive.com, David Hildenbrand <david@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes	 <ljs@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker	 <dalias@libc.org>, "James E.J.
 Bottomley"	 <James.Bottomley@HansenPartnership.com>, Helge Deller
 <deller@gmx.de>,  Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 31 Aug 2026 08:08:52 +0200
In-Reply-To: <20260831054331.625505-1-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 2.242.195.14
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_230912_653986_CB4FD151 
X-CRM114-Status: UNSURE (   6.90  )
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

Hi Anshuman,

On Mon, 2026-08-31 at 11:13 +0530, Anshuman Khandual wrote:
> pxd_ERROR() macros have been provided by all platforms, which are very mu=
ch
> identical and can be dropped off completely if these pgtable printing cou=
ld
> be moved to callers in generic MM aka all pxd_clear_bad().

If pxd_ERROR() macros are really all identical, why not provide a common de=
finiton
of that macro? I'm always a bit concerned about such changes as there is al=
ways
a risk to oversee arch-specific peculiarities.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

