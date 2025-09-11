Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBB2CA1016
	for <linux-um@archiver.kernel.org>; Thu, 11 Sep 2025 10:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hvOZY8Zm8Xu9d/QPkVVnky/0m0Z0DyGiA59b6hOBpMo=; b=CnXiGRVpafm5JXaijJLQZ+47wl
	Owmck2aUjo0RzSeBh1WHCrsek96HYkxHPPIdNBhqGxT29LHNvYrPH9Mtp1wHZfEExesAmV1TUA4DL
	qmBvCsbz8/QblRai0s+ly0DiGkSLiR/sXSMHOptSlJuJUD5ZMQ/5l6F7fwgarUqowaSorbYxBkJ3z
	94lyxarURzqgKicISPCMbEDlolsvaAckzFU8Ko+xJ+csGqN55j0mpJfqABnlpzc4V8wqTyvIpLDwg
	5UdfLZ30GJvWwlPQL8CUcZ3jwG595KRjAj6qAB4roHHuwqCw0tAMZCc6HXkAQ0GdptbEfvgGDnjQa
	L4yVAjAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwee1-00000002Pap-0zpC;
	Thu, 11 Sep 2025 10:35:13 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwedz-00000002PZG-399D
	for linux-um@lists.infradead.org;
	Thu, 11 Sep 2025 10:35:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hvOZY8Zm8Xu9d/QPkVVnky/0m0Z0DyGiA59b6hOBpMo=;
	t=1757586911; x=1758796511; b=rOGR0CCCM909bfjQCezQglDYSTcjKjRbbbui+c/25Y+69wr
	GF3hTTvudc3AckwMS6ml0u6KCa/jyCYDeocrXOd/lsNPCEfdfbKq/ff98BBbcYX55FQkJ9EFhAZ3d
	dsVXsnM43JyFMdg89CaTouzs6t/pnabUY2RFZniuu5gjg+n9trpMWmE7+FpUbzjcAFXraLtgPqieG
	fdsB/M+PP2TrNeU3zLQp3zSQ/OY/0I90OeYaAzaeCDMaMPd4ijX+4Ka3H64SuzZBp88O+9l/gAEcJ
	GKmRclS7kRczplDfuGt6Wvq+yyG5GbLpsFpNa/SD2/Yie991+cZx6UN4A7pvCHfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uwedr-0000000F6oE-1dg4;
	Thu, 11 Sep 2025 12:35:03 +0200
Message-ID: <263b95a673f92d1436ece3913b134f81eef3355d.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, Tiwei Bie
 <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tiwei.btw@antgroup.com
Date: Thu, 11 Sep 2025 12:35:02 +0200
In-Reply-To: <b1a57068ec7578d20dcb3b28234e4ce7ec216657.camel@sipsolutions.net> (sfid-20250911_114423_984872_A9251D1F)
References: <f402a7b5ddfe92a8fbbc1460102cac7b5a5864b5.camel@sipsolutions.net>
			 <20250911043434.2897892-1-tiwei.bie@linux.dev>
		 <3c4bc989c4f10609eab699b26e8331bc878c2a0a.camel@sipsolutions.net>
	 <b1a57068ec7578d20dcb3b28234e4ce7ec216657.camel@sipsolutions.net>
	 (sfid-20250911_114423_984872_A9251D1F)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_033511_790479_E08CA633 
X-CRM114-Status: GOOD (  23.56  )
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

On Thu, 2025-09-11 at 11:44 +0200, Johannes Berg wrote:
> On Thu, 2025-09-11 at 09:37 +0200, Benjamin Berg wrote:
> > Hi,
> >=20
> > On Thu, 2025-09-11 at 12:34 +0800, Tiwei Bie wrote:
> > > On Wed, 10 Sep 2025 14:15:28 +0200, Johannes Berg wrote:
> > > > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > > > >=20
> > > > > Turn signals_enabled, signals_pending and signals_active into
> > > > > thread-local variables. This enables us to control and track
> > > > > signals independently on each CPU thread. This is a preparation
> > > > > for adding SMP support.
> > > >=20
> > > > [...]
> > > >=20
> > > > > +static __thread int signals_enabled;
> > > >=20
> > > > How much glibc infrastructure does __thread rely on? More
> > > > specifically:
> > > > Some time ago we had a discussion about building UML as a nolibc
> > > > binary,
> > > > what would that mean for the __thread usage here?
> > >=20
> > > We would need to parse TLS data (PT_TLS) from the ELF file ourselves
> > > and properly set up TLS when creating threads using clone().
> >=20
> > I guess right now we cannot use PER_CPU variables in these files.
>=20
> Maybe? The only thing would be to know which "CPU" we're executing on?
> getpid() is async signal safe (i.e. you can call it), but there could be
> better ways of doing this such as setting different signal handler
> functions in different CPUs.

There are a number of ways to solve that problem.

One way would be to use a signal stack and calculating it from the
stack pointer. Though I am still considering that we should use the
tasks stack as the signal stack, in which case we may need to track the
CPU that a task is executing on.

On 64bit, one could also use the FS/GS registers for per-CPU data. I
believe the libc uses FS only on 64bit, so we could probably already
use the GS register to for per-CPU data.

So, I am not really worried about this, we probably need a nice
solution for per-CPU data anyway.

Benjamin

