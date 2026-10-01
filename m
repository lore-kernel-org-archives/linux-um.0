Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA5ECA5FD4
	for <linux-um@archiver.kernel.org>; Thu,  1 Oct 2026 21:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=; b=25r9F+420D7fbJsUbSqOELB5LK
	2R2rqrZq6MZ/OPVpzo/UCaiTtQIkaiLA4guhEOJ5p6ibXso2fghNbYM1/c8Uz8STed61wDAZ5w/zF
	AvrnETq7ov9KZaHrJe8z/toavQ+Flz2E5DXTyU+rMm72HlGB/UbFFlZ3TnDnhEnxbz8GBgttDctn0
	1Znd5WzPiX5hmrcFx9mtnUW/TmKPQS7qXwRSX8JCrU0bKcZfobnE/gfFXCpXdfM/n8pxOrjfKT7Zf
	7mSAhVHcRAo2AUU7tBkTaYV7FFvXLnROs6QY5DkJ2uVtjnA8/nWE8Q4Q8g93NiOJOI2re6jQUTDHS
	SHMBZNIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCNyo-0000000ACZD-0EDW;
	Thu, 01 Oct 2026 21:06:14 +0000
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCNyk-0000000ACXv-2gWD
	for linux-um@lists.infradead.org;
	Thu, 01 Oct 2026 21:06:12 +0000
Received: by mail-pz2-x0d.google.com with SMTP id d2e1a72fcca58-86efece610cso3472110b3a.0
        for <linux-um@lists.infradead.org>; Thu, 01 Oct 2026 14:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790888767; cv=none;
        d=google.com; s=arc-20260327;
        b=As1NbQZB+HXKSYxA8jbdY4zzGWXSIiLNi1eDg88vssKRKjQLGdvXuZh44QErjLmL/4
         JApAo/+wvnmu9uK5slsyvlGQkuTDGqcfn1uitSFtp1QeLJ4jCAjaL0jzWDkI/EwY+YpR
         PWWoyqjytRk/j8dR4iCH/i4L5sqhUE7jtlk4H4jiKn3w03iYKKl2wxZG4hgIMpTEP2Cl
         h98Jppz5ygh1ZRpjfu8Bn7wVjuYZC5Jb2z7mr7HEdf2s+0D5oBW/BEicpy5eCmUSSZ9P
         SCWXyo8kQ5bQHCgb1mBTaBZd+gRQUYnbhYms7teAOTTEIcYioxR799mB5YbW8Y9PApIf
         /oQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        fh=GdCRveg6tlG5IpEWaGI7uw5P0Wqdr3OXOxOOUtgVgnU=;
        b=jcwUpnQNBf5j1SpxuBywZbor7uSTooO2sVleKFyd09nUS61OMyXDycwIxcTMTwRSAd
         Ke23lC8gppiW9NaIt1DNHCRwDRaZLnYu0M4mWO6bLBmtuQQeE8/36uJFCbhT4lzbC3uz
         KKY03Ql6KqBHgIAnx0YlGOlIEOd3hJpgdWv/L2JiRdYYRgiYvXoHw9ls2kjcBPKIx6U3
         a/ICdsxNUYbBobe7LcJU8gh1f+fO33UUn4QZeYZ+QadKJg8RmmttLrMJb4NpVejdUC+X
         Z+9Je2KV7S+wri9q4D7MKEnwDfzP1c4U+2Ax5jeMeya+3dYbetUKaADgLU7mkOfzUt63
         mX0A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790888767; x=1791493567; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        b=DN/VIJm/TVF33kWwQQj8JT3e4luI0EuPjE6obgYGddC8GUaWXvnLl0Af6mkX86sDhS
         sSVcpoHXrF0CkHCNh/XL04L3PoTDInpKTuj9/niTRjVlZo0qSVLynAd0Jo6AJIFIPvS2
         +BYTfjfdyjDd5FVRmCwTVvYsUT0/FEDxZh+EQIj2l1LXjEmLoU+QyTPqs1FY5ZHrlT+o
         xWYIo8/5+r1qQMI/lr+nLSi0aeztrvufqRJQwO7W5vJluz/mAnh197hH0nO7qbJDV72W
         odjOXXjcYwtJfmLfLLZAaMa2QzwHxGgqpTGpJ9Z2zAn94D+QqFd2ghoErT5GzNT2Ucvg
         AIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790888767; x=1791493567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        b=fM0feMOQo23YWESE2dSzk3UGexpF5Gtg3r4TH2WgKO+afH57zh93+tgg42WUjJ010K
         4Srm6g3/QKF1WtaH4ONfAA6m1UJ3BxAB3P3djr4jLAWGPa5Wt2Thwso+qDBNSIFmEz2S
         Va47ZU+aoxROPmo8rfzFUFp8zQz4pXLSCM6wdoTB3uKGU2IRoZ4T6/kpousv1XxKYAeg
         2UmPy5pwocJZ41cQZiP7xhQW2M6oUM8w1kLh3dPC0Q0iGDiUH9Qa7b2IOFs5B7KRMxEJ
         7O0x9I1ci7l7oIGAHLx1Q+aO9yMmQW2mznDURsuIT2o4BQLJ+vNjw3ubMfblm8/BH2TY
         k+cg==
X-Forwarded-Encrypted: i=1; AKwUvBxFW439BYQlFMzPkjmOPmD82OoNQQop/COFjujlvVY30FCVW/jVjxQLyz0UddEqjXcorRlD1qCO5g==@lists.infradead.org
X-Gm-Message-State: AFuF++kTfYQJdve1zWXuy5RK0KE63B+fKNY/5FbEdirgJf/LAIE7VjC8
	LU57h4UwlvZIkWoApyhEbYh9O2H8iN0T06bqO7Z7Q+m6pkiWFmVIZscVTsaUMus2/RmG67dXqUn
	LyXXk2bqzLf97wqN+pqVp0d7Vf7UAjZruM/Y+f7l6
X-Gm-Gg: AYBFou1+nqbEY5fr8sLqyFlKGf5D84/blwxLQlWpuvApR6Hn+moYE4pC+E/KAlMEkXb
	eITaONVUpfP/soLOGTMAV0K9zSPRKSrMZoijvwgPsRbnW4GKaDST6PmCocEyJ71hFyiWfUHP6+7
	yVd1mQmLkjQLRncYcC9n2fupn4ukUJEpM4tjfgG1YSWKTy36SY4yKV8KMbRCIb5KgAuQCHw0YqB
	A1QrjHUqJIi807ml6UuIufzgl4p834chdtGIfnEN7vk74/5wOVhL70TpVTf2v023Tb3w3MHAzs1
	BWbaPp9TRukX/wvKD7PdzVb+Ot3X2+OUbmb8GAORxOqYiSSKoMJzyJfsdLuCghp2oYNwxQ9vrnb
	8/6ZZ3+REEoYf
X-Received: by 2002:a05:6a00:1254:b0:881:5dcb:400e with SMTP id
 d2e1a72fcca58-88af6d24f34mr727169b3a.56.1790888767004; Thu, 01 Oct 2026
 14:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com>
In-Reply-To: <cover.1790088067.git.rrobaina@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Oct 2026 17:05:54 -0400
X-Gm-Features: AclHuK923qNeclwyxHc-N96rTW9f--kU_8IWc_3FVDcJfFTXqnWMr4asd_Mjppw
Message-ID: <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_140610_809383_2144B668 
X-CRM114-Status: GOOD (  21.48  )
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

On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
>
> The SYSCALL record currently logs only four of the six syscall
> arguments (a0-a3), silently discarding the remaining two. This
> leads to the need for auxiliary records when audit-relevant
> data lands in the 5th or 6th argument of a syscall.
>
> This series extends the SYSCALL record to log all six arguments,
> by adding arguments a4 and a5 inline within the existing record.

Thanks Ricardo, this looks great!

There are a few things in some of the individual patches which I reply
to in a minute, but there are a couple of "global" things that I
wanted to mention:

* As pointed out by Sashiko, when you were converting all of the
arches, it looks like you missed alpha.  I took a quick look and it
appears that it should be a pretty straightforward conversion like
most of the others.

* We need to get ACKs from all the various arch maintainers.  Aside
from the parisc changes all of your arch specific patches are trivial
(and cleaner than the existing code IMO) so I don't expect anyone to
complain, but getting ACKs will likely take some time.  Even the
parisc patches aren't that bad, and arguably they fix a problem for
seccomp so that should make asking for ACKs easier :)

Since I expect chasing down all the various maintainers for ACKs will
take a little while, and I'd like to start getting this patchset some
basic testing, I'm going to merge it into dev-staging now.  While the
dev-staging branch doesn't feed into linux-next (this isn't likely to
land in the next merge window) it is one of the branches that gets
tested automatically and included in my kernel-secnext RPM builds.
This also means you won't need to worry about keeping this patchset
up-to-date with rebasing, as I rebase dev-staging as needed (it
intentionally isn't a stable branch).  Going forward, if there are any
minor changes to this patchset, e.g. a few line change in one of two
patches, please just send a fixup patchset based against
audit/dev-staging and I'll squash it into the relevant patch in the
series.  However, in the unlikely event that a major rewrite is
needed, just send a new patchset ... but I'll be very surprised if
that happens here :)

--=20
paul-moore.com

