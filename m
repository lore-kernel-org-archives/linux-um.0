Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8EFCAC5A7
	for <linux-um@archiver.kernel.org>; Sun, 21 Sep 2025 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5rovFAtkUkJUenI7BhBsGCj5mVmrWVA5Xd/NvQSts8Q=; b=UpvGLyMyTKRapG8znLV67kqHxA
	iUaLzu/6ylDbYrrUJX8Gidqk+Wq2qM5Xbf8TMXUW3vZi1CHp8TuKfAzumtMHt0hprT/qP9v11wkqc
	OyyG85qKwlSZ80RtSHj5fDFrLU8I/iI7QMMrnJ50YVvbT4ByGP96w17pic8DIxOYvmBJrqn+xh9Yj
	YplkpKe77cFOELIoh+R0luhPNEkul65439Ms7VXJXOiMB/8bP4iC7Osrm5mRSw30G9CcszQXYwqXB
	ikyXIsz4CqfcsR2bRqfvDlvWv8hhQz9bJpqqUBWzEYS4bETfrjfJYkifzkZbIaBw3J+MyOYIK55wS
	LpQAEdYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0NVG-00000007tWc-1XD2;
	Sun, 21 Sep 2025 17:05:34 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0NVD-00000007tW1-3kJL
	for linux-um@lists.infradead.org;
	Sun, 21 Sep 2025 17:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5rovFAtkUkJUenI7BhBsGCj5mVmrWVA5Xd/NvQSts8Q=;
	t=1758474331; x=1759683931; b=gE2/rRV6x6zZVMvBN+3nTuiyOLaYjS3/2zG5bKk7ldR21Yw
	JbOturZXb/CrulicwPx25AoChNlHTpo/voXSxkt20LqzRhCICNj44Y/j/D/beP2/28CpWm85pgS2H
	BgEGY/5EE5LzJcjZCu7ReYXOt06pocYhqCTqou25cp9gKrEDwgGuStgqLYSTB+Svu6RPkwGwAqUxV
	k0bK37IVevY6cW9RfgNGjbNUlzWNOhOiiCi7UV4svSsrsSBU6tJwxgoax0/KpphUk2infoXAecN+9
	w39Yqwvy5IdLgIr9uA2TPNDQVVkPy49zEat78E2zivDdMTeOMQrgxl+cuHV3keeA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v0NV7-00000002iXg-1uFq;
	Sun, 21 Sep 2025 19:05:25 +0200
Message-ID: <54d0bf1d1010530941b595129312a56cfdea7c7b.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Willy
 Tarreau	 <w@1wt.eu>
Cc: linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, Arnaldo
 Carvalho de Melo
	 <acme@redhat.com>, linux-kernel@vger.kernel.org
Date: Sun, 21 Sep 2025 19:05:24 +0200
In-Reply-To: <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
	 <20250919153420.727385-4-benjamin@sipsolutions.net>
	 <20250921075511.GA16684@1wt.eu>
	 <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_100531_957024_EAEE17EB 
X-CRM114-Status: GOOD (  26.52  )
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

Hi,

On Sun, 2025-09-21 at 18:37 +0200, Thomas Wei=C3=9Fschuh wrote:
> On 2025-09-21 09:55:11+0200, Willy Tarreau wrote:
> > Hi Benjamin,
> >=20
> > On Fri, Sep 19, 2025 at 05:34:12PM +0200, Benjamin Berg wrote:
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > >=20
> > > There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As su=
ch,
> > > the perror function does not make any sense then and cannot compile.
> > >=20
> > > Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the =
errno value")
> > > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > > Acked-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > > ---
> > > =C2=A0tools/include/nolibc/stdio.h | 2 ++
> > > =C2=A01 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdi=
o.h
> > > index 7630234408c5..c512159b8374 100644
> > > --- a/tools/include/nolibc/stdio.h
> > > +++ b/tools/include/nolibc/stdio.h
> > > @@ -597,11 +597,13 @@ int sscanf(const char *str, const char *format,=
 ...)
> > > =C2=A0	return ret;
> > > =C2=A0}
> > > =C2=A0
> > > +#ifndef NOLIBC_IGNORE_ERRNO
> > > =C2=A0static __attribute__((unused))
> > > =C2=A0void perror(const char *msg)
> > > =C2=A0{
> > > =C2=A0	fprintf(stderr, "%s%serrno=3D%d\n", (msg && *msg) ? msg : "", =
(msg && *msg) ? ": " : "", errno);
> > > =C2=A0}
> > > +#endif
> >=20
> > Please instead place the ifndef inside the function so that code callin=
g
> > perror() continues to build. The original goal of that macro was to
> > further shrink programs at the expense of losing error details. But we
> > should be able to continue to build working programs with that macro
> > defined. There's nothing hard set in stone regarding this but here it's
> > easy to preserve a working behavior by having something like this for
> > example:
> >=20
> > =C2=A0 static __attribute__((unused))
> > =C2=A0 void perror(const char *msg)
> > =C2=A0 {
> > =C2=A0+#ifdef NOLIBC_IGNORE_ERRNO
> > =C2=A0+=C2=A0	fprintf(stderr, "%s\n", (msg && *msg) ? msg : "unknown er=
ror");
> > =C2=A0+#else
> > =C2=A0=C2=A0	fprintf(stderr, "%s%serrno=3D%d\n", (msg && *msg) ? msg : =
"", (msg && *msg) ? ": " : "", errno);
> > =C2=A0+#endif
> > =C2=A0 }
>=20
> For the plain `errno` variable and printf(%m) we don't have such
> fallbacks. With NOLIBC_IGNORE_ERRNO the compilation either fails or the
> results are undefined. Personally I prefer not defining perror() here.

So, with NOLIBC_IGNORE_ERRNO, we do not have the "errno" variable
either and code using it will break. I actually think that this is a
good thing and it is part of the reason that I wanted to explicitly set
the flag for UML.

This also ties to the question of the other mail. I prefer "errno" not
to be available if it is not actually safe to use. UML does use threads
in some places (and may use it extensively in the future). The current
"errno" implementation is not threadsafe and I see neither an obvious
way nor a need to change that. By setting NOLIBC_IGNORE_ERRNO any
unsafe code will not compile and can be changed to use the sys_*
functions to avoid errno.

Benjamin

