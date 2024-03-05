Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B75C54E41
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 10:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pI7/JaYM4GUmwB7VUnN2pyZZuAWLxsng++hIQ/NUv8A=; b=4HQ8a5M8g+gBW1FZGsic7ZpZTG
	VBI7FFng56P3Pi9ePMzUMnlqAKQrxCR/PuBh6mR/xRmmay0slZrNo2ghRKXOza240KXN7L+6mmO6n
	zqZlHNCtC5R+HfOmC30Z7AqfmSHkM8sETl/oTS+a9FEp1cM8APwyIUudwfjA3LrrmxeywRKxQRZ7e
	IeD7gK3aIu4JKMQoB5oDtdSY6VU8PlHho+r+gPxpMaXDIGQCE5Kbw3kzm/uEROAKeLQL3Au50hh+x
	5Tg7e43Ed62FQP17tw5RchgTK0mgSPqvdlnizevOWaznrSrhG4weHy+N3/BNtidlRur1Spko6wbdq
	clgt+NoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhS9Q-0000000D6DT-0xZ1;
	Tue, 05 Mar 2024 10:36:00 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhS9K-0000000D68M-0TcQ
	for linux-um@lists.infradead.org;
	Tue, 05 Mar 2024 10:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pI7/JaYM4GUmwB7VUnN2pyZZuAWLxsng++hIQ/NUv8A=;
	t=1709634951; x=1710844551; b=HftBPSbeMBBJvEv3ELslFxlNQDTd9fg3qVtqi2qhccqk9zh
	Ti4piNmhknPkr37/pp7dyVoRUK1wC4NyzMOocUKLmS3Tt3ibK/vCPYdi1lZBlqfebieE+qzuNXDoa
	B98gaP176wqqv87oTNXMuXV7tGCK0n9QxY+Mboo9NsMPHv6iIRp9sOnfEEHrW86Ym0TFssZ0B1D7a
	rCvbKF02MBX43Y42TwHYy9IQa1pCf5TXIlICDWYymp5ZPPUDjFQi3yOTPyU+3g/t9GZ4abj0oVsrg
	b43dAKxGxLmrXkGs0uGPs8l/MNnK3baGhtQMMMv/UA9Ot8v5iO7IGnu+OtbfT9fw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rhS9E-00000002i7c-13tD;
	Tue, 05 Mar 2024 11:35:48 +0100
Message-ID: <5d1dfb9fce5d7647ff3203080416eadc9806059a.camel@sipsolutions.net>
Subject: Re: -Wmissing-prototypes warnings in user-mode linux
From: Johannes Berg <johannes@sipsolutions.net>
To: Jani Nikula <jani.nikula@intel.com>, Richard Weinberger
 <richard@nod.at>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 linux-um@lists.infradead.org
Cc: intel-xe@lists.freedesktop.org, Lucas De Marchi
 <lucas.demarchi@intel.com>
Date: Tue, 05 Mar 2024 11:35:46 +0100
In-Reply-To: <87jzmh2chs.fsf@intel.com>
References: <87jzmh2chs.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_023554_715289_19D4B6AB 
X-CRM114-Status: GOOD (  12.12  )
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

On Tue, 2024-03-05 at 12:34 +0200, Jani Nikula wrote:
> We're seeing a lot of -Wmissing-prototypes warnings when building
> user-mode Linux. For example, our CI hits things like [1], and it's just
> extra noise in the build.

Yeah ...

> I started adding some prototypes, but I lost my way around the arch/
> subdirectory a bit. I'm not always quite sure what should or could be
> included where, or whether a new header should be added instead, etc.,
> so it wasn't going as quickly as I'd hoped.
>=20
> Do you perhaps already have plans or, better yet, patches to address
> this? Feels like it should be fairly quick for someone familiar with the
> arch/um codebase.

I think this series addressed most already?

https://patchwork.ozlabs.org/project/linux-um/list/?series=3D393619

But I haven't checked myself yet.

johannes

