Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFB2C44536
	for <linux-um@archiver.kernel.org>; Wed, 22 Jul 2026 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WtNxc9/g2Rz85YgdfmohMEkgq5L2gbQZ7hBKp1+Oppc=; b=zbz1nUrwXj3+WNCtnXmTXc3weN
	Wagx/gUiyaNLDGQPZcMYtLl+yL6s2oUa8+XWo8ZyWijJFX7r270GFlCWO/BnWYLSKHysUq3BcN0zT
	vh9f4dNKMZqCEfMSLBri2ZinuHmvcjq5G+I5eyYaOHCm99nCN9uBvmRUcZ7ScoEIWfMlzTI93b8tW
	4yCYAWk+f9iPcIvispi7j1lfYyfApJyMP2VpjYJzon9o4yuO0FMEwPC2EXQ8sRt7NMgNZsewIlC1I
	jK9qdCkoQ8ND+k2uGCk2cQQNFM0D3TkohV49QdhsDZsJPbdz2v5I+gnB0tCWX92akVFErQPRMazAz
	Ka+n+cSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmWJs-0000000BnBV-35tN;
	Wed, 22 Jul 2026 12:45:04 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmWJp-0000000BnAg-2L3p
	for linux-um@lists.infradead.org;
	Wed, 22 Jul 2026 12:45:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WtNxc9/g2Rz85YgdfmohMEkgq5L2gbQZ7hBKp1+Oppc=;
	t=1784724301; x=1785933901; b=KMlPzrlOw+QDHY/1Urp7LJjHXWi1gpCcK8uhN6ycBADrweI
	DHziQJI6Ox0Ovv6Rfw0dQ5BC/FlkcjjaIiN5gRcDSYtH7WghmYOGlT8oHni2cFfyLCGnRCGJD1voY
	wGGL1Zyc02Hnega7sqgp2YJ8w5EOeguCLjkxVfmPAmO9144UK7RYz5tXistSrYVGmMzPSrdwvVUlC
	pyFB23DFwV0wkqQGnSPeAX6UDKq3U9oQzjHkUeU+qdVXA5qZxA7fKWtE7MpghdghIgNGYJ9oGnZjU
	jMHXPPMFjcWpXIaobyK8fTUN8O2Rhd/ln8lN16erBu8NdDQw4clajh7aGF5jqY8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmWJl-00000004l4a-0NF3;
	Wed, 22 Jul 2026 14:44:57 +0200
Message-ID: <f749582f2e2fe9219a854b8645c58df3f6b9ebf7.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 8/9] um: nommu: add userspace runner processes
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org
Date: Wed, 22 Jul 2026 14:44:56 +0200
In-Reply-To: <m27bmn4xqv.wl-thehajime@gmail.com> (sfid-20260722_033022_984146_07686A60)
References: <20260720185103.530603-11-johannes@sipsolutions.net>
		<20260720205103.5a666eac428b.I9f810f3ed177d6dc980cad36c231f8c745dee48f@changeid>
	 <m27bmn4xqv.wl-thehajime@gmail.com> (sfid-20260722_033022_984146_07686A60)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_054501_614937_06CACB67 
X-CRM114-Status: GOOD (  29.43  )
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

On Wed, 2026-07-22 at 10:30 +0900, Hajime Tazaki wrote:
> I was wondering where kernel address is located in this mode.
> although it doesn't have to be, under nommu, kernel address is located
> in the same address space with all userspace processes in my
> understanding.

Why wouldn't it have to be? If you have a real nommu system, then
there's no MMU, and so it has to be, no? (but see below)

> the kernel address is accessible (danger but it's !MMU) from userspace
> thus __access_ok() always returns 1.  so just wondering what is the
> case with this runner process approach.

It's still the case, in the runner startup I mapped the whole thing into
the runner process(es):

+ map(&r->mm_id, uml_reserved, high_physmem - uml_reserved,
+ UM_PROT_READ | UM_PROT_WRITE | UM_PROT_EXEC, fd, offset);

> a program accessing kernel address may fail (or crash in some case),
> but with the runner it won't ?

It still will, I believe, since it is mapped into the same address
space.

I did consider some other things:

   1. Using clone(CLONE_VM) instead - however that means I cannot use
      the stub as-is, and to work without it requires doing a bunch of
      setup in the runner process(es) - which is mostly equivalent to
      the stub.
     =20
      I did get this working (at least in seccomp mode, not sure now if
      it worked in ptrace too), but it requires shuffling around and
      duplicating quite a bit more code (e.g. the seccomp setup etc.).
     =20
      This would've made it more obvious, but has a fairly high code
      cost and no real (other) benefit.
     =20
   2. Conversely, with this approach, it *is* possible to not map the
      whole kernel into the userspace runners. I didn't try this yet,
      but it shouldn't actually be hard - just adjust the above map()
      call a bit? OK, it's a bit trickier with the VDSO etc.
     =20
      This would possibly be a benefit for testing, although userspace
      processes still need to be able to reach (and crash) each other
      anyway, so it'd just crash them if they tried to erroneously
      access the kernel.
     =20
      I don't think this would be very hard to do, but I also didn't
      fully think through the consequences - is the VDSO really the only
      thing the kernel assumes can be accessed?
     =20
   3. Some real nommu devices have MPUs instead, e.g. CONFIG_ARM_MPU. I
      didn't look into what this actually ends up protecting, but I
      could imagine that e.g. we actually make read-only sections read-
      only, etc. I don't see any general infrastructure for this though,
      and the ARM code (arch/arm/mm/pmsa-v7.c, arch/arm/mm/pmsa-v8.c)
      just seems to set up some static, more or less hard-coded,
      protections. But I didn't really look into that in detail.
     =20
   4. We could perhaps support XIP? But that's a whole different can of
      worms. Maybe it's not even NOMMU related.


Anyway, I also decided that all of this (except 1, which I discarded as
a design decision to simplify, after prototyping it) could be done as
later additional patches.

I also just realized I didn't really respond fully to your question
about what I want to do with this ... so if you're happy with this set
and I can hopefully get some of the others to review it, then I think
I'll send it as real [PATCH] and we can merge it, and go from there. I
also had some docs (based on yours) that I didn't include here, but that
I should include then.

And then we can see - maybe we want to rename "skas" (after you pointed
out what that really means), maybe we want to more generally clean up or
separate out the code a bit?

johannes

