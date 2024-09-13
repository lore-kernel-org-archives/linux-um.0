Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CACEEE26C
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 12:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bnnjkq8VVGLW/XZNamGqzzdOkz/C4W7MnsVbV6aZvWA=; b=aspMhGyrq2G8QactwqsfzAJZt6
	DA4KKIsyK36vtRdXQmB3Px4ZW5U+gz5BlGWv8BK4Foxv+92rNeN58xPRnk0tGQw5B+V9lntl8/gOZ
	MNTbcDa7/0sXtD9h5vYL5S5RBQ77ngur9yVrz2H7pnrjQFX9PtkkG4YYwyy/923GjNfcdKDddh/L/
	aGsNvdzeSIlEJ6obAQD5icZINXZD3sKlzmlPrVUOWpA71qDRcyt6rQh2emSdMaVDRl+XWt0B4YMps
	O63qBz1hPZdfPz29sE2xuO54WMzr/vvkEfkz1UAwOtUL9njEMzmI39JfuDPdDd6PoDs+lS8SDM4aR
	n2tnvhdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp56W-0000000FpvL-0wUF;
	Fri, 13 Sep 2024 12:08:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp52l-0000000FpN2-1hXP
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 12:04:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bnnjkq8VVGLW/XZNamGqzzdOkz/C4W7MnsVbV6aZvWA=;
	t=1726229094; x=1727438694; b=T3ycVD6zvdmjd5SSRHNfjBV3a4s8j4bhRPW53mdc4Zdl6h/
	WUFbrgGtGJPlCwKCdmRGfHsbRw3vDip0r+ehNWLrKl9zatG9xMI0keXD3CD4CrR4Fbp9wvuskKbot
	IUZISB9x4YVD/canG+zzPLCLYnb9lIBfYrMCsNJXjalf7BlZdIyThLZ619xoemjLfg5l6QNEyAc/r
	Rx/spVb7dmXOqP6+IwT7QgQ2FWGxjqHmrK8MkWZlOnoJ2jf80MIvPnQVWenYpas3u0SKK2lcWA3DV
	1N1MqgJ0RSEQqYeog7piu7WB1ZotMs3IT4qV9NAOXiM0yf91PYo9def/KMbAXkLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp52h-0000000GJ4n-3hNo;
	Fri, 13 Sep 2024 14:04:52 +0200
Message-ID: <40c069b41bb0c50105acd462b4e0950ac14ff248.camel@sipsolutions.net>
Subject: Re: [PATCH] um: add RCU syscall hack for time-travel
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Richard Weinberger <richard@nod.at>
Cc: linux-um <linux-um@lists.infradead.org>
Date: Fri, 13 Sep 2024 14:04:48 +0200
In-Reply-To: <1283369340.40411.1726228031802.JavaMail.zimbra@nod.at>
References: <20240830153825.1466691-1-benjamin@sipsolutions.net>
	 <CAFLxGvxPM9x9ay7+7Sv4wwPFKM9keZGfy9C2=5Cbk-_BUf88gQ@mail.gmail.com>
	 <0675ab7f16dc0b8f02e4c162f2e42fb66046feed.camel@sipsolutions.net>
	 <1283369340.40411.1726228031802.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_050455_470955_EFD01582 
X-CRM114-Status: GOOD (  23.62  )
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

Hi

First, it doesn't seem like my patch actually works, so please do not
merge it. It actually appears that tree RCU and tiny RCU (which are
selected depending on the preemption setting) are behaving differently.

So now I am wondering if I can come up with a hack that works for both.

On Fri, 2024-09-13 at 13:47 +0200, Richard Weinberger wrote:
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Benjamin Berg" <benjamin@sipsolutions.net>
> > > While I acknowledge that time-travel itself is a beautiful hack, I'd
> > > like to keep the hacks
> > > to keep it working minimal.
> > > So, the problem here is that RCU callbacks never run and just pile up=
?
> >=20
> > Yes. A simple example of this is doing a "find /". This will allocate a
> > lot of inode information which is only free'ed at a later point.
> >=20
> > > I wonder why such a situation does not happen in a nohz_full setup on
> > > regular systems.
> >=20
> > Had to search for a bit. But, I think the boot CPU will still have a
> > tick even on a NOHZ_FULL setup. see the nohz_full=3D boot parameter.
> >=20
> > It does look like the RCU code might try to force scheduling (tiny RCU)
> > or wake up a worker (tree RCU) in these situations. But neither of
> > these attempts is going to fix the situation as there will be no call
> > to rcu_sched_clock_irq with time-travel.
>=20
> Agreed. I think having a house keeping CPU (thread) will not work in
> time-travel mode.
> Kicking RCU whenever a syscall is executed is okay, the question is,
> are there other scenarios where RCU work can pile up and no syscall is
> run for a long time? Maybe we need to kick it at other places (page fault=
 handler?)
> too.

Hmm, that is good question. I assume that implies major faults for
mapped files (or anonymous memory from swap) happening. I suppose, that
can trigger just about anything in the kernel and could also create
load on the RCU. Not sure how problematic that is, in our case it was
python importing a large amount of files and bringing the system to its
knees in the process.

Anyway, I'll need to reconsider the hack a bit, maybe we can find a
better solution.

Benjamin


