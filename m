Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B433CAC5A7
	for <linux-um@archiver.kernel.org>; Sun, 21 Sep 2025 16:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ujQnDtMNTrIojLIUO6CgHCZwwWCdnuLWPN8HcVHzyQs=; b=HmvL6JfK4lN6bxULl/d1ras2zp
	I6FKo/z4V/JJSlQkQ/34PCdMDBDv3/VIKp5e/LTWgjj5YJTGhmBIOOWR++oAuXJNJ8IezBPELGizx
	3ih3tEmk4Uua7h1ELJAMgg3T3PmFJBFttMu/7FoOLzTLmr7HcdKMu/q9XvUIxhwRBS7k9jlovCORG
	Z8y3dl15e/0xfoZTfzdzmGCbnsf5tOi4+4ZDUKCTBOkSiRLhwnZ33O3fW+kGMX/VogfjKCnVDJQYr
	SVJlEPRVpXlC0qBwPcw6jODpmquwahbRb+Qfp+hgQBUUYDIeVY+olGcEvoIcFlsExh2zM89fsXDif
	d6iqDwQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0N4E-00000007npO-3r7q;
	Sun, 21 Sep 2025 16:37:38 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0N4C-00000007nog-47Th
	for linux-um@lists.infradead.org;
	Sun, 21 Sep 2025 16:37:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758472650;
	bh=7JvBPeJoxKqTRyUBKzE8ehwiAfyw1+bPlIevTM3eY5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mb0PqSL91m8i4951Fstrdpubh9U1v1a53JdmQxCU9diI+Bskx+JxdPgSrrdpMg9ly
	 72CIQue9FqDAWbtLzX58n0oHUC2PdnEyOGEj2oLsC/ui3ilnckEELVJBGz8ifkMg/n
	 Wleb+z0eSgBEklXghZFaRgYzSo685DbgWwZTMhhM=
Date: Sun, 21 Sep 2025 18:37:30 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-4-benjamin@sipsolutions.net>
 <20250921075511.GA16684@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250921075511.GA16684@1wt.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_093737_230192_8CB1CE43 
X-CRM114-Status: GOOD (  21.09  )
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

On 2025-09-21 09:55:11+0200, Willy Tarreau wrote:
> Hi Benjamin,
> 
> On Fri, Sep 19, 2025 at 05:34:12PM +0200, Benjamin Berg wrote:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> > 
> > There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
> > the perror function does not make any sense then and cannot compile.
> > 
> > Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > Acked-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/include/nolibc/stdio.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> > index 7630234408c5..c512159b8374 100644
> > --- a/tools/include/nolibc/stdio.h
> > +++ b/tools/include/nolibc/stdio.h
> > @@ -597,11 +597,13 @@ int sscanf(const char *str, const char *format, ...)
> >  	return ret;
> >  }
> >  
> > +#ifndef NOLIBC_IGNORE_ERRNO
> >  static __attribute__((unused))
> >  void perror(const char *msg)
> >  {
> >  	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
> >  }
> > +#endif
> 
> Please instead place the ifndef inside the function so that code calling
> perror() continues to build. The original goal of that macro was to
> further shrink programs at the expense of losing error details. But we
> should be able to continue to build working programs with that macro
> defined. There's nothing hard set in stone regarding this but here it's
> easy to preserve a working behavior by having something like this for
> example:
> 
>   static __attribute__((unused))
>   void perror(const char *msg)
>   {
>  +#ifdef NOLIBC_IGNORE_ERRNO
>  + 	fprintf(stderr, "%s\n", (msg && *msg) ? msg : "unknown error");
>  +#else
>   	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
>  +#endif
>   }

For the plain `errno` variable and printf(%m) we don't have such
fallbacks. With NOLIBC_IGNORE_ERRNO the compilation either fails or the
results are undefined. Personally I prefer not defining perror() here.


Thomas

