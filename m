Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D5AF31E22
	for <linux-um@archiver.kernel.org>; Thu,  9 Apr 2026 14:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vtWvECdJsOce5KQBkQ6BB16WnHR2lmUFEE8FNue2MfA=; b=OloF115nAeofaywWE9Z8Xpb8sp
	96FEUtgipZkuXNaVE7CPxtScDt0/iMmWjhbgnftpxKokZUr0HSCXRMx4T3wcS6LmbZgsmFdnCVE5b
	2ulFQpGkVug5vno+pfZ0AZK28V7lM+/vnI26seaTH4GA5c//P+/VhIYMjGj5S61+FanOV65Q8Jj/7
	Hpd7iBvcUguocGcais/zCzbOaeE56fMFFHpdnhlWP+MBd3eW2Mzs04ElH0xq094LqxMFKbcJPPe26
	0nM3O0fN1TAt6fdqGx2YcgYcrpaiUOTdr//D77C7C9E4F3HoJ1pe+uqXx6IB8o2pGTRK2FG4IHLqI
	D32T4HXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqff-0000000AjMv-2b5b;
	Thu, 09 Apr 2026 14:47:51 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqfa-0000000AjL8-2yzn
	for linux-um@lists.infradead.org;
	Thu, 09 Apr 2026 14:47:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vtWvECdJsOce5KQBkQ6BB16WnHR2lmUFEE8FNue2MfA=;
	t=1775746066; x=1776955666; b=Y9nZ3aZXL84eklteleQagr5/yKCru9IJbxiTW93Akva6F6c
	O97wqTp+KnfuGJZJDAfiJpCW3tP346syGhzwN39TM4QIjhifoGTuATCwOVZFfcTusBNek/GzWjOcO
	4B6AD7F9lkWI8wosGaq8mqfXLrFNw/jBBc+cFxKrq2wkWGilx0WT896kf1vQagMWuQOe8LY01stJw
	T87r98ushe7T/exjFZRiP4D94XY59Pz5p4Ym0Xjg2lg0WFruSANIW1QcuZiE+uvJhTRZOVkxUSFjH
	8iySGUlp6hNCG376LuhJTQJLUWps7u79d3xWEkUj9O8PJF2uoRb+XfVrRhCQtICA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wAqfN-0000000G2eD-3CNn;
	Thu, 09 Apr 2026 16:47:33 +0200
Message-ID: <5cf1d83227fd5a6af784f0b11fcdebf9a0bc9f94.camel@sipsolutions.net>
Subject: Re: [PATCH v3] gcov: Disable GCOV_PROFILE_ALL on 32-bit UML with
 Clang 20/21
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <kees@kernel.org>, Richard Weinberger <richard@nod.at>
Cc: kernel test robot <lkp@intel.com>, Nathan Chancellor
 <nathan@kernel.org>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>, Peter
 Oberparleiter <oberpar@linux.ibm.com>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt	 <justinstitt@google.com>, llvm@lists.linux.dev,
 linux-um@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Date: Thu, 09 Apr 2026 16:47:32 +0200
In-Reply-To: <20260409052038.make.995-kees@kernel.org>
References: <20260409052038.make.995-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_074746_748137_0B5EDB44 
X-CRM114-Status: UNSURE (   7.24  )
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

Hi,

Maybe the subject should say "um:" instead of "gcov:" now?

(I'm assuming you want us to apply it to uml tree.)

> Prevent the bad combination by disabling UML's ARCH_HAS_GCOV_PROFILE_ALL
> on 32-bit when using Clang 20.x or 21.x.

You say 20.x or 21.x,

> +	# Clang 20 & 21 miscompute __builtin_object_size() under -fprofile-arcs
> +	# on 32-bit, causing spurious compile-time errors in check_copy_size().
> +	select ARCH_HAS_GCOV_PROFILE_ALL if !(!64BIT && CLANG_VERSION >=3D 2000=
00 && CLANG_VERSION < 220100)

and I see that 22.0 doesn't even exist, and maybe that's a general
pattern, but it still looks confusing? Wouldn't it be better simpler to
say < 220000? At least to me that more obviously is "up to 21.x". After
all, 20.0 also didn't exist, and you did >=3D200000, not >200000 or
>=3D200100?

johannes

