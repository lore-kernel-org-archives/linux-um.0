Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD2DC2BD09
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVp2x45U3atoVQeAmbPEEf43VKqP5iLofWYZUg7xqQk=; b=yYTDFv834e06x5tGVxk5dSZfon
	3ke050JkygOcR9k3f1gPHChELzbYcg1OvZL7dCSOIZ644/kSfIRRYSXX049nvDb7L8EvcTmlxhAVU
	pZAjGc2gvJaKE4Tj+IZAPIt8QbRnzIbZWo92PwSdyJwJAMD4m2VG5HoWwbIDFiH2BaBq9gX/M8FwP
	dkZ4sN1Hn5/b8xZr8J82n7Dmd9hEBimGvwhqv2BE+7ZNdRzRJ80huTlsnkoOzIPRm8W7e7LjghbIj
	dKIr1wKpgpzrB0Ms9oCiTJ2QDRvWJWALyvN/BVk9bQ3ZUZh7vLVXesoE8TqrQPxcPrCWegLIVJiZl
	i5uDY5cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOzbk-0000000AEm4-0AMq;
	Wed, 03 Jul 2024 13:01:12 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOzbf-0000000AElE-3zqI
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 13:01:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EVp2x45U3atoVQeAmbPEEf43VKqP5iLofWYZUg7xqQk=;
	t=1720011667; x=1721221267; b=gaHVlFLAyBqfmpeO9vtDZYKqf8l2onJdpzcDQFNYRAcmVqN
	JpCu1xlRVkwogZdCCH/z1tI4QKeB0GoZ3JWzeHvjdlMPgJQ7GbQjDyqerrYoeSyzwmMFObQsMCvD4
	8vzcBpaKNaHIvXCOaNK3LaYzLxriidAl1esP+DDl1XyteyX8pSMS+S75BuEihc8JCKry4owki7rmq
	6J+inzgkfDVlIbwjN1rPTyvGQ/5qRvt5CwXyjdpblJqyl7pZMvpNXx9FtK+IEBvEa+pu0OuM0nH2G
	Mn87pLysLdA7B+Zp92HJLj/rB3bb1zTEQX2jOR1BssotKx5NvOxA1eLrDYVgdt7g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOzbY-0000000908G-1VnZ;
	Wed, 03 Jul 2024 15:01:00 +0200
Message-ID: <3969a420de91b1f40c37e8b52ebe92605a2fe31a.camel@sipsolutions.net>
Subject: Re: [PATCH v3 10/12] um: remove force_flush_all from fork_handler
From: Johannes Berg <johannes@sipsolutions.net>
To: benjamin@sipsolutions.net, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Wed, 03 Jul 2024 15:00:59 +0200
In-Reply-To: <2784bb3e9de2ad88a48d8fa70b01c46e1b2399fc.camel@sipsolutions.net>
References: <20240524213718.1757703-1-benjamin@sipsolutions.net>
	 <20240524213718.1757703-11-benjamin@sipsolutions.net>
	 <2784bb3e9de2ad88a48d8fa70b01c46e1b2399fc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_060108_046763_1FE7E24A 
X-CRM114-Status: GOOD (  15.94  )
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

On Wed, 2024-07-03 at 11:45 +0200, Johannes Berg wrote:
> On Fri, 2024-05-24 at 23:37 +0200, benjamin@sipsolutions.net wrote:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > There should be no need for this.
>=20
> "should" ;-)
>=20
> This breaks things if glibc enables rseq. That might even be already
> broken in the sense that it might corrupt memory that's put at the same
> place the rseq was installed? But it at least it appears to still work
> without this patch...

Uh, well, it's not quite right what I'm saying ...

Courtesy of Benjamin, currently we have, in userspace memory:


|-- normal address space --|-- empty --|-- stub --|-- empty ...
                           ^ TASK_SIZE
                                       ^ STUB_START

now it appears that - at least in 32-bit - the rseq memory is between
TASK_SIZE and STUB_START, so the

> +	/* Ensure the new MM is clean and nothing unwanted is mapped */
> +	unmap(new_id, 0, STUB_START);

will unmap the memory glibc set up for rseq, and thus immediately lead
to a SIGSEGV when rseq will try to use it, but that happens immediately.

Thus, I see the crash.

If we unmap there only to TASK_SIZE, which is less clean but pretty much
OK since we only use the memory < TASK_SIZE, then this problem goes away
(and Benjamin will resend the patches with that, for now, until it all
goes away with the execve patch.)

If rseq memory was to overlap the "-- stub --" area, then we'd get the
stub corrupted and crash, but I haven't observed that (yet anyway.)
Although perhaps depending on how the corruption works it's not even too
likely.

In any case, it's either not really an issue (rseq memory remains mapped
in the "empty" blocks), or already causing stub corruption, so this
patchset doesn't really (need to) change it, and the later execve()
change will clean it all up properly.

johannes

