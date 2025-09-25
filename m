Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181DECAC5B1
	for <linux-um@archiver.kernel.org>; Thu, 25 Sep 2025 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FG5IuawlU6CRGjbgVq2HxKYywWXITVvlGHVlwrnurWQ=; b=tW2dZwjciFcY772d/2dTAbvDH/
	SG5JEuDx7lq+isYxgc6ooT7aXEmHEbZ5uQzUgsv/MC2rIjDJvDrIBM3rV70n21zAFFCnTCLqpAGJw
	3u/B4MxlGXeT8anjiiBfuTalWAFMxBGxCR9PitxRBTw5KVm2VwXABvZGlJThSet/ccNGVm5kFOP6U
	iggQKoJY+fzlxkGuLSkf3GBuUSVmoiihMAwzHL4pbZGSNQgT1763hWsJUU/sA67+y77/4UOMMg3bL
	nk5742dAZVNX7KPyOuInfc/9FkimeXcn0qbH8qyeMKq+RpD8wGA+riC+C/2o6l/myuyeWs6Cknml7
	Pc7ecDgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1olX-0000000B5Y6-3W3L;
	Thu, 25 Sep 2025 16:24:19 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1olV-0000000B5Tl-09oK
	for linux-um@lists.infradead.org;
	Thu, 25 Sep 2025 16:24:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758817454;
	bh=ZseXcKJOoFZwJc+bmSlC9mOKhka3TjWkK31x0E+BHRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j2Di+Id6LYcdiJsOkoU4u8V2kFwnn3m3bUt2gNI+v2W7wHw8taZU6GPWSuaJe/fPr
	 0/TQQVrgaiLyk55MmajgsiXsnx2nujbfLQwt/x6AHg1WnGZitAca6X0Vyh0VfSnxgg
	 g/gDT3CbinJR+AXQwv9pfagU+rVJI+YQ4yX+ehWM=
Date: Thu, 25 Sep 2025 18:24:02 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v3 05/12] tools/nolibc: implement %m if errno is not
 defined
Message-ID: <a8e4b65c-8d1d-49ac-8f33-00a46a8b9f11@t-8ch.de>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
 <20250924142059.527768-6-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924142059.527768-6-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_092417_293553_272E557E 
X-CRM114-Status: GOOD (  14.12  )
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

On 2025-09-24 16:20:52+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> For improved compatibility, print %m as "unknown error" when nolibc is
> compiled using NOLIBC_IGNORE_ERRNO.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Thanks for taking care of this.

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/include/nolibc/stdio.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> index 724d05ce6962..1f16dab2ac88 100644
> --- a/tools/include/nolibc/stdio.h
> +++ b/tools/include/nolibc/stdio.h
> @@ -321,11 +321,13 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
>  				if (!outstr)
>  					outstr="(null)";
>  			}
> -#ifndef NOLIBC_IGNORE_ERRNO
>  			else if (c == 'm') {
> +#ifdef NOLIBC_IGNORE_ERRNO
> +				outstr = "unknown error";
> +#else
>  				outstr = strerror(errno);
> -			}
>  #endif /* NOLIBC_IGNORE_ERRNO */
> +			}
>  			else if (c == '%') {
>  				/* queue it verbatim */
>  				continue;
> -- 
> 2.51.0
> 

