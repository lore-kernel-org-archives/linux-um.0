Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70379CF11DF
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 12:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SpVZIosqmpJ+gnI7DWJR+BdwXkQfTHkbDME32OT2UYk=; b=gK5ynVLCGXeDRyaB9qajHU5i1E
	K9kTVNWpIUAosFfqYKvZuemYuHE6sX35+CQvn6O1QQ+tarbmmMPYqfn3qpOUJfRtOa7kGckYOPiae
	DMYh6rEAn/mhDWEHhobKbXPdZuIcRmxUUMGP5t/xRZunCj7KQYYf/L5Hkk/NBl9XpJKdGIGEHJNtQ
	lruC7UhLZOKoETAxk7V3HhAlwIdv+nKFChHs6jLjE/pprxAkzbXlI0xrQGWvl48Yvy8OpqMlw60qn
	VVyxA/NipIJOCPdvvTgmEwScuunUlfakLMv/6HNow/ijCyl/7eiu9Xg+qG8bAWkletzchZd+DPYXi
	CuunVj6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sys8E-0000000Cgt4-0dKZ;
	Thu, 10 Oct 2024 12:19:02 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syrrC-0000000CdRV-3sOl
	for linux-um@lists.infradead.org;
	Thu, 10 Oct 2024 12:01:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SpVZIosqmpJ+gnI7DWJR+BdwXkQfTHkbDME32OT2UYk=;
	t=1728561686; x=1729771286; b=j89rmCNNPT2BDpbafd/1QGt5MGtf/9m4ROoWjw2U2g1yydE
	2ub5/QEiVzMBwbIYXheedbU4XNoD4szBVN7VJBOQZl+kVnjQfAwCXdhagK+5bjXngauOkce7FSU/q
	NCAOQbjdOtnEtkXFvMS1e2V3hrftNEglXDNl0wb9Kda8MH566KGQuXafHiFxOG/PataMePMMT7L0D
	DaDie8Kh3MfxmaJftIODqByfYSTN4lcftktfdkTbuaj8SIp9pB3rwnNTEPQRbCLjwP55NsoXhJvvY
	GT0MFm6Q9hPMsKDPfpZGATjJTtdRVgYQt8ZIjQbvUbhKtpBMd+HpPh5bUHdwb0+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1syrr7-000000064FN-2E1I;
	Thu, 10 Oct 2024 14:01:21 +0200
Message-ID: <c66980fcc8d92f3dd3236b7f28df30ba40b7c3c0.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 7/9] um: Track userspace children dying in SECCOMP
 mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Thu, 10 Oct 2024 14:01:20 +0200
In-Reply-To: <20240925203232.565086-8-benjamin@sipsolutions.net>
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
	 <20240925203232.565086-8-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_050127_093614_D4539AD7 
X-CRM114-Status: UNSURE (   6.02  )
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

On Wed, 2024-09-25 at 22:32 +0200, Benjamin Berg wrote:
>=20
> Fix this issue using a new IRQ that is fired after a SIGCHLD and keeping
> an (internal) list of all MMs.

Maybe that would be nicer with an xarray indexed by pid?

The list could get quite long I suppose?

johannes

