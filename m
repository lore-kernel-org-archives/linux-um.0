Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA14C3ABCB
	for <linux-um@archiver.kernel.org>; Sun, 11 May 2025 19:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bggfRofGtQv41sMq7DiElPPeAu0aUPI8Xjg9f5re5GQ=; b=mCfJjc8ZSrXDo2u4IgLu/cEbEJ
	k2pGp0XKUo21wwooomyLwjuAFnlNYyxVOfPArUDkQDo64RQe04Fk2beTXe1oqZaDb238QoiMTUYtq
	6anYHi9cTAu8rPfEHYIrz0H8tWq+5qCoCMlHKRVzCMrY/oRYDD0zUKvJGi/XfXAVzw7twWUQB6ZhV
	f71z6l7r34mrVuUvthCjvSGcfDdD5GN2VNUGsB/oqnM63oSaIk4AzKNXhX0ZJUhQSBkf3I/dJ5T6G
	1m1BWNZnWbKc1PS/tKOSXO795J7uUdfm8oEDT1wCjoE16+blSYjjMJooeGCKOBx1G8DYj03OUFwUn
	vv1BuecA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uECGu-00000007jGj-1GLD;
	Sun, 11 May 2025 19:23:36 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uECGs-00000007jGE-03kI
	for linux-um@lists.infradead.org;
	Sun, 11 May 2025 19:23:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bggfRofGtQv41sMq7DiElPPeAu0aUPI8Xjg9f5re5GQ=;
	t=1746991412; x=1748201012; b=OOkLf1RxdPzF4w2qKeyueCQ8bGq0ODs8ZSkhayOAfQb/9wW
	U/MW2TPPdKSMR0d/pEw1LP/nxdvf794vqw5MmPkvfH6RjbrTUbn69OCE+YeKK6/kKKoKVjjDvHD4W
	aCbR4dKwsttwkoAd8d8aYN5nR1fgkNc8Bokp9Of22n/7Oaz321M3L4JzpSLeboX5331EvuUIqb0JQ
	T6THkUQhj+NR5SrHhKoOh8Ca3rns25fAjdQVFYb9dZcTd4ZV6F90BjTgibfyjcoQgat6fsqcgbPmN
	e6v6cpVb3o3L5XIzVC15OGIJiLQSO/y4SLod0HcnFDTAKlxzGhftnknLvm1Cx5Dw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uECGm-00000001bBk-3lWn;
	Sun, 11 May 2025 21:23:29 +0200
Message-ID: <b09d6b4ef6291a2109dd7e1bada4ecff931a553f.camel@sipsolutions.net>
Subject: Re: [PATCH 6.12] Revert "um: work around sched_yield not yielding
 in time-travel mode"
From: Johannes Berg <johannes@sipsolutions.net>
To: Christian Lamparter <chunkeey@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Cc: benjamin.berg@intel.com, sashal@kernel.org, richard@nod.at, 
	stable@vger.kernel.org
Date: Sun, 11 May 2025 21:23:28 +0200
In-Reply-To: <20250509095040.33355-1-chunkeey@gmail.com>
References: <20250509095040.33355-1-chunkeey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250511_122334_058820_EC878E5F 
X-CRM114-Status: UNSURE (   4.77  )
X-CRM114-Notice: Please train this message.
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

On Fri, 2025-05-09 at 11:50 +0200, Christian Lamparter wrote:
>=20
> What's interessting/very strange strange about this time-travel stuff:
> > commit 0b8b2668f998 ("um: insert scheduler ticks when userspace does no=
t yield")
>=20
>  $ git describe 0b8b2668f998
> =3D> v6.12-rc2-43-g0b8b2668f998
>=20

Come to think of it, often you just want "git describe --contains":

$ git describe --contains --match=3Dv* 0b8b2668f998
v6.13-rc1~18^2~25

johannes

