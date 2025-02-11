Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6D1C021A1
	for <linux-um@archiver.kernel.org>; Tue, 11 Feb 2025 07:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6bocx5Ym7QTSMeZGh79SRg4afEQ9iVNTRYQCSpeNKOs=; b=hb6LdpKLikLcL31gAkwGiiDEs4
	FJ3s0w3oMX2bTc4dos7CRd/PisklM/a60BR6Lbh5U7B52bvX7X8oNOcpgjyDpQpNfOR4pPF9Ukp77
	0YQ+OBV6Do7BIbSezwVbGK48VWb070vtv/gbwqYtSPK42qU17WB15gMEe0bIjLKox7cicV4T4iQ7N
	DqOePXdlP8mmYddEb1R5y4fWEdpTwj+8QOuww3jhPK8NndyG88f1+gns+UkofR+Bv407Xy3vtM0IT
	MXvymAThw/bzbGh0wkQrD6cpRi+iMv+reG/Rh5EgncL3DiLeNecUMq7plmW3fz2cH8wbbWX9hAu+P
	P7ooNN8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thl2N-00000002t5A-3Dcm;
	Tue, 11 Feb 2025 07:50:31 +0000
Received: from mail.avm.de ([212.42.244.94])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thl0a-00000002scz-0wRu
	for linux-um@lists.infradead.org;
	Tue, 11 Feb 2025 07:48:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1739260113; bh=zeYqsmy3zOjGEu/ZNTX027ncYMz1t9krEA8HwArBA2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjWTWyqXIm4qG5RQ+weSzjFX/zpNVo8yMker3i+OKmCeYtRqnn+7lR7PDR4xtcLW0
	 fgpJMjw3322dNPiI0TdLAgFpg2H24nQSlnDEjSVVb6CXD/OppknmJ3i/yaCyA8vVfU
	 u/IoC1SHMD2fFL6gnuYn+ltvhT6e2PVlLJFUoLPE=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.52.1)
	(envelope-from <n.schier@avm.de>)
	id 67ab00d1-714a-7f0000032729-7f00000187f2-1
	for <multiple-recipients>; Tue, 11 Feb 2025 08:48:33 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 11 Feb 2025 08:48:33 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id B249C80230;
	Tue, 11 Feb 2025 08:48:32 +0100 (CET)
Received: from l-nschier-z2.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:7792::1])
	by buildd.core.avm.de (Postfix) with ESMTP id A293E181681;
	Tue, 11 Feb 2025 08:48:32 +0100 (CET)
Received: from nicolas by l-nschier-z2.ads.avm.de with local (Exim 4.98)
	(envelope-from <n.schier@avm.de>)
	id 1thl0S-00000004hMe-1bBr;
	Tue, 11 Feb 2025 08:48:32 +0100
Date: Tue, 11 Feb 2025 08:48:32 +0100
From: Nicolas Schier <n.schier@avm.de>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v1] kbuild: Allow building of samples with UML
Message-ID: <20250211-holistic-gentle-moth-c90edb@l-nschier-z2>
References: <20241218115126.264342-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241218115126.264342-1-mic@digikod.net>
X-purgate-ID: 149429::1739260113-C7F3ACDC-FBB69494/0/0
X-purgate-type: clean
X-purgate-size: 1114
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_234840_682085_188B5E53 
X-CRM114-Status: GOOD (  10.89  )
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

On Wed, Dec 18, 2024 at 12:51:23PM +0100, Mickaël Salaün wrote:
> It's useful to build samples/* with UML and the only blocker is the
> artificial incompatibility with CONFIG_HEADERS_INSTALL.
> 
> Allow the headers_install target with ARCH=um, which then allow building
> samples (and tests using them) with UML too:
> 
>   printf 'CONFIG_SAMPLES=y\nCONFIG_HEADERS_INSTALL=y\nCONFIG_SAMPLE_LANDLOCK=y\n' >.config
>   make ARCH=um olddefconfig headers_install
>   make ARCH=um samples/landlock/
> 
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Richard Weinberger <richard@nod.at>
> Fixes: 1b620d539ccc ("kbuild: disable header exports for UML in a straightforward way")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  Makefile          | 1 -
>  lib/Kconfig.debug | 1 -
>  2 files changed, 2 deletions(-)
> 

Thanks, looks good to me.

Reviewed-by: Nicolas Schier <n.schier@avm.de>

