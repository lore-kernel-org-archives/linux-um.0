Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A37CAC597
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 08:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tdr7PfvvANdPCYapCwL/gPQGa+J0cyBC8r6mzCPaNcU=; b=g/L38HhEonCwONpfTY0E/7GA3D
	C9IKeE4oY6bwhXayy3hcvxoDfsIaqPk6GGlwb145sItqPPgkaLgbPXMglw1alJ/aKfQkiIZ/VstVU
	w8YgY66ILBT5V0Ad2/Iv5Yz/Y2Z16jauShOfhDP6Xh843+hyFyrYyyYeyeIoWuEz43dzp/h7qq3BO
	wdw/VZjzXYdhU6giR8RTugKHfGhfLLOg8PcEbd33VVjENtTtjHqziQeSUDBT0xhAj1eHcf93BEvp6
	eiMkf0ocug+/pctFI97vh7rOfnHrwAfDDyGVu8XBEhmKXfJqa2u9pZGbQ7mMlz0DAfhPuWT6xcieB
	NQRGNiEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy4uk-00000003HW0-2cHC;
	Mon, 15 Sep 2025 08:50:22 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy4ui-00000003HUo-0vEP
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 08:50:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757926217;
	bh=8Abhke+wAvVYQkvLFpimTgcFAOpAqB5J5c1BWvnj6sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBMdOFgFALT5WBUoAQ3UCud5d0XBSQHOm5o/wLr6dqavwRynzE/b8lWzZJtGaBEW9
	 5cnjmGg7XyPtoDgqeOxq7odOl+cH7/3jWrloetMLDKPtisbhntuPKPnvsjiLR5GztA
	 YlI7LMu/EBnU+uOJG/sfCyyM261B2xHyAkJypUF8=
Date: Mon, 15 Sep 2025 10:50:17 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 5/9] tools/nolibc: use __fallthrough__ rather than
 fallthrough
Message-ID: <6fff1ac0-2868-4377-b8a3-c10fe1a4c1f5@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-6-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915071115.1429196-6-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_015020_423765_323F07AA 
X-CRM114-Status: GOOD (  13.85  )
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

On 2025-09-15 09:11:11+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Use the version of the attribute with underscores to avoid issues if
> fallthrough has been defined by another header file already.

Not a really big fan, but as the underscore variant is documented there
shouldn't be an issue.

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  tools/include/nolibc/compiler.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
> index 369cfb5a0e78..87090bbc53e0 100644
> --- a/tools/include/nolibc/compiler.h
> +++ b/tools/include/nolibc/compiler.h
> @@ -41,8 +41,8 @@
>  #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
>  #endif /* __nolibc_has_attribute(no_stack_protector) */
>  
> -#if __nolibc_has_attribute(fallthrough)
> -#  define __nolibc_fallthrough do { } while (0); __attribute__((fallthrough))
> +#if __nolibc_has_attribute(__fallthrough__)
> +#  define __nolibc_fallthrough do { } while (0); __attribute__((__fallthrough__))
>  #else
>  #  define __nolibc_fallthrough do { } while (0)
>  #endif /* __nolibc_has_attribute(fallthrough) */
> -- 
> 2.51.0
> 

