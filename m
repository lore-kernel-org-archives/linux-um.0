Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643DFCAC5A7
	for <linux-um@archiver.kernel.org>; Thu, 25 Sep 2025 16:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q9glB0jO223mfgQZE3fOMLbrMkDjdxi7IWhdv2MNoKw=; b=H99WqkpeduVlqonhVaaDGAcGLJ
	NGp2VnPNED69LT0yT63WDcv8yihnIZclKjBqGWqM5v1UzjoPLZFrbeKUmmgY07U3JZLUlb28O9y/P
	J5BpW/Y+iKTIWDzhjAYMTekNaaSUkFlUm5XIRX/fachHZvurbhdbjJ4Vuofbs18nmKD3u4m5gO8G/
	khNGiLXnR4JqQrbCgeY2ru5QzkrfGXh4yZ+9Bx6vO7JLzPzT5Z0QV7HK6WoXiJdIlgq8RRhKzTTQY
	RGbe7p3q4WzPR7Csgn7YcB7QFUVwiYm+3py6/kKRl8Jw4SDARYIWZGcRTz9SXyuPp2YjndDvWPUES
	84oB05ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1okG-0000000B4KH-0JYm;
	Thu, 25 Sep 2025 16:23:00 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1okC-0000000B4FS-36rW
	for linux-um@lists.infradead.org;
	Thu, 25 Sep 2025 16:22:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758817370;
	bh=RBud7OQ2jUtgpnGtQOxRUyC0yTtZ3Qj+k8iRs6JRHF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIJFo2IfVAzMVX89HOCJZv2LL3LS5hSk+uiTr4b8yKvAj/Is0C8uoHcDKeAeyCOxA
	 pu9rQFPJRaS5SF8col0S2MA05VlzA8fxsDFZDer1lNawV9crvU9bAjq2XV7KNnAmg2
	 g7ZR6ENvI9ZUhj7d9BtN8kX4qHGy5Tp52+z3UD+Y=
Date: Thu, 25 Sep 2025 18:22:49 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v3 03/12] tools/nolibc/stdio: let perror work when
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <8428cee5-d739-44a7-8253-93f663f9e969@t-8ch.de>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
 <20250924142059.527768-4-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924142059.527768-4-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_092256_928353_05824140 
X-CRM114-Status: GOOD (  14.08  )
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

On 2025-09-24 16:20:50+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
> simply print the message with "unknown error" rather than the integer
> value of errno.
> 
> Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> 
> ---
> v3:
> - Change the message instead of removing perror entirely
> ---
>  tools/include/nolibc/stdio.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> index 7630234408c5..724d05ce6962 100644
> --- a/tools/include/nolibc/stdio.h
> +++ b/tools/include/nolibc/stdio.h
> @@ -600,7 +600,11 @@ int sscanf(const char *str, const char *format, ...)
>  static __attribute__((unused))
>  void perror(const char *msg)
>  {
> +#ifdef NOLIBC_IGNORE_ERRNO
> +	fprintf(stderr, "%s%sunknown error\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "");
> +#else
>  	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
> +#endif
>  }
>  
>  static __attribute__((unused))
> -- 
> 2.51.0
> 

