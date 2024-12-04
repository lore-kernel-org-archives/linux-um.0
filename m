Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49042E77170
	for <linux-um@archiver.kernel.org>; Wed,  4 Dec 2024 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H0X0sNPCrJqwTvoBGYtmJtPy6vxfccD6F8TWaB/1oAQ=; b=McIW08DKOAIKNhdtkdd0yGcVtj
	rykf+cf5bBabSUbtMOOeG1xZm+0EMhpHP4dAIq6AE2g0NeKAnxqTKkqqeKS49dgiUK79VRQhcQFNl
	du2g2D4m326GmeXsnjSx3jq1ivmxAtgiL33oatZaRyAoW3adoFkm1XDm7Wgll54E+xXEpLA+pj17+
	n0wAHvFqCy4RB2naImZqGhJe2xYqOs8gAB7UG2HCuG7ah6ETzK99/nP5WUsNoUp074mJaRQXYmcYv
	R/I9AUgB22mRBwQAtu8rv8D87gTg4jXYy6NEj/ovCnpPvbLRMQHRNxLk0iKCMfOJ5jUX54mlqU37c
	pmk3rWMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIsNM-0000000DDCk-0Cih;
	Wed, 04 Dec 2024 16:37:20 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIsNK-0000000DDC1-1dNy
	for linux-um@lists.infradead.org;
	Wed, 04 Dec 2024 16:37:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=H0X0sNPCrJqwTvoBGYtmJtPy6vxfccD6F8TWaB/1oAQ=;
	t=1733330238; x=1734539838; b=c3yzcWpQpd8qUkwQHJa1dISQeX8lDdQeHszgiWDHOdmsh6X
	115XsoOOJzksHeZG4iCbJFs9W10cMBm2RzQTeJyFmIaMunizjzJ4iG79N4c47FA3aQLZ/iLKISQRR
	6Oosyn2tbfKOoY/80rCPlrAuob83Umuf22pCqmMH312D35J5eie1ZEHR7gC8vCrXT0bmGPvsK+DG0
	PSGSch+ywcKW/+8QMBoNP22y5ujMkn9gJKZpfudt5OoZyCKD11UxNdSu/yeG3SaPVl302Si5BU+cu
	6p5eAoS6TZGo1XU2p6x1U83twq693PfQ+5bN52vcEam638y5Fy8ANc7Emo8TWp6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tIsNH-000000076sS-1rxw;
	Wed, 04 Dec 2024 17:37:15 +0100
Message-ID: <4628fa35659910f21e38087a96953975a7dbe0fc.camel@sipsolutions.net>
Subject: Re: [PATCH v3 04/13] x86/um: nommu: syscall handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com
Date: Wed, 04 Dec 2024 17:37:14 +0100
In-Reply-To: <682460c3db1967aaa041b7e14342d48be3604c04.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
	 <682460c3db1967aaa041b7e14342d48be3604c04.1733199769.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_083718_425424_2FB540F1 
X-CRM114-Status: GOOD (  12.37  )
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

On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
> This commit introduces an entry point of syscall interface for !MMU
> mode. It uses an entry function, __kernel_vsyscall, a kernel-wide global
> symbol accessible from any locations.
>=20
> Although it isn't in the scope of this commit, it can be also exposed
> via vdso image which is directly accessible from userspace. A standard
> library (i.e., libc) can utilize this entry point to implement syscall
> wrapper; we can also use this by hooking syscall for unmodified userspace
> applications/libraries, which will be implemented in the subsequent
> commit.
>=20
> This only supports 64-bit mode of x86 architecture.
>=20
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Ricardo Koller <ricarkol@google.com>
> ---
>  arch/x86/um/do_syscall_64.c             | 37 +++++++++++
>  arch/x86/um/entry_64.S                  | 87 +++++++++++++++++++++++++
>=20

As I said before, I think it needs to be something obviously nommu.
Maybe in a new directory, or maybe nommu_syscall_64.c or something like
that.

Also needs comment style fixes and I'm not sure about all the
pr_debug(), but I guess they don't matter unless someone defines it?=20

johannes

