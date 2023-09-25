Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6B2CE7A81
	for <linux-um@archiver.kernel.org>; Mon, 25 Sep 2023 14:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uNzGWJK6qw0jSKsu+Zu0FU+CMkn5Zj6z3nckEM4/bvk=; b=CA531ZrvzHNkKX
	KxHzrx/gPu2nJSosXngnGPGvHAZkTYkQD8eOqjOOKtMfVZJoCnVN5B4ieYtio+Lqany1Hxg8ef22S
	suIJlqW3V/0nd+vq1pxcS9ciLeUCe1EjxOrfbPOvKXp7Jkx4hZVeFdWMUUpnI8LHkR/CSDYEJVsxd
	QaCVe3Rt8N9zPgFq9WZVqGHxFnwHn04vJlEbx82hTg+uIiJp0XjiQVichKZmf2e58cd4GDWOtF/Ko
	38wdwI2jsbkSkupKtq4BJg9PdWN+2/UKZi7XTWMQyLV8l+nmnXbGFctF2xb39ef0qmcMzWeiX/y8h
	Pss7hP4SVqaKx9bgEHMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkmop-00ESUb-0c;
	Mon, 25 Sep 2023 14:44:15 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkmom-00ESTR-36
	for linux-um@lists.infradead.org;
	Mon, 25 Sep 2023 14:44:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=D/M1aLl2ZHgxVdQolbol7WLXePs79njyXiSfUz/4W3Q=;
	t=1695653050; x=1696862650; b=VRnaYMr9MswlRAboTbGV8xSw4ITkiuYAWsEfDkWn7EQi1Kf
	76fjM0NeGG0Dw9+G4Lt53DL9wHytKY/KxhBQUzRuFfBeRupNe902u21SqGtFPEFXptwwT5DAikmK9
	W8kQKyab8w4PVTRmHSbEd4y/kFGdXHp0L826ptBpoMFTQg8kXq14ebEGD2G/gBEWluchCgmdkIqah
	aD7MiKb/SVuTZCopCbBnCgPWoeJ6M49Ye1AJbzKwmLRBzAR0agMV13mD9LbV+rj2Bq81kyfYV+2bE
	TJj43fKYzwl7cSAEEXOZuQY6FEvjI84EQVo4IOqPSA1shqsd+Z6cF2phi3M6wfnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qkmoh-003iPS-37;
	Mon, 25 Sep 2023 16:44:08 +0200
Message-ID: <d6ac37b196ebc0443997a942f8efb16a69e424fc.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 0/3] um: clean up mm creation - another attempt
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Date: Mon, 25 Sep 2023 16:44:06 +0200
In-Reply-To: <4b5764f0-d2c0-12ce-56bb-73c07ab59ebc@cambridgegreys.com>
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
	 <bcc1170b-89b9-7c5e-d047-7055f97c1716@cambridgegreys.com>
	 <4f79b781db6d5892c86e103733c7c30cda78afdf.camel@sipsolutions.net>
	 <4b5764f0-d2c0-12ce-56bb-73c07ab59ebc@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_074413_001467_1F258775 
X-CRM114-Status: GOOD (  19.35  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, 2023-09-25 at 15:27 +0100, Anton Ivanov wrote:
> On 25/09/2023 14:33, Johannes Berg wrote:
> > On Mon, 2023-09-25 at 14:29 +0100, Anton Ivanov wrote:
> > > I have rebased the preempt patch on top of these series.
> > > 
> > > PREEMPT works with some performance decrease.
> > > 
> > > VOLUNTARY deadlocks early in boot around the time it starts loading modules.
> > > 
> > > non-preemptible deadlocks very early in boot.
> > > 
> > 
> > Well I guess that means there's still some issue in here? Hmm.
> > 
> > Now I don't understand anything anymore, I guess.
> 
> PEBKAC. The tree got corrupted somewhere during rebase. Reapplying everything on top of a clean master fixed it.
> 
> So it all works.

OK, whew. At least now I no longer _completely_ doubt the mental model I
have of UML VM :-)

> With some performance penalties compared to the old approach, but works.

I still find this odd though, I don't see what the flush would possibly
do in a new (mm host) process that's not achievable in arch_dup_mmap()?

OK, so let's see - arch_dup_mmap() is _earlier_ than the fork_handler,
because that only happens on the very first switch into the process.
This is only when it gets scheduled. So we'd be looking for something
that copy_process() changes in the MM after copy_mm() and before it can
get scheduled?

I guess we could even move the flush it into copy_thread(), which is a
simpler patch too, but it felt a bit wrong, since that's about the
(guest!) process, not the mm.

But basically I don't see anything there - fork syscall tail-calls
kernel_clone(), which doesn't really do anything with the result of
copy_process() except wake it up, and copy_process() doesn't really do
anything either?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
