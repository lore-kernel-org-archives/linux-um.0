Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4A4C4167D
	for <linux-um@archiver.kernel.org>; Fri,  3 Nov 2023 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:MIME-Version:Message-ID:Date:
	Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gfdYRTDD31ZGpY4BltGLSo/tgy5RkEnAUEirr7+dDh4=; b=BBD5Di1svtvRqt
	6zBE1lsLmGhdm7OZrFBBDLF2nC1jpuRbKThaARDikeedoZpd6nA8G6kT8BsATNIdPrQoBMc2XcqPP
	bkW5sziWEPhL4yJxpQIZC0IaP5mNXk/S4a8Ff1y7AHo0Dnzy9qSm2vQp1be5G4K2fBawdYwFyi5Ir
	6BcO5dw8y+c33nJBw4XXMkuueU5OVMhop2C4WJWMdP1m4Lni5DkmpHL4oOeyIeSr92oXDxolb3IHb
	MxUV4EesGp3TCG7k14S+qpte+EP61xeAAo6xJ3lH1LR5D10i4qWkKZ7EkSU/Rk/pbOqqHWSjV6lO0
	gDzpDLoWVIoV5PwMB6PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFT-00BnmH-12;
	Fri, 03 Nov 2023 16:42:19 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFJ-00BnjS-0e
	for linux-um@lists.infradead.org;
	Fri, 03 Nov 2023 16:42:17 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 03 Nov 2023 16:41:57 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699029717; bh=+j05XT0CRUrrDOVmtR20M6Lw7N++zOw+Njh+OmN3o4w=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 8+K/A7+X1b7Tm2mlogffUWn7fVN1MVJAZchdzsldszdRgDqvnXpK8QfTTlsp+gTugODQGqIB8F0Aw6/yS55MBA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699029717; bh=+j05XT0CRUrrDOVmtR20M6Lw7N++zOw+Njh+OmN3o4w=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 T0Zfu7Gmop7eFVkYFNp+vv7kryUo6m37LuCe9+HKiQmU7fj8cmZTvRBiUljvvCfOQNC7ur4v7YSR4jfBb9Pl/UvMnZUau7FaChCXNLhrViqoo+BnqqIRdSp4c3ejPCzoH20TpnGLR1etOlgfLRgbBKe0KHuGwIkjrZhYev/T0Nc=
Received: from mininet-experimente.amd.e-technik.uni-rostock.de (139.30.201.3)
 by mail1.uni-rostock.de (139.30.22.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 17:41:56 +0100
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Subject: [PATCH RFC 00/11] Several Time Travel Mode Enhancements
Date: Fri, 3 Nov 2023 16:41:38 +0000
Message-ID: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMMiRWUC/x3MPQqAMAxA4atIZgNpiwquggdwFYeqUQP+0RYRx
 LtbHL/hvQc8O2EPZfKA40u8HHuEShMYFrvPjDJGgyZtlCKDfY9BNg7OXrziacOwsEcqspEUUTb
 pHGJ7Op7k/r8tNHUF3ft+XSRoNWwAAAA=
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, Benjamin Beichler
	<benjamin.beichler@uni-rostock.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699029716; l=2235;
 i=benjamin.beichler@uni-rostock.de; s=20231103; h=from:subject:message-id;
 bh=cNIVD5zhjOHj8/xnK9zBHEeCVOhceTQFg79lfSEJga0=;
 b=+0EFY/E1bHcNFwVLdSbaQJyW8JW8p7ulZKFbbgdeyhKRH3KYKTHeujaz1nJKBJCgxeeYPOXSQ
 99KJoW91/9+AppInRYgOjorMhYwZqVlV45w+Zsotcd85lQ/G/nWkHFZ
X-Developer-Key: i=benjamin.beichler@uni-rostock.de; a=ed25519;
 pk=fla2/IRwqFWH5W+fACqQyDu/mTc6mEcSPQtqb/SoX8o=
X-Originating-IP: [139.30.201.3]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 11553BA75BD72CED6336409AB9A51A3615D6822F0D916A0DFA94D8F694E7F6502000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_094210_126950_FF7FEAF5 
X-CRM114-Status: UNSURE (   8.36  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

I started to develop an alternative simulator based on time travel external
mode. In the development process, I faced some issues, where I want to share
my solutions.

They group into 3 categories, which I would split up later.

1-3 Add time travel handlers for some interrupts:
These mainly address interrupts in drivers in TT mode.

4-8 Fix problems in TT protocol:
I encountered several problems like missing TT messages and weird
behavior (e.g. backward jumping time). Additionally, I added
some more information in the ACK message, which was unused before,
to simplify the implementation of the simulation. The last patch,
"Protect accesses to the timetravel event list," fixed the last
corner cases in our setup, which were quite hard to debug.

9-11 Optional patches enhancing simulation:
This is mostly the RFC part of these patches. They are not needed,
but make sense (at least for me).

---
Benjamin Beichler (11):
      um: Make UBD requests synchronous in TT ext/infcpu mode
      um: add a simple time_travel_handler implementation
      um: Use a simple time travel handler for line interrupts
      um: Handle UM_TIMETRAVEL_RUN only in idle loop, signal success in ACK
      um: Add final request time to TT wait message
      um: always send UM_TIMETRAVEL_REQUEST from ISRs
      um: add TIMETRAVEL_REQUEST handler to request latest event
      um: Protect accesses to the timetravel event list
      um: Delay timer_read in time travel mode only after consecutive reads
      um: Delay timer_read only in possible busy loops in TT-mode
      um: Remove all TSC flags when using Time Travel Mode

 arch/um/drivers/line.c             |  8 ++---
 arch/um/drivers/ubd_kern.c         | 45 ++++++++++++++++++++++-----
 arch/um/include/shared/irq_user.h  |  7 +++++
 arch/um/kernel/time.c              | 62 ++++++++++++++++++++++++++++++++++----
 arch/um/kernel/um_arch.c           |  4 ++-
 include/uapi/linux/um_timetravel.h |  6 ++--
 6 files changed, 111 insertions(+), 21 deletions(-)
---
base-commit: 21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
change-id: 20231103-bb-timetravel-patches-075d01005f26

Best regards,
-- 
Benjamin Beichler <benjamin.beichler@uni-rostock.de>



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
