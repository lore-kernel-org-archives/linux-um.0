Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C255606A319
	for <linux-um@archiver.kernel.org>; Wed, 21 Oct 2026 00:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=noVhLHmF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K0CoYf1X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EBojbNhYLUCWUeqx63v8d8R9RXCb6BEb2Dm6dXh1aCc=; b=noVhLHmF5vExg8VEmE2q+VBfxI
	n0TbS8dbSpGDuN1iBTEPZ11NMSsvcMrKTOuW8MCskTa7ZLOcSdnMS1BaR+StNqtcBMRKhMdgUw+l0
	iUcOXCCRr5i12ET+BDy9z4BShsKluZ5r08+Y6JqjalB8MXgvWbt6Za1NWjLMFQ4ir1jtDNLqbeTx+
	+Nz7QdUNhm9ru/yXA8/c0LsFwa7JJFw9fdyZnvZZGGpcpgTL/7O9cQHYPysgxdqpZSyjGzOzFwKsf
	EYY6+vSVMvE8yjO4s8CqFVHaHuaHfKTRVXh8MEFlK2PQOx0NGzylDzn4LY53SzLFF8EK3KqDirson
	/ex+rUBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJJor-0000000AqMH-1o1x;
	Wed, 21 Oct 2026 00:04:37 +0000
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJJoo-0000000AqLr-3V72
	for linux-um@lists.infradead.org;
	Wed, 21 Oct 2026 00:04:35 +0000
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-35d0be18c71so1365182eec.1
        for <linux-um@lists.infradead.org>; Tue, 20 Oct 2026 17:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792541074; x=1793145874; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EBojbNhYLUCWUeqx63v8d8R9RXCb6BEb2Dm6dXh1aCc=;
        b=K0CoYf1XIf+r7ljFRERN/UKUK5CYbOtvPTloUUF4giXSbKmrbbSPp6q7Uo0mbtpkjh
         XhDE1jf9uPsf2GlGcsS6v1pIq/sAOM7Zrx38DRaukrStW/bjaznxrN8Ni+dV0q+E/6KN
         iyWD49+v4tw46VnLw+C48XeonyhMigPzLHOdXyWrEQ75yrBT8/LkpCBB+1W4ZBsMnnT9
         qouIf2yqHmIzEV0iLMD4J6M1MGzyOmcqlPlMCVwZrEsb+DuLa3S4LF+mdqDkpulja6R9
         FTjhRN8EVoxPoxNhR2hCwNI0G1psYtrMg+ZiOb1V+cX1qgUMcluzfwATFh+LYMikpxPW
         mO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792541074; x=1793145874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EBojbNhYLUCWUeqx63v8d8R9RXCb6BEb2Dm6dXh1aCc=;
        b=G0+LKxCy8Cu7gr9hGZ1mIFaNtz3c0X8okJAXS36UF0KR2RuiU5Ewx2HrZqKeOGQdGV
         g1zOUHUiZDbx5+nCBdmzrlvRoKYt0s+wjUuzfmp1b/B76v4uLCsR9qhrXOfvRJ1JCfCw
         jJ726kcFtS08sWAi5N8gw1Pf/QjSaWWXoVJTqaxGd54bqTL+hJQv5n/nyG75r6m4mBDA
         oQ88QOW84Vvj8fb0poNuJO2Tlx/bn4gETM6om9aoW1+wyks15SQVPtMMj7EXPMkgc9zc
         9Ch6JFGjHQpkJE4ctepr+0wwNzIylagvdfXNE9fICPs4nf3svHVTBAHjD46aAthyvYMX
         WwlA==
X-Gm-Message-State: AFq9FYI0Nb13pCXSTtsmAdQ58cySK9J6zsOWE+RSojrImxqHF2UXrKKc
	0nr5Y33LWwDo0PBp2pb4e3Ylsjjf3aIpaHoz2V1+bJwJ8pdv3/5F8iV8O0xLBA==
X-Gm-Gg: AYBFou2agOPaEPH6LdZjm1PFMCIdTsyCgKOoK1ZNqk2ZD9c+xCuTI+0LEMR149k0ugE
	YA0GFVz1VKtIdIkpMseD9ShTsTO/W7bWMSOrRHjrnjKprWjmh47F32azHjLFUrE5BN+H1dw9qVL
	KcUSEH/hAgb4xE8PV3CsnpM5W2DGG1fqZe7OwJs92shAK461k0EcYwghqLCucMaWo7rGUVnkoau
	gWIbpUr5gteOmtzxXhIgV1K0X0RYg9rBREuz98JJbJ0/xLu1qyFPpYKueDtAfVKQWwKNDFegqEF
	+O1Y2ySYLpkQ/aDPIDV26QH8vQ5DaBL4omwtI70wJaZH1ed+TwaxKFluhuAEG5rYaMCEplSKAyx
	+8k5BXyF2FRL7SkAgJz5d5moM6S2IqAo+rx3p5FBlngAO49WphPlabTzDtcjF1JcPygBYdZ6nvl
	8/9zQBeQftlxQQ3vf5iisbzx+MSCHcvO+d0Worn9mFMALk5XA5pUwxSWiCBP449FtiDhDnFMZ+r
	ANtcK/ASjUpnWv8LDozyCVlzG6fmjmR2K4n6kZArpJxzcozAVsIxtl9SM5vgbA07YqPErh6F1UK
	XJTp2xjKkyocBkm+TaEFB3k16sMUYjNFlDitT+Aqg/EJ6aLPmLC5dEUiIk8AEA==
X-Received: by 2002:a05:701b:424d:10b0:152:dd1b:4fa7 with SMTP id a92af1059eb24-190a7b2b989mr469575c88.19.1792541073839;
        Tue, 20 Oct 2026 17:04:33 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bb7f098sm2495275c88.12.2026.10.20.17.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:04:32 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 5C74A189219F; Wed, 21 Oct 2026 09:04:31 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>
Subject: [PATCH] um: vector: disable BH while resetting stats
Date: Wed, 21 Oct 2026 09:04:29 +0900
Message-ID: <20261021000429.3284929-1-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_170434_876663_C345AFAC 
X-CRM114-Status: UNSURE (   8.72  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vector_reset_stats() is called from vector_net_open() in process context,
while its queue locks are also taken from vector_poll() in NAPI context.
Taking these locks with bottom halves enabled makes them appear
softirq-unsafe to lockdep.

This commit fixes the inconsistent lock state warning by disabling bottom
halves while resetting the vector statistics.

The warning was:

    ------------[ cut here ]------------
    ================================
    WARNING: inconsistent lock state
    7.3.0-rc4-g537b66d8fe2e-dirty #8 Not tainted
    --------------------------------
    inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
    ifconfig/32 [HC0[0]:SC1[1]:HE1:SE0] takes:
    00000000686b2db0 (&result->head_lock){+.?.}-{2:2}, at: vector_poll+0x71/0x2ea
    {SOFTIRQ-ON-W} state was registered at:
      save_stack_trace+0x2e/0x30
      stack_trace_save+0x38/0x3d
      save_trace+0xab/0x277
      mark_lock+0x143/0x45b
      __lock_acquire+0x71b/0x15a8
      lock_acquire+0x21e/0x293
      _raw_spin_lock+0x44/0x5b
      vector_net_open+0x39c/0x4bd
      __dev_open+0x139/0x1a3
      __dev_change_flags+0xe5/0x18d
      netif_change_flags+0x30/0x75
      dev_change_flags+0x3b/0x66
      devinet_ioctl+0x3ca/0x679
      inet_ioctl+0x13d/0x1dc
      sock_ioctl+0x317/0x3b0
      sys_ioctl+0x52b/0x786
      handle_syscall+0x79/0xa2
      userspace+0x610/0x6a3
      fork_handler+0x58/0x5c
    irq event stamp: 1942
    hardirqs last  enabled at (1942): [<00000000605ebbf3>] net_rx_action+0x136/0x343
    hardirqs last disabled at (1941): [<00000000605ebba7>] net_rx_action+0xea/0x343
    softirqs last  enabled at (1938): [<00000000605f3879>] dev_set_rx_mode+0x3b/0x3f
    softirqs last disabled at (1939): [<00000000607041f5>] __do_softirq+0x16/0x18
    
    other info that might help us debug this:
     Possible unsafe locking scenario:
    
           CPU0
           ----
      lock(&result->head_lock);
      <Interrupt>
        lock(&result->head_lock);
    
     *** DEADLOCK ***
    
    locks held by ifconfig/32: 1, last CPU#0:
     #0: 0000000060aba238 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x20/0x22

Fixes: 612a8c8e0b43 ("um: vector: Replace locks guarding queue depth with atomics")
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Assisted-by: LLM

---
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index e902e78c5ff6..9da13281c9e2 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -112,7 +112,7 @@ static void vector_reset_stats(struct vector_private *vp)
 	 */
 
 	if (vp->rx_queue)
-		spin_lock(&vp->rx_queue->head_lock);
+		spin_lock_bh(&vp->rx_queue->head_lock);
 
 	vp->estats.rx_queue_max = 0;
 	vp->estats.rx_queue_running_average = 0;
@@ -121,7 +121,7 @@ static void vector_reset_stats(struct vector_private *vp)
 	vp->estats.sg_linearized = 0;
 
 	if (vp->rx_queue)
-		spin_unlock(&vp->rx_queue->head_lock);
+		spin_unlock_bh(&vp->rx_queue->head_lock);
 
 
 	/* TX stats are modified with TX head_lock held
@@ -129,7 +129,7 @@ static void vector_reset_stats(struct vector_private *vp)
 	 */
 
 	if (vp->tx_queue)
-		spin_lock(&vp->tx_queue->head_lock);
+		spin_lock_bh(&vp->tx_queue->head_lock);
 
 	vp->estats.tx_timeout_count = 0;
 	vp->estats.tx_restart_queue = 0;
@@ -140,7 +140,7 @@ static void vector_reset_stats(struct vector_private *vp)
 	vp->estats.tx_queue_running_average = 0;
 
 	if (vp->tx_queue)
-		spin_unlock(&vp->tx_queue->head_lock);
+		spin_unlock_bh(&vp->tx_queue->head_lock);
 
 }
 

