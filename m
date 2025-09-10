Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAD7CA101F
	for <linux-um@archiver.kernel.org>; Wed, 10 Sep 2025 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CPMluIxzYTxyo+SE1q9wxQ767RFtvJEbmf1nP5T/LRk=; b=KukAcr6RndkbJa48ywHeFIlpeV
	93S1OrnTA4Qp1E5bIC6CpOZfKXSPodmkQregWftkB2J7+UuqrVWlVLjpggbEF/OLV+46xEd4L0mvF
	DH+sKV1TykT2Ckulm5rhegf3UWI44VbC4/Y92Drf/wzLh60ROQpu+Iww1+Ys7jAhum2rK2OBFm27J
	e6lgGTrnt+6Zb6e7bJtImTj9Cx9D4wjspCdMd4cGHksjBN+cV6jRXrosflHBkEz7r6ibavdpOGknA
	m4nqxtJTnn670SLMKA0PuCk+4sgdH0lRaOmtA8pk41XsAzvBcfD3lwjGWKaLD+13AhdVXYVre2niN
	rI5AmbWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwJjb-0000000E2tM-3OTH;
	Wed, 10 Sep 2025 12:15:35 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwJja-0000000E2rs-1QFr
	for linux-um@lists.infradead.org;
	Wed, 10 Sep 2025 12:15:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CPMluIxzYTxyo+SE1q9wxQ767RFtvJEbmf1nP5T/LRk=;
	t=1757506534; x=1758716134; b=gPGNSrOrgpEUhdtrw093CMEpPcrZdTW17diExXmt2cs9BH/
	KrTmNgsWGj7QKBfKBF5xdutUHw1X6fhusG9iUrQdM+9V7dcHe5+D9MuH6ds+EoZkrrDGbi1WDG/gH
	QCQNp2S/MYpjq5ND9DoeXxgqQ+OE6HiOb43p5sndXscu/K76WlmPmOtQyCKbTrXUqNZuZJvBDalVj
	LfeBc5NyMRgUsd3oxx1l36N2ghiLC2tOHNiKJJgKu4advehHHPMeTYP5UaLYiMvDw7MWlrKYefyK8
	jHDPfAbgbyob+eRR5DbKI03Ujs184sioBbIkDs+z6Wd3iHsRLGrE0KWirDpVxZuQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwJjV-0000000Colo-2YFT;
	Wed, 10 Sep 2025 14:15:29 +0200
Message-ID: <f402a7b5ddfe92a8fbbc1460102cac7b5a5864b5.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/10] um: Turn signals_* into thread-local variables
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net, arnd@arndb.de, tiwei.btw@antgroup.com
Date: Wed, 10 Sep 2025 14:15:28 +0200
In-Reply-To: <20250810055136.897712-5-tiwei.bie@linux.dev> (sfid-20250810_075242_713590_DCDE368B)
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
	 <20250810055136.897712-5-tiwei.bie@linux.dev>
	 (sfid-20250810_075242_713590_DCDE368B)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_051534_373653_9BB44CBA 
X-CRM114-Status: UNSURE (   6.76  )
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
> Turn signals_enabled, signals_pending and signals_active into
> thread-local variables. This enables us to control and track
> signals independently on each CPU thread. This is a preparation
> for adding SMP support.

[...]

> +static __thread int signals_enabled;

How much glibc infrastructure does __thread rely on? More specifically:
Some time ago we had a discussion about building UML as a nolibc binary,
what would that mean for the __thread usage here?

johannes

