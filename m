Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D63C46467
	for <linux-um@archiver.kernel.org>; Tue,  3 Jan 2023 08:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kekqVIPrgi36VZZvfvnqdIc7ZWCEJzE6zy6riG9cGXU=; b=zJ3dqApsbdCXD0
	7I2koIGt00UYhQg/kDo+PIbTns5V6Jpuvmzq0jo4sW5YBjYtuufVLsvKqni+S+JLbIld4vBTIH/D0
	K1lPZoqGZ7vvuC5uhJuHiw9K63+fNHaqeeyNmq/VmczOcum7Lsrjn+NcdnnMcqa7vE31Sgvw1JFNK
	3RwwmsFZdW52UiOwYovfzza33ZQhkKgIBVRbsuIsY5X1F1UexoPWRjhoxGEO79MrH2yuZ1edqsp+v
	xzFhdcSMkwYzXprlqYak8jM7hsv0S+shrRrP5ogv8+zNxvZjK5YM3f7fVx/6VloLkmuQ0tsxCy7ZV
	ry6xJduNEEJZwsKHwYqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCcWP-0008KS-3x; Tue, 03 Jan 2023 08:19:45 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCcSQ-0007E4-IP
	for linux-um@lists.infradead.org; Tue, 03 Jan 2023 08:15:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 204F1B80E49;
	Tue,  3 Jan 2023 08:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF11C433D2;
	Tue,  3 Jan 2023 08:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1672733735;
	bh=aHWCsL7Yk7DECg3q0Lq6MKlwgwnQsz0WYbGfOt60hto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBUDqulvEgPg7Fu1NCRxfQiPrPoUMG3/BcAKLmo8FKXu/HjsRS7aZyJIY3K4dwOEp
	 XAvZy7BNlTZOVYD9y/B4vyq3jNgDqlVTS2Hvm8a9gCQBofchXuM+FRXxM7s5UvkUuw
	 IUDGE8xd0m9j+6Hlla02AcjZsiUqozPgtcfGYhfw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10 26/63] um: add support for TIF_NOTIFY_SIGNAL
Date: Tue,  3 Jan 2023 09:13:56 +0100
Message-Id: <20230103081310.149506483@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103081308.548338576@linuxfoundation.org>
References: <20230103081308.548338576@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_001538_999344_DEAA3D38 
X-CRM114-Status: GOOD (  12.53  )
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

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit a5b3cd32ff238b87e94d47b927aff117e22d13c0 ]

Wire up TIF_NOTIFY_SIGNAL handling for um.

Cc: linux-um@lists.infradead.org
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/um/include/asm/thread_info.h |    2 ++
 arch/um/kernel/process.c          |    3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -57,6 +57,7 @@ static inline struct thread_info *curren
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_SIGPENDING		1	/* signal pending */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
+#define TIF_NOTIFY_SIGNAL	3	/* signal notifications exist */
 #define TIF_RESTART_BLOCK	4
 #define TIF_MEMDIE		5	/* is terminating due to OOM killer */
 #define TIF_SYSCALL_AUDIT	6
@@ -68,6 +69,7 @@ static inline struct thread_info *curren
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -99,7 +99,8 @@ void interrupt_end(void)
 
 	if (need_resched())
 		schedule();
-	if (test_thread_flag(TIF_SIGPENDING))
+	if (test_thread_flag(TIF_SIGPENDING) ||
+	    test_thread_flag(TIF_NOTIFY_SIGNAL))
 		do_signal(regs);
 	if (test_thread_flag(TIF_NOTIFY_RESUME))
 		tracehook_notify_resume(regs);



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
