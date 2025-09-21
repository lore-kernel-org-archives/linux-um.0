Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54EBCAC59A
	for <linux-um@archiver.kernel.org>; Sun, 21 Sep 2025 17:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7dCgM0eACjtT8GmknFe+LWicZTU06206JRREMKs92Y0=; b=kSngmMTrBKk/CmxJGQBjdtlE+g
	lTosPp4WoLPpghp/1+euUqpLc7bUyaWmFuRGEiOew0GHlGpTuknMt874LZ5i1Ap7jaKAzuwfPJRBL
	k6dwbmREy7R/9NimwGL1xXRizieEVFkEluUJMfFPgSADNM9pM5P000zran4+NvKl75LzNOCQF6jKu
	CtdGa1HpBbyPKpAw/DFmHpyurN0QTdoFMpiPa3L+GB3WMUfkcaR2ISyJglei5MCouEZx01sGFqObM
	2dRDyKbwXZUSsWhUH4yoHj1q5Wwja9RbGNrLMlgFdAC3W1EsSCErawa4u74w1zfvBNwkVDdG68as7
	OpmKLctw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0NgG-00000007uZo-0Tqp;
	Sun, 21 Sep 2025 17:16:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0NgE-00000007uZP-0fWF
	for linux-um@lists.infradead.org;
	Sun, 21 Sep 2025 17:16:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7dCgM0eACjtT8GmknFe+LWicZTU06206JRREMKs92Y0=;
	t=1758475014; x=1759684614; b=PZS5qHF54Z8TmITApERfnt7Ont4rgx5bXoExsbV4EAYcOp7
	VUOkixYWIV4amU9ZBtOXdoUspzgzu3ocGAYyj01/3CENxzM8d9Nae9zERGHfzw4nz3dx7OqnU647b
	CJPN9K0e54H6IKo0MHeEjuqUL++cvbZqtNiVpsav2jwokHuPSdLzY0F312MPog+D5dWNZkm5koBYX
	13Zwtx6LldscSS6/CB0A3PPuPRWNpbFr3seiB69uf/P0v/8XzQGfZlDhWS4EI+AAMmTOm65yC/f+X
	ozwKXPFl83bR+AVi6MDJNc281/L4QgGs37xhMH9t9vcBMPKr3WBc8E+Gy9CKDWUQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v0NgB-00000002jZW-1gGM;
	Sun, 21 Sep 2025 19:16:51 +0200
Message-ID: <25a968dab7cc7e473ff85400a3a824b272121c79.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, Arnaldo
 Carvalho de Melo
	 <acme@redhat.com>, linux-kernel@vger.kernel.org
Date: Sun, 21 Sep 2025 19:16:50 +0200
In-Reply-To: <20250921171323.GC28238@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
	 <20250919153420.727385-4-benjamin@sipsolutions.net>
	 <20250921075511.GA16684@1wt.eu>
	 <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
	 <54d0bf1d1010530941b595129312a56cfdea7c7b.camel@sipsolutions.net>
	 <20250921171323.GC28238@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_101654_201954_9A1A3E5A 
X-CRM114-Status: GOOD (  21.46  )
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

On Sun, 2025-09-21 at 19:13 +0200, Willy Tarreau wrote:
> On Sun, Sep 21, 2025 at 07:05:24PM +0200, Benjamin Berg wrote:
> > This also ties to the question of the other mail. I prefer "errno" not
> > to be available if it is not actually safe to use. UML does use threads
> > in some places (and may use it extensively in the future). The current
> > "errno" implementation is not threadsafe and I see neither an obvious
> > way nor a need to change that. By setting NOLIBC_IGNORE_ERRNO any
> > unsafe code will not compile and can be changed to use the sys_*
> > functions to avoid errno.
>=20
> That's the point I disagree with because here we're not using errno
> more than printf() or dirent(). Why fix dirent() to build without errno
> and break perror() ? Why not also break printf() then ? All of this must
> be consistent. We're unbreaking some arbitrary functions and breaking
> other arbitrary ones, that's not logical.
>=20
> I'm totally fine with saying that errno shouldn't be defined when buildin=
g
> without errno, but all functions must continue to be defined. perror() is
> used to print an error message, it's a valid use case just as printf() an=
d
> should remain.
>=20
> If we disable perror for this, then we must also disable usage of printf
> for consistency (and I don't want this either).

Right, fair enough. It is true that it does not really hurt to keep
perror defined. I doubt there is much code out there, but I also don't
really have a a strong argument against keeping perror. After all, it
will "just" result in a bad error messages rather than undefined
behaviour.

Benjamin

