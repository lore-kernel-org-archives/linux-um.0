Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC56CA0FED
	for <linux-um@archiver.kernel.org>; Wed, 10 Sep 2025 12:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SAJzAqzm8/wLjldsK42GZDtxANEbwfJEV1fsqIPU6aA=; b=2BC9BdH41mW2jL8PwGc8uTNkDJ
	aXA/atsxD3BREXYPRDA+TJFIGTjYUlxN1O44rTfMgNJfIqy8GWNgHJpFd91b6sm0CtT4/r0qCePGb
	Usw3axCWdTjfmJxFsTKvvLHmdOcgI+LJTkVfO79eV9gpl2K6ZjJBVzFNh6tk9Ab2U4FtXgFn7tI08
	5zQHq5EPfixYspb3rOy/SjqiQ6jbQPphvs8dmG7Dd7ixVpBC94BQbXnunwNBM7vXx/sIjUrEckrT5
	vc+4H98pwMXyOdLhvzjLOdXoReRhGGzQBca9agImaJnwoK3iXLYDeOWgxbDoIWFLKKMHsVsrzsWOj
	czRds0nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwJew-0000000E1Lq-2xE8;
	Wed, 10 Sep 2025 12:10:46 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwJeu-0000000E1Jy-2hEq
	for linux-um@lists.infradead.org;
	Wed, 10 Sep 2025 12:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SAJzAqzm8/wLjldsK42GZDtxANEbwfJEV1fsqIPU6aA=;
	t=1757506244; x=1758715844; b=r2/rEnZiyjfPYr8dA7lj1bLoTS8SEz3ZDrcY1/cqIgamQTP
	lydntIU4Yr1l3GD4wk6EL8fHVJ9xKPnNs+x4iTThI6Gnlms75HuwICtx40SX0ZCWHyuGYGGlsJi1U
	i4DsP5WB9mlz9G65eduGDrKfwKENbLkWWlCqTrLeO2WdrgYyWxQNZi37gso8hw4zHbLgg4uu6kjK9
	UCy7upB9fgMkxmiTXZB8MwVwtkGHlm8vhhtLrHUWAhZyq2AYQ7Njb9TFtbuJ0pyxO44HKDHXfr/wn
	5O2Bbus2ZhgfjXs6Rlqo5icWCVLi+MEUwQA5FHWI5U/gXuZwUoNA8oggy02+TB7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwJeo-0000000CoJx-1M3m;
	Wed, 10 Sep 2025 14:10:38 +0200
Message-ID: <55cace5b8e1078bd04b4a1acb5df9faa6a83b6e8.camel@sipsolutions.net>
Subject: Re: [PATCH v2 05/10] um: Determine sleep based on need_resched()
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net, arnd@arndb.de, tiwei.btw@antgroup.com
Date: Wed, 10 Sep 2025 14:10:37 +0200
In-Reply-To: <20250810055136.897712-6-tiwei.bie@linux.dev> (sfid-20250810_075306_773702_0F58F2CF)
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
	 <20250810055136.897712-6-tiwei.bie@linux.dev>
	 (sfid-20250810_075306_773702_0F58F2CF)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_051044_680620_F9A4E76E 
X-CRM114-Status: UNSURE (   8.17  )
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

On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
>=20
> With SMP and NO_HZ enabled, the CPU may still need to sleep even
> if the timer is disarmed. Switch to deciding whether to sleep based
> on pending resched. This is a preparation for adding SMP support.

What's the rationale for need_resched()? Is that somehow defined for
this? Is it what other architectures use? I guess I'm just not entirely
sure what it means.

johannes

