Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16007CAC597
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HnzQEGPcyCDCP2vUtmuBITx3sF0aGDmvHxjFD9i8KQk=; b=e46tYvPykTsJ0hAgcXvqjoRnib
	zly8DKqNKgFVqJrJ5edHOOsFP8SLLWl+3fwDow8uhNlo8RRnkCpP33TXUYzoM7KQSbqjKo08Zj/Nd
	9vTgWaq9Y7UFe7jcVMqla66p3u3HLTcg30BTh+puLoocAc2Ca7WjuxUeLpeGV/UAKF0ARfDpeP1Gi
	ETCWxWi+lYgudepHk1C+Jv1HqSMMpKkEd4DzFXtpUIfOAzI0x61LMLbIpRBvagb/KtbIVNt1QChTW
	r3hH3QczBh2UmXDe9DfrrA6cxaYaboAyz2hpNW8iUzfVwHjCUzBa/YSEBQatB6f42zKC7sQQxleC5
	PP/437Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy4oi-00000003GdZ-2vlu;
	Mon, 15 Sep 2025 08:44:08 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy4of-00000003Gc0-32W6
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 08:44:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757925843;
	bh=W7YV6hJok7RI7aIC5/O+0Zf8j9sxTcMFC7JXs2vghfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1ZBdQBEYc3/z2O/Aj+4tZn08J9dct6xRNwTUZo6NBfL7W5Eu9vMbnnEYKHU/liah
	 M70KnmXBRAKkLsBCRhodgQkoXeQ1LCgOJDfJoj+2dsBv72++lHE/wT4QrO1xQVhZgg
	 slLFoTtS1TKdfVYKF0nu5gqqKFyKsVgYj2AIaFWI=
Date: Mon, 15 Sep 2025 10:44:03 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 3/9] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <58366c48-99b6-430a-a05c-51a2a5e044a7@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-4-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915071115.1429196-4-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_014405_918180_B3F1CC4D 
X-CRM114-Status: GOOD (  13.36  )
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

On 2025-09-15 09:11:09+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
> the perror function does not make any sense then and cannot compile.
> 
> Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/include/nolibc/stdio.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> index 7630234408c5..c512159b8374 100644
> --- a/tools/include/nolibc/stdio.h
> +++ b/tools/include/nolibc/stdio.h
> @@ -597,11 +597,13 @@ int sscanf(const char *str, const char *format, ...)
>  	return ret;
>  }
>  
> +#ifndef NOLIBC_IGNORE_ERRNO
>  static __attribute__((unused))
>  void perror(const char *msg)
>  {
>  	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
>  }
> +#endif
>  
>  static __attribute__((unused))
>  int setvbuf(FILE *stream __attribute__((unused)),
> -- 
> 2.51.0
> 

