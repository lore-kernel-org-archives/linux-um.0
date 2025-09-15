Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBA9CAC597
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 08:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BmMtzvOy0lkutdodbVtIfceip29pwfg3QaxTwlFDMF0=; b=tGfY04zUd7Z7zeVFohvICssILF
	mghBAOrmay2yGkNj0ChNJXy4ncazypxnF5XWU5fNnbM0FvmyGtIoUevgkULzb/oAssORhVuwanPFT
	tAqbU9QqJMF5bXuvSXGb/QyukAZ6W3IIBJwJIHOWz9qGGocH4hlxHjsWWV7oM3suhM6srLfOK7utZ
	o50DpwyTsK64fLpPKvjHcR5fJMgjMoKt/Ttv7OQgMlnbdOawS6HwePC3JHwr8V/9NBcP54ssMEyw5
	xwgTWDyhQnhG2s9YouQTSWf1uVk8h3Lt3oK2OgvCJ5wSWaczZO604V5jfl+oCimOoIZJBAQrVNi3U
	vZ6jaOUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy4py-00000003Gqm-0lqn;
	Mon, 15 Sep 2025 08:45:26 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy4pv-00000003Gq8-2zly
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 08:45:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757925920;
	bh=OwQvqJhcj6BAWEZyrl7CaKqNbJZO3h3KE9AB37M7yyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRRdwmmjba3LR4S3DYxn9cDv3cY9lET+O4RhVdJSs8Mgo74IeDwY9o5AnNrRzsPvb
	 aCEQk22aLUC3J0X0pdQdC85bLJJfVlrAHfJEf4SAGpYPnRcGQuVglBCdqAQPl46VGh
	 jyU0T+d+oUqO5KUeTubCg72fwyzGNpQmFHWHqSco=
Date: Mon, 15 Sep 2025 10:45:20 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 4/9] tools/nolibc/dirent: avoid errno in readdir_r
Message-ID: <97fd7c74-bfb5-4ff1-9698-e60d7b3c9a11@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-5-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915071115.1429196-5-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_014523_898264_688CEE5C 
X-CRM114-Status: GOOD (  16.82  )
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

On 2025-09-15 09:11:10+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Using errno is not possible when NOLIBC_IGNORE_ERRNO is set. Use
> sys_lseek instead of lseek as that avoids using errno.
> 
> Fixes: 665fa8dea90d ("tools/nolibc: add support for directory access")
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/include/nolibc/dirent.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/include/nolibc/dirent.h b/tools/include/nolibc/dirent.h
> index 758b95c48e7a..61a122a60327 100644
> --- a/tools/include/nolibc/dirent.h
> +++ b/tools/include/nolibc/dirent.h
> @@ -86,9 +86,9 @@ int readdir_r(DIR *dirp, struct dirent *entry, struct dirent **result)
>  	 * readdir() can only return one entry at a time.
>  	 * Make sure the non-returned ones are not skipped.
>  	 */
> -	ret = lseek(fd, ldir->d_off, SEEK_SET);
> -	if (ret == -1)
> -		return errno;
> +	ret = sys_lseek(fd, ldir->d_off, SEEK_SET);
> +	if (ret < 0)
> +		return -ret;
>  
>  	entry->d_ino = ldir->d_ino;
>  	/* the destination should always be big enough */
> -- 
> 2.51.0
> 

