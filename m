Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2D6CA100F
	for <linux-um@archiver.kernel.org>; Mon, 22 Sep 2025 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4boiJmYSJNRhez+0ST5UcGBZ3m5jTxEHMhvYrFzRwSs=; b=e+wYxgE9vwVFhhvE3zS2fsylQ/
	AelIQo6lDHxv7/vlP1jg4T/MnDgLSOMms5ZCclsRP6phaZwMRd/oCCNpYsEb4onRq0CLsHTdnwAmt
	Ok3W8pAGgQcx2MGoMEAcPGf6h8BvnXDqXUNHHjr5uOMSR3SNhkao0fla1+Gf4U/OUIZd/ejwziK0R
	N0ius2zubUhkyXKjNesjvq0jnfQob46PfiVQmZcGmIC+4d9df345SjgZL46MbfjPMQGsgxoxaUp1W
	A5Kx4qQgeiOvzjXvRBKGLvUoZYvSzRuK/vJHy3VIYS7iM0JnfTz2woXpbXFFq8DQotV9S5If6yvf7
	wCovGUAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0iFL-0000000Am99-164F;
	Mon, 22 Sep 2025 15:14:31 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0iFJ-0000000Am8B-3G4n
	for linux-um@lists.infradead.org;
	Mon, 22 Sep 2025 15:14:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4boiJmYSJNRhez+0ST5UcGBZ3m5jTxEHMhvYrFzRwSs=;
	t=1758554069; x=1759763669; b=GbWHoWAvcCPv6W55ldDbL8jEKjSyiqCz3GHpcAW9+j2oa8U
	uBBYxGXUTvHGUYvLIc6gTE2wiKc4iSZcfcCA09lw0TMANcB6UHTB9oQw6TAvHAS4ZiiJjgLNdzV3B
	now44oNhbuPNraUI4iO210bQq+ZrHhM7dXsEEPWH91k0soujYzM2RhQWqTDMjG7ys4xccqrvS+eMi
	7KHB8z821PtLd2XYl1W5bq5xpJc7t0pWT38PMuimbaEc6VjTSum1KixIH+NyhLZpsk2zAkPBverfO
	ag4Ot/KEeZSmF9YaJ79wcUsLN2M36lfI1CcdfC40rRjD87XGzoC5TfFq+drh3qmA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0iFA-00000004lGw-19zD;
	Mon, 22 Sep 2025 17:14:20 +0200
Message-ID: <366bb558c3fd23b9a80008d923f29ed0234e17b9.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, benjamin@sipsolutions.net, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tiwei.btw@antgroup.com
Date: Mon, 22 Sep 2025 17:14:18 +0200
In-Reply-To: <21755635-74d4-4fa4-8ffd-371c17630fdf@t-8ch.de> (sfid-20250922_160212_262231_0E1FE0F0)
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
	 <20250922045020.48158-1-tiwei.bie@linux.dev>
	 <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
	 <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
	 <21755635-74d4-4fa4-8ffd-371c17630fdf@t-8ch.de>
	 (sfid-20250922_160212_262231_0E1FE0F0)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_081429_836724_39493A4C 
X-CRM114-Status: GOOD (  18.03  )
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

On Mon, 2025-09-22 at 16:01 +0200, Thomas Wei=C3=9Fschuh wrote:
> Right now it does not provide any advantage over a regular syscall.
> Essentially it is just overhead. That said, if you do want to make a
> real vDSO out of it, I'd be happy to help in that.

I don't know if I'd say "just overhead" - depends on which path is more
optimised in a typical libc implementation? I'd basically think it's
identical, no? You either link to the vDSO, or a __weak same function in
the libc?

> > I mean ... on the one hand, sure, it doesn't really do much after this,
> > but OTOH it lets userspace actually use that path? So might be useful.
>=20
> What advantage does userspace have from it?

Right now, none? But it's easier to play with if you have the
infrastructure, and I'm not convinced there's a _disadvantage_?

> > > Also the functionality to map the host vDSO and vsyscall page into UM=
L
> > > userspace looks very weird and error-prone. Maybe it can also go away=
.
> >=20
> > Surely host vDSO etc. is never mapped into UML userspace and never is,
> > not sure what you're thinking of, but clearly that's wrong as written.
>=20
> This is how I understand the 32bit implementation using
> ARCH_REUSE_HOST_VSYSCALL_AREA and NEW_AUX_ENT(AT_SYSINFO_EHDR, vsyscall_e=
hdr)
> where vsyscall_ehdr comes from the hosts getauxval(AT_SYSINFO_EHDR).

Huh, hm, yeah I forgot about that ... 32-bit. Yeah, agree we should just
kill that. I'm not even sure it works with the host kernel trapping
there? Oh well.

johannes

