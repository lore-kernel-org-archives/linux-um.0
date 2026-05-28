Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA49CD5BD1
	for <linux-um@archiver.kernel.org>; Thu, 28 May 2026 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cEfNXf5FA0/JfEy/uGLzghxeaR7x7407NCUyO6iJU7o=; b=zSscJggVeh2xwX6uql4HerQ+i5
	VNL3k9NyZ+FppHpv8ChJOmxrFoTZDB0Ww25ta0v28kRJgIwAWSZg8bknozFh1bw3hd2T1+kWm5e5Q
	YwsQhswZ027UOzoG+oXRBnCvu34l6FnHyDx4EFN6aJiJZSN7zLoBH+VXBhAzxIdxHhB/oOv8pAnGP
	UT92yPX12bdmHib9pPQ8gQIBmQoYRNPCkEwQpsIBAxKt5el9IjQOMEAc3wBWCO5atVklr8nvk7rI6
	MFOYk9KZ3zhtImv8Aye09Ce0+ZbgITUr+d3M06kcd+k++Tgfc1yljViPtUOsJmrHF3i6dajIZ0GEp
	9aDPd+Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSUwK-00000005FJo-0RHB;
	Thu, 28 May 2026 07:14:00 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSUwG-00000005FJP-2R7j
	for linux-um@lists.infradead.org;
	Thu, 28 May 2026 07:13:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cEfNXf5FA0/JfEy/uGLzghxeaR7x7407NCUyO6iJU7o=;
	t=1779952436; x=1781162036; b=gMGyOuEN8MigrxdvGKqRkE1UBYXE0xlpf83tjr5XmhcQj2i
	LPbCJgLRLR2d8JHDVvZoH1LZIxTkkJZ/snCMc6K+uR5pCMDhYTg5isvHZg/GnB2mzQjT8ZpGD/8xs
	M5KC7YqRxjBumnFLoJZ5wRkoQOFeF4DYSmBGWIBudWNel3C1Dx/8RccmUW8FpQSqZOvgrpWemFSdZ
	cee2NSRASapLh1n5h+0AAKTq18bS4/2LT7YUD2tKWtIuWMkqTTEHVnrJs+McTxM/ILAAUZo4lkPrK
	DkM/utg7bi01cTbONiri8vw4/1ayn7WVlkuv/dBfM42LTBaN13oO3v+bInhACxzg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSUw2-000000078lL-1xRY;
	Thu, 28 May 2026 09:13:42 +0200
Message-ID: <b72e33e9d651f67ff2236b21fc13c3c78a99cb97.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: avoid NULL queue dereference in legacy RX
 mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Henry Barreto <contato@henrybarreto.dev>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Tiwei Bie <tiwei.btw@antgroup.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Henry Barreto <me@henrybarreto.dev>
Date: Thu, 28 May 2026 09:13:37 +0200
In-Reply-To: <20260527213524.45903-1-contato@henrybarreto.dev>
References: <20260527213524.45903-1-contato@henrybarreto.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_001356_906354_DDC6C48B 
X-CRM114-Status: UNSURE (   9.69  )
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

On Wed, 2026-05-27 at 18:35 -0300, Henry Barreto wrote:
> From: Henry Barreto <me@henrybarreto.dev>
>=20
> Bringing a UML vector netdev up can panic in vector_net_open() with a
> fault in _raw_spin_lock().
>=20
> vector_net_open() calls vector_reset_stats(), which takes the RX and TX
> queue locks. However, queue allocation depends on runtime transport
> options. With tap transport, vector RX/TX queues are not created and the
> legacy header buffers are used instead. Taking a queue lock then
> dereferences a NULL queue pointer.
>=20
> Take the queue locks in vector_reset_stats() only when the corresponding
> queue exists. Also move the RX queue lock in vector_poll() into the
> VECTOR_RX path, so legacy RX does not touch rx_queue.
>=20
> Fixes: 612a8c8e0b43 ("um: vector: Replace locks guarding queue depth with=
 atomics")

So ... you're effectively saying that the tap transport has been broken
since 6.12, released ~1.5 years ago.

Maybe we should just remove that entirely since nobody complained?

johannes

