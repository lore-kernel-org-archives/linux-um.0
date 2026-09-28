Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FD0C9833E
	for <linux-um@archiver.kernel.org>; Mon, 28 Sep 2026 07:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cvdLhl9OwgCqQJe/WBa7udrYY67xOUZWy0mRH55GKhE=; b=LKBG2v//a4aZ4jZBL0KXsR5O7p
	VyLQ6rMpjDL+cx61iMUrx0PV7is/rTyr8m5LwRECZhl3Uc/X3Gw5R8VeaK6KRYEhzXJn5kGFDJjaK
	QEO4AnjymU+zuHVcNcIqLjDbxqQoeT4UuhwsYicGN79UBRSMFgSCGJYR9l0yQbKvQpxveKhLFycTR
	mZKE4E2FSg/MH3TcscXfuyqliHzfkKdGi8/JIZaulQ2sZo8I6g+fVI4/lqMH5oztA1ZObrG/rAkvk
	p8flysJWQ+ssRPkrR92WkP4xfhYKxZtuV3r+SWKlLpba5b5lSQoEQAv8esd98dt/v0j+/2/NxXBbe
	W9Vx6GVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB5sJ-0000000HYar-1Po4;
	Mon, 28 Sep 2026 07:34:11 +0000
Received: from s3.sipsolutions.net ([168.119.38.16] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB5sG-0000000HYZf-3KQJ
	for linux-um@lists.infradead.org;
	Mon, 28 Sep 2026 07:34:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cvdLhl9OwgCqQJe/WBa7udrYY67xOUZWy0mRH55GKhE=;
	t=1790580848; x=1791790448; b=IXbMrzNqOdxshCfOwesdjFGEio8xTPOasNGCj7zVPsHQFSw
	+hAIO38QSyfdp4rt6P41BbUTg4DSdmLc0zvnJLIra8AqmONX2qrUkVH1mmlTZINz5wXxbNWBYNtgK
	7p7MjtYb5cEHc1N1U+GzieLCznwJ/BSfE6g8GQlsTZbZCPGUlAShu8W8cVTwyHvabUil5Q/cV+7wm
	+H+xQXJ4fI76WUapeJPZXBbfiXtB01Mlf63T9SmdF8umHyViKd0Ww8+4wZ6kOAvpyNYOU0DVwmbSg
	wXMMCTdNTB7wmkqhQC8k6t4USzpAuTzkO0kl3JtfMgti9sLgNPhI4ND4tPuGRojA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xB5s8-0000000DKim-13bp;
	Mon, 28 Sep 2026 09:34:00 +0200
Message-ID: <bd4a10136fee856a768a4eeb681f718384ac2180.camel@sipsolutions.net>
Subject: Re: [PATCH] um: mprotect() __init memory
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org
Date: Mon, 28 Sep 2026 09:33:59 +0200
In-Reply-To: <4a99ab637eb8fbe6d72d788ddc0d2e141e7c9821.camel@sipsolutions.net>
References: <20260921122937.3821fec01e82.Ib959ff1baad7a45e2b804209b530040e69e4b046@changeid>
		 <m24ifc4v6m.wl-thehajime@gmail.com>
	 (sfid-20260926_041255_844241_7AADBB53) <4a99ab637eb8fbe6d72d788ddc0d2e141e7c9821.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_003408_835016_C93C6E3C 
X-CRM114-Status: GOOD (  12.78  )
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

On Sat, 2026-09-26 at 11:16 +0200, Johannes Berg wrote:
> On Sat, 2026-09-26 at 11:12 +0900, Hajime Tazaki wrote:
> > Hello,
> >=20
> > I recently pulled uml/next branch and faced an issue on the exit.
> >=20
> > ```
> > Thread 1 "vmlinux" received signal SIGSEGV, Segmentation fault.
> > 0x0000000060003cf3 in start_uml () at ../arch/um/kernel/skas/process.c:=
41
> > 41      }
> > (gdb) bt
> > #0  0x0000000060003cf3 in start_uml () at ../arch/um/kernel/skas/proces=
s.c:41
> > #1  0x0000000060003a69 in linux_main (argc=3Dargc@entry=3D9, argv=3Darg=
v@entry=3D0x7fffffffe118,
> >     envp=3Denvp@entry=3D0x7fffffffe168) at ../arch/um/kernel/um_arch.c:=
404
> > #2  0x00000000600049dc in main (argc=3D9, argv=3D0x7fffffffe118, envp=
=3D0x7fffffffe168)
> >     at ../arch/um/os-Linux/main.c:153
> > ```
> >=20
> > and bisected that this commit is the first rev to introduce this.
>=20
> I didn't get that, hmm.

Actually I did, just no backtrace (console was already shut down), only
"Aborted" and I missed that.


Looking at it with a fresh head, I think removing __init everywhere is a
bad idea. But we're already longjmp()ing around, so we don't really
_need_ to ever return from start_idle_thread(). We can have that call an
"os_exit()" function instead of returning through all the functions, and
that fixes the bug while keeping the __init behaviour.

Btw, it's not just that commit, but also the other one moving init text
into the right place.

I'll send a patch in a minute.

johannes

