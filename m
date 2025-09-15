Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF35CAC597
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 08:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jfExI7GTN0vssjZiyr8Y++lRr8cqveWILMqNnMAf7xw=; b=XRUrDo0JaRDe/wCFOiR7cBCfSO
	mZ7/pwYw2EoNc8bp6zeVh4jKEtx2i8cokmcez8qk8AEQeyHoIkibgHlqwNFonJIXX1rYpdkgf6ac6
	2HfASEJnx3L3bWfqRjTCzmYLZobAs+7VTDNnFDoCW+3YpRs9nmk6ngPI6UNEJjORQ1jmGBI75B7aG
	I/TlRu0L7gJSx2HyG4s42Sv/QGBA5edpDffRat436TCx+mTTZSXkwfwngyjz+XJE8o2+i/PNhKWeh
	1NnqVQsT0OxIMnwWNfFycMy0ZPSBVOA14A1/ESCaXnAmI+bSwbpbH8fAFRFUZqrAJgefRXxE1cAcF
	QelD512Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy4ki-00000003Fp0-2wHC;
	Mon, 15 Sep 2025 08:40:00 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy4kh-00000003Fn8-0gDg
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 08:40:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757925594;
	bh=DEE0/mm3nae2M+afwZaoC+YIBs/g4NMHQTIGIKkxo3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKnF6KPS6FtHcqoF22gXtrxrlrGtR1DML9nfnuH453b1Ua6LIMo+qMwKkMX8I4Ixy
	 TSE2X4mAVyhttY4sMh/RAXs24EOjwm0Eguh+/p1TbVA8isdxmDqzujOcvWqC+e91WD
	 zrImBPHAs8lfcGEOs8OH6YXwL0IoQXMonKRq8jcs=
Date: Mon, 15 Sep 2025 10:39:55 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 1/9] tools compiler.h: fix __used definition
Message-ID: <231ba0cc-b568-4310-a96d-f899689fbfc9@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-2-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915071115.1429196-2-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_013959_410444_AB6D4D3A 
X-CRM114-Status: GOOD (  13.87  )
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

On 2025-09-15 09:11:07+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The define mapped to __attribute__((__unused__)) instead of using
> __used__.

Can you explain why it is a problem and add that it now matches the
definition in the regular include/linux/compiler.h?

Anyways:

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> Fixes: e58e871becec ("tools/lib/lockdep: Remove private kernel headers")
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  tools/include/linux/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
> index 33411ca0cc90..b2c40621d441 100644
> --- a/tools/include/linux/compiler.h
> +++ b/tools/include/linux/compiler.h
> @@ -127,7 +127,7 @@
>  #endif
>  
>  #ifndef __used
> -# define __used		__attribute__((__unused__))
> +# define __used		__attribute__((__used__))
>  #endif
>  
>  #ifndef __packed
> -- 
> 2.51.0
> 

