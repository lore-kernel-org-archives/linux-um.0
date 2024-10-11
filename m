Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E06CFD30B
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3i7xaHn/k9QwPofJE1RoXQFyFWsHwRALXQe60ECIRXY=; b=bkpglyzcuLSvir
	30dgr41gXa8qfOC84SRL2FBoNcZiZLpnqYJLk1GAfASHJsc/J7R/13H+U5LotFXxX1RrE+LoSlpH2
	NV+SvHD1p+WiXkjZKbck87b49KUnIid4g1UrFit38ZUAP58PY5CLOy3L6H6kcnrJllBF/WSB2uxwH
	rAbT3bvTdJHGym8ZCU2WovqGuYZjnBMYW0GYstYZSr+MgXDNV471Ohjr0VJr4nya6XxLT4JfZJVc2
	XG5K70ixOV3nX0Zsr/8y5clJ4nkXfjD9a6ZdMUrYVixbwpphP+AgQWGxymvamjfPhwkTuFb09EJBt
	DS9zOwW8Eyen4P+xXKfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szBoA-0000000FoAz-2hsg;
	Fri, 11 Oct 2024 09:19:38 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szBnU-0000000Fnus-1Sub
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 09:19:06 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728638332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3i7xaHn/k9QwPofJE1RoXQFyFWsHwRALXQe60ECIRXY=;
	b=R2WafV0VyDY+G/s5bQiCBhEpkfyyRPa0OTxbmIgxSju2NwU4urikb0Yo0s08rBmqUKKsOK
	er2kvM26UAf3o2UPr2XvL96y1i3H6Art8U+orNzGnWCy33fCgYDLBzMLBCRV1vJj7udljO
	XfInwY+Zecp615bGyqewPJCsmnxaGd4p9OOaMNp8ld/rb9KSQrPkOs1mU3Dd0C7WBzMJNy
	Ksw2Xi0+bH0kHYobnvqp5OPu5eUiZu++Aw3gbISmF4Ak2ZaaWMV3/nWBgoDcHJii8NC5Bo
	JHFsBGyOTwV77L9d3KET0tE1Jg7Lo/Kedl4vVKfE2AfW1h+WoKXkbrZl5PCioQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728638332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3i7xaHn/k9QwPofJE1RoXQFyFWsHwRALXQe60ECIRXY=;
	b=i1RVVRASk+dqTdw4l1tDjEYFtAjHpqyGFWD3Gb/4Po8mrHSX5XJxy4HvTzxAh+vW5szKLr
	+GCntqAKeRsTJKDw==
Subject: [PATCH 0/3] vdso: Always reject undefined references in during
 linking
Date: Fri, 11 Oct 2024 11:18:24 +0200
Message-Id: <20241011-vdso-checkundef-v1-0-1a46e0352d20@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGDtCGcC/x2MQQqAMAzAviI9O1iHevAr4kHXToswZcMhyP5u8
 RhC8kLmJJxhbF5IXCTLGRWwbcDvS9zYCCmDs65Di2gK5dP4nf1xR+JgwkBkB1Tfr6DVlTjI8x+
 nudYP0burmGEAAAA=
X-Change-ID: 20241011-vdso-checkundef-f6dd0612025b
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728638330; l=1098;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=DE0pG8qy796JfazzXbj8HDmCD79cEMob0SgGKor7rNQ=;
 b=raDEJsQlC+84uF9OuE2kfi/uFlSzdPtmawc5XYRTJY+fkZ/0tvmuae5IfCdVxNrMG7sHYAc6q
 hRCkuoBfeByD3FzXWbj+IODdF96IOaqz2YqgprNN+cmg7+fTm6x5wc0
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_021856_684814_D6585726 
X-CRM114-Status: UNSURE (   5.27  )
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

Instead of using a custom script to detect and fail on undefined
references, use --no-undefined for all VDSO linker invocations.

Drop the now unused checkundef.sh scripts.

These patches can be picked up by the architecture maintainers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (3):
      x86: vdso: Always reject undefined references in during linking
      um: vdso: Always reject undefined references in during linking
      sparc: vdso: Always reject undefined references in during linking

 arch/sparc/vdso/Makefile          |  7 +++----
 arch/sparc/vdso/checkundef.sh     | 10 ----------
 arch/x86/entry/vdso/Makefile      |  7 +++----
 arch/x86/entry/vdso/checkundef.sh | 10 ----------
 arch/x86/um/vdso/Makefile         |  5 ++---
 arch/x86/um/vdso/checkundef.sh    | 11 -----------
 6 files changed, 8 insertions(+), 42 deletions(-)
---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241011-vdso-checkundef-f6dd0612025b

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


