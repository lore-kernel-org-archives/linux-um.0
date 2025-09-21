Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDB9CAC5A7
	for <linux-um@archiver.kernel.org>; Sun, 21 Sep 2025 17:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=InYdCqa1ZArFVs0L1uXXsNHExwtLRBKBRS0bupvSfvU=; b=JtAqVbaROhjOMKhR50PYrQ5qX/
	HwfD1MdDuVhH4nia/8snxyZDFGKrbA3agF6APl3Ka07aqtOqpUT0JMi3GrUfdDkBnaxeic+lxuJQ+
	W5GLfO2AmsA8MjYV4a3K7DBL+X8BrYVaRVfTSns481atA+D6KWO4QWZzG2GOq7jFcpZ9VPyr7mAOq
	H0DdPkXiWBLzHc6vEu7OkBD+k15rurfjG1apT+ZumT9CIBpMvYa3ImU23/GnPNnw4bV+cWEBYfzQ7
	K1ftErI8T+8qda53gVHPZMeO8qMeEcAldC13u7PfY2eGmhXe8dF0GYktPdHsTf8yJJzN/vI+ugnNQ
	9eWpPSqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0NYi-00000007tz6-3v3V;
	Sun, 21 Sep 2025 17:09:08 +0000
Received: from mta1.formilux.org ([51.159.59.229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0NYf-00000007tyY-2egN
	for linux-um@lists.infradead.org;
	Sun, 21 Sep 2025 17:09:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758474542; bh=InYdCqa1ZArFVs0L1uXXsNHExwtLRBKBRS0bupvSfvU=;
	h=From:Message-ID:From;
	b=HJBhxBT+5TaX/gUydnZ0Jew3fCSABw1LI/Hlmiz2sqygPV4fSBd//ko4Jjm7XOffx
	 Jpc2MqoPalPWp6oPKYYNNLTnD67WIUBVAkCcLfevq6WMMeusCgXyu6OA6/iHIQpBHa
	 ufh4XSkZHUN4An9tM0Uco5y95pRtpEpgkYSiWGtU=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id D9602C072E;
	Sun, 21 Sep 2025 19:09:02 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58LH91e4028419;
	Sun, 21 Sep 2025 19:09:01 +0200
Date: Sun, 21 Sep 2025 19:09:01 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <20250921170901.GB28238@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-4-benjamin@sipsolutions.net>
 <20250921075511.GA16684@1wt.eu>
 <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_100906_141534_9C05AB83 
X-CRM114-Status: GOOD (  30.38  )
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

On Sun, Sep 21, 2025 at 06:37:30PM +0200, Thomas Weiﬂschuh wrote:
> On 2025-09-21 09:55:11+0200, Willy Tarreau wrote:
> > Hi Benjamin,
> > 
> > On Fri, Sep 19, 2025 at 05:34:12PM +0200, Benjamin Berg wrote:
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > 
> > > There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
> > > the perror function does not make any sense then and cannot compile.
> > > 
> > > Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
> > > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > > Acked-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > ---
> > >  tools/include/nolibc/stdio.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> > > index 7630234408c5..c512159b8374 100644
> > > --- a/tools/include/nolibc/stdio.h
> > > +++ b/tools/include/nolibc/stdio.h
> > > @@ -597,11 +597,13 @@ int sscanf(const char *str, const char *format, ...)
> > >  	return ret;
> > >  }
> > >  
> > > +#ifndef NOLIBC_IGNORE_ERRNO
> > >  static __attribute__((unused))
> > >  void perror(const char *msg)
> > >  {
> > >  	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
> > >  }
> > > +#endif
> > 
> > Please instead place the ifndef inside the function so that code calling
> > perror() continues to build. The original goal of that macro was to
> > further shrink programs at the expense of losing error details. But we
> > should be able to continue to build working programs with that macro
> > defined. There's nothing hard set in stone regarding this but here it's
> > easy to preserve a working behavior by having something like this for
> > example:
> > 
> >   static __attribute__((unused))
> >   void perror(const char *msg)
> >   {
> >  +#ifdef NOLIBC_IGNORE_ERRNO
> >  + 	fprintf(stderr, "%s\n", (msg && *msg) ? msg : "unknown error");
> >  +#else
> >   	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
> >  +#endif
> >   }
> 
> For the plain `errno` variable and printf(%m) we don't have such
> fallbacks. With NOLIBC_IGNORE_ERRNO the compilation either fails or the
> results are undefined. Personally I prefer not defining perror() here.

For me it's still a problem because that breaks the original purpose and
current behavior. You cannot anymore compare the size of with/without errno
for example, like here:

   text    data     bss     dec     hex filename
  20659      24   39424   60107    eacb init
  19836      24   39424   59284    e794 init-noerrno

Perror doesn't just display the error name/number, it also prints a message
about that error that doesn't need errno.

For "%m", that's fair enough, I didn't notice that one. We could imagine
improving it by just emitting "?" or any such thing. But right now it will
indeed proceed like you describe (that's already the case, it's not changed
by this patch).

I don't want to block that patch but I'm annoyed that it unfairly blocks a
legitimate error function that normally provides sufficient context in error
paths so that errno can be ignored, such as here:

   if (open(path, O_RDONLY) < 0) {
        perror("open()");
        return -1;
   }

What's even more problematic is that Benjamin precisely fixed two other
breakage cases in the same series for the same reason that they were
blocking the build without errno, so it would be more consistent that
this one isn't newly broken.

Willy

