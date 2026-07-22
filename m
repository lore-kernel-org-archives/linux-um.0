Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C571EC4452D
	for <linux-um@archiver.kernel.org>; Wed, 22 Jul 2026 07:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1H7aEXK0x6mRwxyB5LvlwVmHFEMmdKncNYzC7iBD1dQ=; b=cuXuCpXvqtFVPDenw9NA+s7Z+B
	wCPli3SdRshQ7bZWQEoPUVxazkkw0vHB51nYOxSyY50xx85hGCJVtD1IfCjBf57ExsTx3ve1U2y4z
	T1nA+APInK+aXlvUgEnYXOiRhqxds2SFgZVoj5118SaeEgXmjHnHaP/rH1++Fa3CgNVDAM/V1TixV
	Uh1vGyAb0Goo9JywgJQk3P4EK0BjHw6DtvFKO7aukFBTIpFErYuMYJ21Zy0Yamh1GGl7XFgd8N71b
	OsZkfRbcyPpOapRJEsf5w8ix63NWg+yflNyVCrWwlnmyy8UE2Au/4Fq5NJ6yywrmqtSEAh2wXoC+r
	D0sZ1giQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmRf5-0000000B908-1kGF;
	Wed, 22 Jul 2026 07:46:39 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmRf3-0000000B8zm-1otS
	for linux-um@lists.infradead.org;
	Wed, 22 Jul 2026 07:46:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1H7aEXK0x6mRwxyB5LvlwVmHFEMmdKncNYzC7iBD1dQ=;
	t=1784706397; x=1785915997; b=WR794jt2voMga3dl9siw+Xff7mavEpbFKyGcYoR6GleFbdQ
	P9VvdbPfrJtcQLy+ebeu6ke0YCSx1jhhUqc1GhZ8xR1IfM4reUeMc1AzH3aRibxyzShd4tQspiyan
	g/guiJIq3cBQPL9+wUnUlvL9Zl8vvkhDrNZ4a0k6mJrzqflXm22vBfOBGStX6QsrbWZ1v5MpN4fNW
	TVBVplIAEctZpC3iC0SKWlMCV3QbyNw5EHpXaRKHlwRjvSscFwLMiyVS7v8xT8GMCvIFBkxspc/hE
	6q/Fqe6DLL0zBpcENigEK4255xDaTacMiSk8qSctXaHPrKLMmLV9DVbmNT/gVYvw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmRey-00000004bt9-1avc;
	Wed, 22 Jul 2026 09:46:32 +0200
Message-ID: <860318a2d3434c35c3bf188776093cb46f2fe152.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 0/9] simplified UML/NOMMU approach
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org
Date: Wed, 22 Jul 2026 09:46:31 +0200
In-Reply-To: <m28q735044.wl-thehajime@gmail.com> (sfid-20260722_023912_379022_3E549241)
References: <20260720185103.530603-11-johannes@sipsolutions.net>
	 <m28q735044.wl-thehajime@gmail.com> (sfid-20260722_023912_379022_3E549241)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_004637_474187_006DB2A9 
X-CRM114-Status: GOOD (  20.13  )
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

> thanks, this is really nice.

Thanks for looking!

> I quickly read the patchset and found that [RFC PATCH 8/9] is the core
> of your idea,

Right, of course. There's a bunch of prep work, and I obviously picked
up a bunch of your prep work too.

> I also understand the need of futex implementation instead of
> asm-generic, which only works with !CONFIG_SMP.

Right.

>   um-nommu(seccomp)        3533=20
>   um-nommu-skas           27844
>   um-nommu-skas(seccomp)  26387

I'm a bit surprised these have such a huge difference, do you see any
obvious explanation for that?

But I'm also still not really convinced that it matters at all.

> What is your plan for this RFC ?

Well, first I wanted to hear what you think :-)

> I'm pretty fine with this (skas nommu) mode for nommu UML; it
> is certainly useful to detect more bugs if it is available in UML.

Yeah, that was mostly my intent - to show a path forward for the nommu
(kunit) testing in UML, without all the other complexity.

> I would also like to ask maintainers if my nommu approach can be an
> opt-in feature only when specific kernel config is added, probably
> marking as '(EXPERIMENTAL)' or `if EXPERT` condition, as there is
> potential benefits (speed, less host process use, etc.).
>=20
> But if you (maintainers) wish and feel this as not an easy option,
> I can work for it with later patches as an extension.

Personally, I've always mostly thought that there isn't really a good
use case (or perhaps that you haven't really convinced me of one) that
actually requires the speed benefit, but I guess I can't really decide
that by myself. :)

> btw, maybe I need a better name for (my) nommu code using different
> syscall handling, with regard to skas (i.e., separate kernel address
> space) mode (e.g., CONFIG_UML_NOMMU_SAS (single address space) etc.).

Oh, I didn't even remember now that "skas" was meant to mean "separate
kernel address space". To me this is all a quirk of history ... we
probably shouldn't read too much into it now.

johannes

