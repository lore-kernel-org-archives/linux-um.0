Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AE4D1AD45
	for <linux-um@archiver.kernel.org>; Thu, 17 Oct 2024 08:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UuvG9Y4yG6AEzL+K8ZmQe0To4/B63crBW8iWyXKvh4M=; b=mJ80BjVENZekz+JJKuBM9qP0vN
	0zRG5pl1pYqhIP8/SgkKPEmefEA8EqUdDRqrLxlPB+FFk2EDpBi5xatAsBcyK6isvXZp4/hXjQQxY
	ahOKt0PwR8fBtTTQu+diEoiDlsoptvzQ4ALzDKjda356qf/5Uj8fQ4zwbzFF9QZniOcZ8AfxJbfcw
	I35fh3o+VxsBgMqAuqvAhFyZHwG4aEVTGKQpxy6TJwlYx6e7quCp4MlGIudXDb9+3AbtBsCf9HVFc
	U5qaGuWpzOJ1NxywtP5k5Ai4ErJW9dwVEfJQXKupOmLFBHun6NGsdu5w7/DArn5lwcViofnBy1y52
	SnGMk3gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LiU-0000000E9Uo-1iZ3;
	Thu, 17 Oct 2024 08:18:42 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LiO-0000000E9Q3-3mZM
	for linux-um@lists.infradead.org;
	Thu, 17 Oct 2024 08:18:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UuvG9Y4yG6AEzL+K8ZmQe0To4/B63crBW8iWyXKvh4M=;
	t=1729153114; x=1730362714; b=mMCM8+CcDYmAKvZghvKLCZRtxHGoo47lCAB0GSWLHI/oIlB
	FaVOibjhulGuIGwXQ+ajxhSmj6FWj/4HjDxOv7tJD326Zoan3PhYIvBiljfDW0AKYwWB+r55PJ9G6
	255sVDUtO6MRGaz+OnfpQmzd7wVDjTX+I/khPH2r7NR8Td+9KgscFzfP+PJG9uG0MmSkDCo54N8hV
	mgHb6507sjvi+yBNWKbKPGF4wPRKGYCypv1y4m1sVQeA+GI4tXTyAQDEBopMTUsjqQWKQwKeH4w6S
	GAYzH8Jb0Im+11brfYbuf5FwY5lVXh+ZcaOKHgu8y/0VudagXBtVWRhpsw6podqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t1LiG-0000000Do7V-39hP;
	Thu, 17 Oct 2024 10:18:28 +0200
Message-ID: <49ef8267b4c2cbce11698a377330d92327b332d3.camel@sipsolutions.net>
Subject: Re: [PATCH v9 02/10] um: use execveat to create userspace MMs
From: Johannes Berg <johannes@sipsolutions.net>
To: David Gow <davidgow@google.com>, Benjamin Berg
 <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Benjamin Berg <benjamin.berg@intel.com>, 
 KUnit Development <kunit-dev@googlegroups.com>, Kees Cook <kees@kernel.org>
Date: Thu, 17 Oct 2024 10:18:27 +0200
In-Reply-To: <CABVgOS=boUoG6=LHFFhxEd8H8jDP1zOaPKFEjH+iy2n2Q5S2aQ@mail.gmail.com>
References: <20240919124511.282088-1-benjamin@sipsolutions.net>
	 <20240919124511.282088-3-benjamin@sipsolutions.net>
	 <CABVgOS=boUoG6=LHFFhxEd8H8jDP1zOaPKFEjH+iy2n2Q5S2aQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_011836_989360_8A15FFB8 
X-CRM114-Status: GOOD (  16.44  )
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

On Thu, 2024-10-17 at 15:17 +0800, David Gow wrote:
> It turns out that this breaks the KUnit user alloc helpers on x86_64,
> at least on my machine.

Yay, second bug from this ;-)

> This can be reproduced with:
> ./tools/testing/kunit/kunit.py run usercopy
>=20
> Though the 32-bit version works:
> ./tools/testing/kunit/kunit.py run usercopy --kconfig_add CONFIG_64BIT=3D=
n
>=20
> The error we're getting is:
> start_userspace : expected SIGSTOP, got status =3D 139
> Could not create userspace mm
>=20
> This basically is the result of the stub_exe segfaulting very early on
> in its execution.
>=20
> It seems that this is due to the stack being misaligned, and so the
> generated SSE instructions are faulting. The workarounds I've tested
> here include:
> a) Build the stub with -mno-sse
> b) Decorate real_init() with __attribute__((force_align_arg_pointer))
> c) Decorate __start() with __attribute__((naked))
>=20
> The last one seems to validate my theory as to why this is occurring:
> __start's prologue is misaligning the stack, as __start is not
> actually _called_ from anything, so there's no 8-byte misalignment to
> hold the return address.
>=20
> If this makes sense, I'll send a patch out with whichever the
> preferred fix(es) are. My guess is that (c) is the "proper" fix,
> though I'd not _miss_ SSE if we chose to disable it for the handful of
> instructions here anyway.

Interesting. Actually somewhere here while reviewing this, though I
don't remember precisely if it was _start, I thought we might need
__attribute__((naked)) to ensure we don't get extra things, but I let
that thought go since it seemed to work and I didn't wrap my head around
it too much...

I wonder now if the SSE instructions generated are memset() and that
goes away with the patches that Nathan just sent to not have the memset
(which was due to -ftrivial-auto-var-init) in the first place?

But anyway all of these pretty much sound reasonable. We don't need much
to happen in the stub here, simpler is better.

johannes

