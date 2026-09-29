Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F42CA5FAB
	for <linux-um@archiver.kernel.org>; Tue, 29 Sep 2026 01:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WSPn2rseK6a4IufNo372qRJbii4TFE3JGpArxCTS3Ec=; b=YmJbor3znkVis35V9apbR+/X76
	9lzhRYSGjU5BqIcV/jhfHy+j78qx+DDYIKsSNFrvPTHOLo3uQtRVQbtyIg7ysI4jCRDfAQGqlsex5
	LBVyBwbVRSP1Ja290SQfNzwZENZ7nrWakyqJUnbkK1OeEGlREIRpDIHSMsRYKFjZBX+Q0u2fcNTg4
	NHX+NxwfiCfv+10yyZPHm8i38foEjKxRX+t/6AEINPyc0JKJNu4kKtRFb736IykiN+4lQg6VHqhW5
	TtTYvsI8THF4EYo0bJr0QpZL+RTnm8cbDWYR4Su5t8Ug5n/kD0YE4lLk+UY5ap6r7KF1R92Hd7kQX
	Ti6FL3ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBMID-000000020Rl-4BPx;
	Tue, 29 Sep 2026 01:06:02 +0000
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBMIB-000000020RQ-1KCX
	for linux-um@lists.infradead.org;
	Tue, 29 Sep 2026 01:06:00 +0000
Received: by mail-pj2-x0e.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so2174389a91.3
        for <linux-um@lists.infradead.org>; Mon, 28 Sep 2026 18:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790643958; x=1791248758; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WSPn2rseK6a4IufNo372qRJbii4TFE3JGpArxCTS3Ec=;
        b=qJsTJ02pdW69kSq4tXAzKem1ZrPxqqTP7K/+6CJ9cX0+FZLCrPRtfkLbeMAuihw8oa
         8GyLDVN6ndaYdgGAP2cKuGVVAenU353Ys159omlwOlS2gD5nsA08mBQ3Rpf2Vah8lqWD
         Zg6ZsxFW/wJPf8Hn/xyMTuYnxL56TDh71uc7U1TYqGgi9bcV4CJT2RJTH9aeZ8uWiGxb
         Uc6UoW8eCQ+hLZRV85jkPD+QrComwMw+bCvTs7ORhBi/haxgFNKlgKgtdnoAnqT3LWCe
         tq8WaWUSqIXFgNIy7sAcDGrKh7RnM0z71X9phO1EK1pfj/X7AcTnVB7lhxDEQJ3leevN
         qeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790643958; x=1791248758;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WSPn2rseK6a4IufNo372qRJbii4TFE3JGpArxCTS3Ec=;
        b=AZ4kBlA/xhd4KE3RNthUoXVKfh9BaxdLeJUlWJ+cVaSduocY043tledmcLXNQMCKx5
         D6jPyq+r0kCP+w7vrSRGstoTUC4J+6bbQOsSEugfnYVUqHZ3iNTAHtefEJEtDsi+17hP
         BP4UfyhwK0JwWVdMEILOG+RrYWCuuj4dX8ueCmmO0FkPB8/zbIXHWp/WM8ttwWkjD6uX
         yfGXR3bN3KhIMlYHAczmzdD/M+1HAtgn1EmcN0biwcso8MeY2ZXbsp+hj5iwF4JrNJy+
         2kMyH24OcAy/jyRcgd8bCn26hTPlOp7Ife0J8V4uElQoW/w0P+ghbrnY/ZFZVzNqJsMT
         PBcw==
X-Forwarded-Encrypted: i=1; AKwUvBznspCNVu47YDNIjDJxZ4qusT7M1CH75DPS75sbFtcyYRZ2KS2QntkXLmbbdcxgAsAczTPNq1JvJw==@lists.infradead.org
X-Gm-Message-State: AFq9FYL1wF9XL6WnZGbh6eLsNssuZaQPNhDFcMgcjNCi29ygRUA8ISrZ
	NpoTPKwTECBjpiEnEGEnIovxZLzfRifMmUXBGMs9l70bEGhSBYvwZWni
X-Gm-Gg: AYBFou13mBMgGrkIz6GjlKk01xjDqgKJKZrn2qiUu9v0fJooUQYRdXyLVxjUVDLnN9T
	PZr1LiGduAZ90Ha/S0qRDeHlW8VoxVvnxebVSZ967cKKId+C2vT93NT7zpTPfIbuLX06cqq+eMR
	vfFUJdI73sGOy0NGF/hj2lW7Ajr1swZEWidbDTZYBz1bZH6rdnHGZPp2/PjTAJ9SKvQIYmnsw6J
	5oiAq1vFJ14HOp3pUfHPRxqnR/cfdvyLh7ZCNZvNvMk6RmtM/o++StsB5sC5RHrYSRB8biZS1Xh
	gDoJsiT2pgkWFZ6Xfpfgn2oB4fbhu4eJ+9ThEX614aRVrMe12SW94lPHCVJpsj863wmcjkc6z9T
	YTbn2EbF6NcMHpqL03V77mmxMgxLhV1qotPyEPrpyfL4jOGAbtU+360ZfzmC/v7ZRZyc+Jo5JDi
	w4RiOFDwCf4tCuTMHGuVv80fACsIPzuYUqb9jJwnVgouN2gQM4ZGZbounKzm1MnKVNMXg+C4r68
	FzhFDzC3OL6vRYvTT3bef4arTHkxdXB14SMaKQqL3NX0XINLud00VYo1ufMMmLYf07c6vhyOBBy
	j3pK0AiAFf371UUJpcuYUjts+UxU/3L49HDyCuN8CK0ndYRDsjbTGDVl2KPruLPD7VYiy3KjTpm
	m
X-Received: by 2002:a17:90b:50cc:b0:3a4:9b6e:2996 with SMTP id 98e67ed59e1d1-3a49b6e3900mr809185a91.36.1790643958360;
        Mon, 28 Sep 2026 18:05:58 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a497edd76dsm2135265a91.7.2026.09.28.18.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 18:05:57 -0700 (PDT)
Date: Tue, 29 Sep 2026 10:05:53 +0900
Message-ID: <m2y0ck3lzi.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: pfalcato@suse.de
Cc: linux-mm@kvack.org,
	liam@infradead.org,
	rbm@suse.com,
	akpm@linux-foundation.org,
	luto@amacapital.net,
	brendan.jackman@linux.dev,
	david@kernel.org,
	liuhangbin@gmail.com,
	corbet@lwn.net,
	kees@kernel.org,
	ljs@kernel.org,
	broonie@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	wad@chromium.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org,
	geert@linux-m68k.org,
	daniel@thingy.jp
Subject: Re: [PATCH v3 1/3] selftests: kselftest: avoid cd - in runner
In-Reply-To: <arqu1zdvMBXDziRX@pedro-suse.tail5790ac.ts.net>
References: <20260926010819.604346-1-thehajime@gmail.com>
	<20260926010819.604346-2-thehajime@gmail.com>
	<arqi6iwLDDBlk6Tm@pedro-suse.tail5790ac.ts.net>
	<arqu1zdvMBXDziRX@pedro-suse.tail5790ac.ts.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_180559_361894_E8ACD8EE 
X-CRM114-Status: GOOD (  24.69  )
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


On Tue, 29 Sep 2026 03:16:48 +0900,
Pedro Falcato wrote:
> 
> On Mon, Sep 28, 2026 at 06:27:42PM +0100, Pedro Falcato wrote:
> > On Sat, Sep 26, 2026 at 10:08:17AM +0900, Hajime Tazaki wrote:
> > > The kselftest runner currently uses `cd -` to restore its working
> > > directory after running a test.
> > > 
> > > This is not supported by the minimal BusyBox hush shell used by some
> > > NOMMU targets. Store the original directory explicitly and restore it
> > > with a quoted path instead.
> > > 
> > > This also avoids printing the directory change performed by `cd -` and
> > > handles paths containing whitespace correctly.
> > > 
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > Cc: Kees Cook <kees@kernel.org>
> > > Cc: Andy Lutomirski <luto@amacapital.net>
> > > Cc: Will Drewry <wad@chromium.org>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Brendan Jackman <brendan.jackman@linux.dev>
> > > Cc: Hangbin Liu <liuhangbin@gmail.com>
> > > Cc: "Ricardo B. Marliere" <rbm@suse.com>
> > > Cc: linux-kselftest@vger.kernel.org
> > > Cc: linux-um@lists.infradead.org
> > > Cc: linux-mm@kvack.org
> > > Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> > 
> > NACK.
> > 
> > https://pubs.opengroup.org/onlinepubs/009695099/utilities/cd.html
> > 
> > -
> > When a hyphen is used as the operand, this shall be equivalent to the command:
> > cd "$OLDPWD" && pwd
> > 
> > which changes to the previous working directory and then writes its name.
> > 
> > 
> > If you're running selftests on !POSIX compliant shells, that's a
> > you-issue. Fix the shell, or use something decent.
> 
> ... I realize I was a bit too aggressive but seriously, lets not support
> broken software, please?

thanks for the comments.

no, your comment makes 100% sense to me.
under fork-less environment, we have less options but I agree that
this should be addressed in a shell implementation.

I will try to fix a busybox shell and drop this patch from next spin.

-- Hajime


