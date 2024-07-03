Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E903BC30653
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 10:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OjWAKr/PCbaqwLs00pXdt4lNl8KRQf5I7npjhNbsc9Y=; b=yhKuOVTV8B9JTJAtZahRyxMmIR
	hsMwRmzUptL07R8rgd0Tj82lWhUHKiYk0MrJ89I4WUYwbQUDRAp/5L8Z4e3G0BEPea0cnRSvbkXro
	D3+l2lWuBEL4YxUrckq1BLrqs+xwHI0QmsxFK4POQDAf+BSduQF8Qdq0T/aWhxHh9csx2KVPjAnJh
	gBh0UzKF424b/MA7BFfppK3SpjdVIKkqPI3AsDX45czUSWrwKKZyB7kXETLHjtsZmTq756hD+W8Ww
	n6okaOm0dKJ+hSQMy7q3agc4kDLrtIfyCX2wYewOIrDBhpsh/8M/dGWn7i+CaMPGkrrQbWZG54bEM
	fu49pPqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOwv9-00000009gTn-2J6w;
	Wed, 03 Jul 2024 10:09:03 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOwv6-00000009gSs-2yOy
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 10:09:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OjWAKr/PCbaqwLs00pXdt4lNl8KRQf5I7npjhNbsc9Y=;
	t=1720001339; x=1721210939; b=tSrmWxeWTDX+f0lFu3QulbEGu4jouDDdskMIcX/kFEUsOgr
	zEgKyuLQWlj1EHUSADEw5A5xF9nYkX+K8of5Eigf2nhj3jvFI1NE3nz7wMUydv4opbyAaV2P58cjU
	fYQWjYfyi6XZl9TIDMkpvygWWt6hc509Uffak+71mAW7Mx/fvVnsUg74aUHbdeQij505WQjZi2hvY
	BlRMgc0VLAsfodbUuwYH9kI68v7ziBWhBLydNhJVCcEnOs6CN0SaihajlL0wY0PJkjRltDfako4h3
	qVk//sg2uIzjuhW4ixibIZKtziH7v5xcf1ghcCw51Pi2oeAGeBCz2pw0EPKd2tAw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sOwv1-00000008Zf5-1eax;
	Wed, 03 Jul 2024 12:08:55 +0200
Message-ID: <f78b8fc811194acb87c091b9064fb7446894f5cf.camel@sipsolutions.net>
Subject: Re: [PATCH v3 10/12] um: remove force_flush_all from fork_handler
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Date: Wed, 03 Jul 2024 12:08:53 +0200
In-Reply-To: <2784bb3e9de2ad88a48d8fa70b01c46e1b2399fc.camel@sipsolutions.net>
References: <20240524213718.1757703-1-benjamin@sipsolutions.net>
	 <20240524213718.1757703-11-benjamin@sipsolutions.net>
	 <2784bb3e9de2ad88a48d8fa70b01c46e1b2399fc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_030900_772118_DA8B070B 
X-CRM114-Status: GOOD (  12.88  )
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

On Wed, 2024-07-03 at 11:45 +0200, Johannes Berg wrote:
> On Fri, 2024-05-24 at 23:37 +0200, benjamin@sipsolutions.net=C2=A0wrote:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > There should be no need for this.
>=20
> "should" ;-)

Hmm, I would have expected the previous patch is what breaks it.

i.e. this line that I added:

+	/* Ensure the new MM is clean and nothing unwanted is mapped
*/
+	unmap(new_id, 0, STUB_START);

> This breaks things if glibc enables rseq. That might even be already
> broken in the sense that it might corrupt memory that's put at the same
> place the rseq was installed? But it at least it appears to still work
> without this patch...

Then it would make sense to me as the previous force_flush_all would
have only unmapped up to TASK_SIZE. While this now uses STUB_START
which clears more memory as TASK_SIZE has some alignment.

> As we discussed, it might thus be better to fix up the execve() patch
> and do that before this.

Yeah, lets just solve this class of issues with execve() first.

Benjamin

