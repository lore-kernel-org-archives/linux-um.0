Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01A0CAC58D
	for <linux-um@archiver.kernel.org>; Thu, 11 Sep 2025 09:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PwNaTD5CzZ/PhAexouRRVC0fdccpihf9g81aqRjL+/Q=; b=j4yHo5JH59V7DLfzfDalC9m6iE
	4JNiLLD91Ffp+m3HRSiAVQ2oIY6aK53pHMLVtvT+tR+zhJocaLrC/UDg0VI2tva8U3u9ap3G+fs91
	/55y8rXKlbJXD/A7FVV2RwNwDxyk9QuMCakFe8Yfw+qYsmJDkYd7XNWR/4xMELc/niJ+EBTIR0Iif
	K+kBo+d8KeGYFvLEp25bucQwwPg5QP0M1WA0auckZbIr/ImU7iOhhBGW8Rkc2EgPYIrtNnpx4XB8V
	ZuGXrj7LymOAVAd72GSgu73sh4eWBb2QPFqg4KGzC54zoklqGQSMLTHx/9ywLWXRyivnRBoI6sbmk
	K+1F2qSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwdqy-00000002CA0-1b3M;
	Thu, 11 Sep 2025 09:44:32 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwdqv-00000002C7h-18il
	for linux-um@lists.infradead.org;
	Thu, 11 Sep 2025 09:44:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PwNaTD5CzZ/PhAexouRRVC0fdccpihf9g81aqRjL+/Q=;
	t=1757583869; x=1758793469; b=tHqBSz5H7hncJdZTihUZsTuTbdno4FV9gzIhKedAsCPisQj
	W5X6DlSskIDbPyJE0gKp/L8sVDUd1fG+e8vgewZFJGPMj6SImmDuHxwWtgBWjpm5PYfU5g+/8vlXq
	jv6MpMbnbird7doavli1D4I/LnT/MDsABaF0EPtYoJKL9oJQdUHzQWVBrZpKc3FXn4HTS07vlcBUw
	TzcSItsKj0/Y2IDMe3MdR1tehTUHUSk+uN3gVKeP+uqq5AfjLUSD86lU3EWMLy4oaEwyrZkRsJWcK
	fmOemLFOk6Nzu3oWFVoGT6zT8iKtt+p3viV+Pcst6m5xl4m6FgU/pBiVCP4xNGoA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwdqo-0000000F21B-21cf;
	Thu, 11 Sep 2025 11:44:22 +0200
Message-ID: <b1a57068ec7578d20dcb3b28234e4ce7ec216657.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, Tiwei Bie
 <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tiwei.btw@antgroup.com
Date: Thu, 11 Sep 2025 11:44:21 +0200
In-Reply-To: <3c4bc989c4f10609eab699b26e8331bc878c2a0a.camel@sipsolutions.net>
References: <f402a7b5ddfe92a8fbbc1460102cac7b5a5864b5.camel@sipsolutions.net>
		 <20250911043434.2897892-1-tiwei.bie@linux.dev>
	 <3c4bc989c4f10609eab699b26e8331bc878c2a0a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_024429_309591_F7C5B4ED 
X-CRM114-Status: GOOD (  16.81  )
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

On Thu, 2025-09-11 at 09:37 +0200, Benjamin Berg wrote:
> Hi,
>=20
> On Thu, 2025-09-11 at 12:34 +0800, Tiwei Bie wrote:
> > On Wed, 10 Sep 2025 14:15:28 +0200, Johannes Berg wrote:
> > > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > > >=20
> > > > Turn signals_enabled, signals_pending and signals_active into
> > > > thread-local variables. This enables us to control and track
> > > > signals independently on each CPU thread. This is a preparation
> > > > for adding SMP support.
> > >=20
> > > [...]
> > >=20
> > > > +static __thread int signals_enabled;
> > >=20
> > > How much glibc infrastructure does __thread rely on? More
> > > specifically:
> > > Some time ago we had a discussion about building UML as a nolibc
> > > binary,
> > > what would that mean for the __thread usage here?
> >=20
> > We would need to parse TLS data (PT_TLS) from the ELF file ourselves
> > and properly set up TLS when creating threads using clone().
>=20
> I guess right now we cannot use PER_CPU variables in these files.

Maybe? The only thing would be to know which "CPU" we're executing on?
getpid() is async signal safe (i.e. you can call it), but there could be
better ways of doing this such as setting different signal handler
functions in different CPUs.

johannes

