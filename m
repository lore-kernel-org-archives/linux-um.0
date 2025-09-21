Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ECECAC59A
	for <linux-um@archiver.kernel.org>; Sun, 21 Sep 2025 07:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qtuWRkILHisXI4pbHnjs5IBitzDy5cn+s0usEaACUk4=; b=kuVjBgQlR2oNJp2GhTtUBm5VC7
	0Dt6lXM7qzzc3vt0fBDBpDyYzVJ+g1rTJhb4rgf9O3i7LZ1iRF9hasDX0003FPT+tR8rjBDZdeaBB
	Hc1tDUMHvBx9Q5H3Rn9Wlq5SM+J32sr3dENiSV8TetbFcL8xRsLU9U8xYAYM3rAzwPGcv+5ZjC1Bm
	zQu3/OYzenJPawI6jTUuPhTHAVqI+Ks8lR5bjQ9Ptqya55q+nKKoMIMbFN9w7Vs6pAW7Gmpbkd5jc
	x4SRXQoal15lMVA6gb1kX2BqYTVIVAuO18Nd9q/rnQav1zVtHKKSB8A3GyWAvVwUvQ3dlkggVcWES
	VRUA7FOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Eul-000000070fS-0wMN;
	Sun, 21 Sep 2025 07:55:19 +0000
Received: from mta1.formilux.org ([51.159.59.229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Eui-000000070ec-1loP
	for linux-um@lists.infradead.org;
	Sun, 21 Sep 2025 07:55:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758441312; bh=qtuWRkILHisXI4pbHnjs5IBitzDy5cn+s0usEaACUk4=;
	h=From:Message-ID:From;
	b=DB4Dd6b8tztBECBsHoDwvgsxTvpTO3LN3rTHvuOFbuV7UUv81ZV/TS57SCmDLhsoP
	 L+QmDz5P1gv1qJRuw5BLp6veIeWYt4v/w2phbxq3VN9S/kTOMs72TxCWwPSqpsV6f/
	 w9noQs2v6lPOnb0mUBvm6XAxtZF3kDTHdK3Fd+jA=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 005E0C072E;
	Sun, 21 Sep 2025 09:55:11 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58L7tBjS016692;
	Sun, 21 Sep 2025 09:55:11 +0200
Date: Sun, 21 Sep 2025 09:55:11 +0200
From: Willy Tarreau <w@1wt.eu>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kselftest@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <20250921075511.GA16684@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-4-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919153420.727385-4-benjamin@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_005516_894078_23AEDE1E 
X-CRM114-Status: GOOD (  17.16  )
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

Hi Benjamin,

On Fri, Sep 19, 2025 at 05:34:12PM +0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
> the perror function does not make any sense then and cannot compile.
> 
> Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> Acked-by: Thomas Weiﬂschuh <linux@weissschuh.net>
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

Please instead place the ifndef inside the function so that code calling
perror() continues to build. The original goal of that macro was to
further shrink programs at the expense of losing error details. But we
should be able to continue to build working programs with that macro
defined. There's nothing hard set in stone regarding this but here it's
easy to preserve a working behavior by having something like this for
example:

  static __attribute__((unused))
  void perror(const char *msg)
  {
 +#ifdef NOLIBC_IGNORE_ERRNO
 + 	fprintf(stderr, "%s\n", (msg && *msg) ? msg : "unknown error");
 +#else
  	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
 +#endif
  }

thanks!
Willy

