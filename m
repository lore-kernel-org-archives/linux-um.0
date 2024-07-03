Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5B1C3271F
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RlO8rBsBX3IOZY9NpJNBz+ARk1BgvYA6+uROk/rWiMA=; b=s2+DmI+s8gipquzsmj9D2admtB
	ySoynsuYX7gy2kdS/qiQ6pBnykpWnlA3836g1oS5JFszFo3v9GGRjuk0aRudUkPl4Fn9KH0ckWWZ/
	Ccg1GuHxaS9DHsXrqlelHBJkp5b3IS4r6cC5S7yL3/8skdXLsvqj4onBjNtpdLoR0Ri3408tE7Agd
	piPzffYwISZXrXJoMisKy6iGYnUpT53KFkw5mNWT2A37jigIvgrSWIihnlLP5RgXDYAxMs4qJ5WN4
	4Yl2Wg6n7wft3lq7Ghs+Jl0Z6Zk3/d7ffxMcyCmSN+a0zvuOALa5u9svLletLHWMccZ0vl0h27Zy7
	FpqFaiqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP256-0000000AiWu-42KK;
	Wed, 03 Jul 2024 15:39:40 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP24M-0000000AiAk-3BsX
	for linux-um@bombadil.infradead.org;
	Wed, 03 Jul 2024 15:38:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=RlO8rBsBX3IOZY9NpJNBz+ARk1BgvYA6+uROk/rWiMA=; b=MJpHO1rDB4nI/SZk4kU9+rz83O
	slFt6YURPuu7LA6PZK4atM6UKWSjVtSlJFOz46nqt4iLd7RnFhV3lceEhah/G2mqTeMxmFhtgsoYa
	t5UOoVeR0GXuEdkHVoRWW6oXCXxjF+yDJTAzthG6XgU4KMeXlbQRqR+j4FqBsFdkpkJBX0/eLZtSR
	4CCuLjITEZ9uJy/zAGJ3mTBlIGmHE1s37UQbX6Qn+PzlJ3NHEv1ZU05aeSasuT6LQBG0RlL2/0AeJ
	RhFgKvJQxPTk+I6l4hFXyRSnHFAvaipeWEZ/dc9C3D6E0eAtDHSvYA1lME/rHYQ/VEXA9pQayCNR+
	Xn7utokg==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP24F-0000000A5r5-0F9Q
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 15:38:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=RlO8rBsBX3IOZY9NpJNBz+ARk1BgvYA6+uROk/rWiMA=; t=1720021125; x=1721230725; 
	b=BjFF8CKCFChbYD74+mWzzdOzXYYrfxE7jQEJaI0Pu5mwlbWY50AMnwLS5WTR7FduZa+pfWdFECv
	Aw52XyuehlJ1ejhMvB2txlNTvrgl4ZRdn8155MfMHCGk4f6vv7ozWyJEyKYOUHWJHZHCtnFDmMdOC
	+Zl7WYPvIMZO98WiVDU3mxHZODUDAi4KyJHN/MH2fYQA+SQFfvxPu/50ig8msnvWtLQZnu8M8tilM
	IBEA9gZD3ORlAulYQhgp0K0vrdQrq5Aceb9AZ0n9kGGatNn+wTEhWeoSUH6bWa9++OMd7UyQu3jDl
	tZNxg9p6OxGZZDY/HsuEYCA9SqEecnXdt5pA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sP24B-00000009P0T-24re;
	Wed, 03 Jul 2024 17:38:43 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: register power-off handler
Date: Wed,  3 Jul 2024 17:38:40 +0200
Message-ID: <20240703173839.fcbb538c6686.I3d333f4773cff93c4337c4d128ee0b1b501b3dfa@changeid>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_163847_369347_A09A7426 
X-CRM114-Status: UNSURE (   6.83  )
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

From: Johannes Berg <johannes.berg@intel.com>

Otherwise we always get

 reboot: Power off not available: System halted instead

which is really quite pointless.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/reboot.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 25840eee1068..3736bca626ba 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -59,3 +59,18 @@ void machine_halt(void)
 {
 	machine_power_off();
 }
+
+static int sys_power_off_handler(struct sys_off_data *data)
+{
+	machine_power_off();
+	return 0;
+}
+
+static int register_power_off(void)
+{
+	register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+				 SYS_OFF_PRIO_DEFAULT,
+				 sys_power_off_handler, NULL);
+	return 0;
+}
+__initcall(register_power_off);
-- 
2.45.2


