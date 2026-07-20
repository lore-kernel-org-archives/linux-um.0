Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110F1C44515
	for <linux-um@archiver.kernel.org>; Mon, 20 Jul 2026 18:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HuZWe+pS4IP2bIRYdBPTEGT6dSajs/6clZcJQ78N0nY=; b=Xq5NyS0y3dBmUMUaGFnH72SUdH
	RHzNn6RQs8GiAdoJXimT8g6aJhTgJqScT5+eQDXV5QlNKTlW5niVyIXNTUOmfa/99acH1//s5+iBW
	Tb49rC9YINerCVD44Es6t3WLKBluC+lDXdstCVAoEZwy+2bKJKFqXNWhrji30oWONUIDZpqeO/yQj
	JZLTShWVJCmBLrvF6XJmHB03tB9DgyfgoVCRMcq93dlurZYx4l6qC9c40vC7IuZ6jnYJn+wvgM2tI
	oq8Lc6UczR6NTaJum3qsj2nUKVycG3Ehk0sBJggylFBVlt8RrF5U9JPudfOAkwmY5ZrjHIdLOMi5R
	uTpKtScg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt5C-00000007h45-1tRj;
	Mon, 20 Jul 2026 18:51:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt59-00000007h0t-2i7B
	for linux-um@lists.infradead.org;
	Mon, 20 Jul 2026 18:51:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=HuZWe+pS4IP2bIRYdBPTEGT6dSajs/6clZcJQ78N0nY=; t=1784573475; x=1785783075; 
	b=tD7e05C01W/c+IxG+vG+otxWf1wup8b2TZVcg+ecWBgLEwKnffxmqRUimV1S3VYCEdEyEs9eVGK
	MuwshbohEkAyPf16tsRx/nfco7gEr4DqpmTzzjVXGOoBhBywJkXUloA5kXOtMyL+uYq71gqeEwfdf
	L/dSFdtkLYxOJJy1P/PAyI06claACtEGWkpUY2d6rEltygtCyAQ0GZurfE1p0RSCj1IlR8c/QFzkl
	pcykXmXdyRLqQuxeocfAwiMF85tnut7qlavtTb+K8SYozP/G9lMQPlNf1GOWPuZMogbmsTXaeqXO2
	xn3+HHF+8rpyuXI47MH3KAI/DRD5t+v4uU1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wlt52-0000000GsPP-0OWT;
	Mon, 20 Jul 2026 20:51:08 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 0/9] simplified UML/NOMMU approach
Date: Mon, 20 Jul 2026 20:26:50 +0200
Message-ID: <20260720185103.530603-11-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_115115_983418_100B21B1 
X-CRM114-Status: GOOD (  13.02  )
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

Hi,

After Hajime's talk at netdevconf 0x1A I was this time really
tempted into implementing an approach to NOMMU UML that I'd
thought about quite a while ago, and here's the resulting
code. I had prototyped some of this with LLM help, but now
have pretty much reworked most of it (except boilerplate).

Instead of using a wholly new architectural interface, new
process/thread handling, new seccomp machinery etc. this
just reuses all the existing infrastructure (we're not in
fact trying to run UML on nommu, but run _as_ nommu), but
makes runner processes for each CPU instead of each userspace
MM (as it would be on MMU).

This eventually results in a far simpler implementation that
doesn't have all the complexity of the syscall handling yet
again.

It's also more capable:
 - continues working with ptrace
 - doesn't require disabling SMP
   (just has a runner per CPU)
 - should work on 32-bit (untested)
 - keeps physmem FD, which in theory should allow virtio
   PCI devices, but PCI doesn't build on !MMU right now

However, it does go in an entirely different direction
and while it doesn't entirely close off all things for
optimisations wrt. syscall speed that the much older
versions of the NOMMU patchset did, it does create the
infrastructure in a way that doesn't make that easier.

Personally, I think the only real use case for this
whole thing is NOMMU testing (which was requested), and
we don't really need everything else.

Note: the futex thing seems odd. I mirrored the existing
implementation, but I think it's just wrong. There's a
FIXME in the code for now.

It does boot ghcr.io/thehajime/alpine:3.20.3-um-nommu
as was documented before.

johannes


