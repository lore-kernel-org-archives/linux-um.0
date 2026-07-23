Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AF7C531CA
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 12:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HnYuyydajNOkyDo7yMJK3bEOrLzTKhCqSDD/DQcxFKM=; b=PYBLYAYr1XcqLlUGqEiHRuSRb9
	gXdRXCJUl9aKd4HZWF7KTSMg4sNfOrKMq6pqlzum35rtneF9PB5yMYN4KEUR1ojWJ5hyYSJvIvSQN
	VRdIn73QfFwvCIp7P3jNATdOp2GyAHxPQPKtvCnfaMNpV++pgwXDyGxuPlNaqp48ds6HGobgL8kdC
	nn9dChP6n8xt+6DUcVYQCPYzzHi2qFNTTVCtnhFWZXw9L3HQlq/MtF7lDEkIGBhaVEAX+lGonf6Bn
	99JRPzm2ihYjaFcoAazciFRzsRgziuWNQb56syHePPRCkRJZzeGmem4LWnI78GdJpNlPN4jwr/tK6
	VjxjHzIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmsS3-0000000EECh-1qBW;
	Thu, 23 Jul 2026 12:22:59 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmsRz-0000000EEBs-127o
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 12:22:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HnYuyydajNOkyDo7yMJK3bEOrLzTKhCqSDD/DQcxFKM=;
	t=1784809375; x=1786018975; b=tHKkTxUAi9wSMC1OSnNoMN9mp0UWE/z9Pk/Lrh2t8pnAA2N
	8RA1O5kOEgOoUSOgDGJz7U5R0KnPV9qVuHcyjTGXHFel0OhMuZT2m9AXLYsWcvOrHU866xdagWUiE
	8af2btOi0c0PzZnahbMaMBh3p8Bq7Le4FLDMkAZAzRsK1TUJ03oc2XSDH1xJBb8CieUjYZ7brE6mg
	PR+qlmhEHmJAenc/ypgfXbYJmLv67deCim9/T506Te15EBMg0u62JDvrJ49LjNtw75w9gV67lD0wQ
	najGOe24c3ojH9OqZh9fNObOB4CSSTmnvD+QUUrrmEgz4cpnqjIZhKSNak4ufuZg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmsRu-0000000Bm69-3rKw;
	Thu, 23 Jul 2026 14:22:51 +0200
Message-ID: <07b3c945a5aeeb08fb25955fb072308e3744402e.camel@sipsolutions.net>
Subject: Re: [PATCH v2 00/10] simplified UML/NOMMU approach
From: Johannes Berg <johannes@sipsolutions.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-um@lists.infradead.org, Hajime Tazaki <thehajime@gmail.com>, 
	liam@infradead.org, Ricardo Koller <ricarkol@google.com>
Date: Thu, 23 Jul 2026 14:22:50 +0200
In-Reply-To: <amH-fdSinCFd6sQ_@lucifer>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
	 <amH-fdSinCFd6sQ_@lucifer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_052255_795234_F44EC7CE 
X-CRM114-Status: GOOD (  13.47  )
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

On Thu, 2026-07-23 at 12:50 +0100, Lorenzo Stoakes (ARM) wrote:
> On Thu, Jul 23, 2026 at 11:35:41AM +0200, Johannes Berg wrote:
> > Prior RFC/v1 was here:
> > https://lore.kernel.org/linux-um/20260720185103.530603-11-johannes@sips=
olutions.net/
>=20
> Thanks for this! I really really want a nommu UML mode for testing purpos=
es so
> I'm very happy you're doing this :)

:)

> One mildly annoying note though - it'd be good for the cover letter to su=
mmarise
> what the series is about, what it achieves, how it compares for instance =
to
> Hajime's original approach ([0]).
>=20
> I guess how cover letters are used varies by subsystem somewhat but I fin=
d it
> really actively useful to see a summary in the cover letter.
>=20
> Anyway reading thorugh the RFC which already covers this seems that this
> achieves nommu UML with less changes needed which sounds really interesti=
ng!

Right, sorry, I got lazy and didn't copy/paste the RFC cover letter but
only put the link to it instead. Is there something beyond what I wrote
there that you were looking for?


> I may pull this series locally and have a play... :)

If you do, let us know how it goes :)

johannes

