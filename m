Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A6DCAC5A7
	for <linux-um@archiver.kernel.org>; Mon, 22 Sep 2025 07:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nJooTaP9EJUEuvdRKkg/AUuCEpA5pVQOOm9tHzbdOy8=; b=dZkQQmfG+/Ad8dm8gOpxfqKPKE
	AIi5loCRMGl7Qj0maFfSz20Mq+rv3hAJEYhPedhoR1jgZev81i/F6rbJW6Y9/CQD/j6Iyj4CTWYL+
	vPRTxI7GXFAHNpxzJRM7ZHWA7NYB7mJm5fZrYwpHZboe3ESx9cepuJHBkOc1AX6PgLUxMwWavxVXW
	mAX2Uyxpf7MX53gBbBrVRqdZuEtgjTakMc45z/jcSyogfigF5nWJrRKht2uEFt3ortU13XnfRAEkV
	ixA8xARMVL/EnwzsVFHErK/+B26R/m62DCUGNXJlE70Ux4axSd0RnnQnfIYWXMQKe+3xnubMpcSAF
	TMpZfBmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0bBB-00000009RJW-2VDp;
	Mon, 22 Sep 2025 07:41:45 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0bB8-00000009RFu-2OyZ;
	Mon, 22 Sep 2025 07:41:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nJooTaP9EJUEuvdRKkg/AUuCEpA5pVQOOm9tHzbdOy8=;
	t=1758526902; x=1759736502; b=v1DX5i5pTC75mqg5Qt/2DWQbvrdJCwKKTdyspMp0IT3+2m1
	7MyfkKHzUEzX4iPRV41XTc4sHA3dXXXaaPq4LbhOadczTAKxiNsMEX1mwl4ybFXSkb5eKbwebsq/0
	sxUs7fEV2BqUKPegEjAAjs7kRfmOsrsTRv0xXGil0go5xHnlVlhbVjCTyUziEcSWlLzPq1noEKBGk
	EAIQwRoZSLNaAJUnC6vpsaY45cFhlGEz1KSBeFlBFeBDHEWTC/LkH2YXeKGKkTvKMryNDfOoeZTs5
	sqygKsCwSEcNdV+xk0148LrzDEhRtEfLnZtr5Vu9wZFR+UbT9zE7LXQ4gVpNDAbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0bB3-00000004Dep-0kKa;
	Mon, 22 Sep 2025 09:41:37 +0200
Message-ID: <4354d88c2ff7a57a7324cc39b4ce5ed4ebe5277d.camel@sipsolutions.net>
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
From: Johannes Berg <johannes@sipsolutions.net>
To: Christoph Hellwig <hch@infradead.org>, Benjamin Berg
	 <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?=	 <linux@weissschuh.net>,
 linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@redhat.com>, linux-kernel@vger.kernel.org, Benjamin Berg
 <benjamin.berg@intel.com>
Date: Mon, 22 Sep 2025 09:41:36 +0200
In-Reply-To: <aM15eChUObXfxLzs@infradead.org>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
	 <aM15eChUObXfxLzs@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_004142_611524_A28C02E8 
X-CRM114-Status: GOOD (  14.51  )
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

On Fri, 2025-09-19 at 08:40 -0700, Christoph Hellwig wrote:
> On Fri, Sep 19, 2025 at 05:34:09PM +0200, Benjamin Berg wrote:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > This patchset is an attempt to start a nolibc port of UML.
>=20
> It would be useful to explain why that is desirable.

Agree, it should be here, but FWIW it's been discussed elsewhere on the
linux-um list in the past and basically there are various issues around
it. Off the top of my head:
 - glibc enabling new features such as rseq that interact badly with how
   UML manages memory (there were fixes for this, it worked sometimes
   and sometimes not)
 - allocation placement for TLS is problematic (see the SMP series)
 - it's (too) easy to accidentally call glibc functions that require
   huge amounts of stack space

There are probably other reasons, but the mixed nature of UML being both
kernel and "hypervisor" code in a single place doesn't mix well with
glibc.

johannes

