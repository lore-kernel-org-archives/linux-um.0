Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D62CA1016
	for <linux-um@archiver.kernel.org>; Thu, 11 Sep 2025 07:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HdnqPYodhpR04ucnmjP64RcI7avQd7r4ewcWEUbKzTs=; b=zhsWxWFU60jdOGtTvB8CF98YOy
	osZsZiYGK+CYC1WLj1bP7MjaMxwQrxzjdsyqtHmyNsixw3Sn68n2KwDqXkqaDvCxpPfSYT9nYeh6M
	AaPopmCV8CHiAHJfQdWqIUvn2xJ4fKdAFtoc6/yAJnOy0zFrYnq3aYeKoWwS7pzHrRzQyaZ0P8/gK
	rbLDLWO6w7MsR6C6JhuZwgg652RHdWYYNtSUM20anE8j7dQ/jxLej9pAqBikO6kymh1+SK3CUz5ef
	ZspJoawFZwvUQR14x3hI2RUP4ddQ9Q9JnOdxTtyy2fG23ZDC4GSsTGL6y9ufSG04mlNJRvmLl1598
	nAVL7Uww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwbHr-00000001Mwr-3xY2;
	Thu, 11 Sep 2025 07:00:07 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwbHp-00000001MvK-1C4B
	for linux-um@lists.infradead.org;
	Thu, 11 Sep 2025 07:00:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HdnqPYodhpR04ucnmjP64RcI7avQd7r4ewcWEUbKzTs=;
	t=1757574005; x=1758783605; b=lSmG0qIudA9SbSx6XC2h/69U6uJowcznwzUqaeK+Lh78KGU
	Ga2AZZ5qIEEpLIoLSeT56i1UgrqCYfmm/llKOaSa+xgH47QziJf202gQnB2I3j598Zmc9c+m/GVFi
	3yqlt2GBjesCEQVntCUR0CV5zkqs/PTm1ppKqYXBriIijQPqX6boIB2pIFNv+x9B8iQseJc8x13lu
	/swEylAqMTHQw8DA7iFeXS6jI5OQkIG53rTlUSQ/cDKGP7wuG15B5KQ8A/WvXfU18pmwo2u738P0+
	RBK7h5B98J4dgth59mg4C33hZWApHe5mKBkKS/H4nTgIRJ9qGwvOPZcelsiW4FDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwbHi-0000000Enrr-2rRz;
	Thu, 11 Sep 2025 08:59:58 +0200
Message-ID: <579899d18d5aa4422f970d28e19dc363c9ed218a.camel@sipsolutions.net>
Subject: Re: [PATCH v2 05/10] um: Determine sleep based on need_resched()
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
 benjamin@sipsolutions.net, 	arnd@arndb.de, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	tiwei.btw@antgroup.com
Date: Thu, 11 Sep 2025 08:59:57 +0200
In-Reply-To: <20250911043918.2950727-1-tiwei.bie@linux.dev>
References: <55cace5b8e1078bd04b4a1acb5df9faa6a83b6e8.camel@sipsolutions.net>
	 <20250911043918.2950727-1-tiwei.bie@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_000005_355086_A48C22A6 
X-CRM114-Status: GOOD (  16.54  )
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

On Thu, 2025-09-11 at 12:39 +0800, Tiwei Bie wrote:
> On Wed, 10 Sep 2025 14:10:37 +0200, Johannes Berg wrote:
> > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > >=20
> > > With SMP and NO_HZ enabled, the CPU may still need to sleep even
> > > if the timer is disarmed. Switch to deciding whether to sleep based
> > > on pending resched. This is a preparation for adding SMP support.
> >=20
> > What's the rationale for need_resched()? Is that somehow defined for
> > this? Is it what other architectures use? I guess I'm just not entirely
> > sure what it means.
>=20
> Here is a relevant document:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/scheduler/sched-arch.rst?h=3Dv6.17-rc5#n37
>=20
> There is a similar check on x86:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/x86/kernel/process.c?h=3Dv6.17-rc5#n916

Ah cool, thanks for the pointers. Though "1." part there is a bit
confusing, I guess I'll send a patch to reword it :)

FWIW I already applied a few patches, but I'll take another look,
hopefully today.

johannes

