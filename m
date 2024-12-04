Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450EDE77170
	for <linux-um@archiver.kernel.org>; Wed,  4 Dec 2024 16:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hiasjA6HPUqkbB5Rnxc4UFn1+ZsKN/GfnPieeobEI1Q=; b=3MbRfEMbB7pC2+F11BL88rrzIe
	1i5I5Tm8cjtrBSi+icCYz5dWZCpEJpzPoU/lMxVdSOK3cis3jNBOPxJW+UJqWaZl99j4iu2xzaslP
	fTVHFqp5iZ7RqBtxVRbVMGcYdt0etYdK1w9QJwC5FuTf+wgHlRi1Hblj76BppdZA5qVvJDFVcTZGR
	8snKI/yOfHm35KWxAgrPPbQ5AKnwvX7xj/y343Q81/K6qjGkrSOXhOQVWadC9hawdD+TwO/Ni7YU0
	THgzkqFMt9TWQqLPdrObgWnappLG16Zmpvbse+ZlzLKQD4SlwVcjV9/TfWXjHTX9AQJAMW3V7iL6Y
	hZSGYgvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIs86-0000000DAPH-2olP;
	Wed, 04 Dec 2024 16:21:34 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIs6k-0000000DA4T-1AHB
	for linux-um@lists.infradead.org;
	Wed, 04 Dec 2024 16:20:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hiasjA6HPUqkbB5Rnxc4UFn1+ZsKN/GfnPieeobEI1Q=;
	t=1733329208; x=1734538808; b=PNGEHUUbfKnx9TxT76Z2Foi4sZQofwRqehOzyUk4kJOnBk/
	dvVQORfTJLYl+fo/qurcX0m7jPigyTuq8r1B3CheJ2HTjnuhtRzeKrrHNxdcQhCrrNs26c6zPyJY6
	6yEVu6Gd6tl0KdGciPwtl1igCI8K1ASgEMsVg7Ca1HceOt/zHKq7ydTSWY0ytlXiZa5vHwTKcdcxH
	3hXH5agQiXDze84h7pR05pVqPAN9mFQDe12mxPQwPqYZWcmtV1wEXsuEe5w2ICFTcLfdL5uIXeY1k
	tvbxwkaKdSSeradkmJRaRm+Ek4SYwX4Wzy+daWSroJriRSCbXGoQU3uW2k1pgwhQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tIs6f-000000073i1-2Zlt;
	Wed, 04 Dec 2024 17:20:05 +0100
Message-ID: <8c1fdd162110f043447974b8606bec9c614c578b.camel@sipsolutions.net>
Subject: Re: [PATCH v3 00/13] nommu UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com
Date: Wed, 04 Dec 2024 17:20:04 +0100
In-Reply-To: <cover.1733199769.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
	 <cover.1733199769.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_082010_315891_25AC3660 
X-CRM114-Status: UNSURE (   5.99  )
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

On Tue, 2024-12-03 at 13:22 +0900, Hajime Tazaki wrote:
> This is a series of patches of nommu arch addition to UML.

Please next time you resend this, don't hide it in the old thread :)

johannes

