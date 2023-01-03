Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA013C3DA7D
	for <linux-um@archiver.kernel.org>; Tue,  3 Jan 2023 07:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:From:Cc:To
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gbopu6DcB5hsDpZDk55xBRbr6NOXU0ZukdBydyxjZ0E=; b=RPTKpJwqc5CS01
	/rbAxb75br3327BsqzngpS4fRs88IpphJKFUX0FqL5lxwUXpScP1pnHsbS4DzB/tXytPoAidr0DXI
	/QYN1tYaNCUB59hbba8+CFOlANKEm4HNviA9CGBh6K9eWbrcOw51f1mJiBogq51OBd0ZaOV2XJtpY
	QIcwG9dtkVGOTrseKoZl5v9uKHgM0T4WMGXmAZ0mTfFENuOHA6tE3KAj8mmzk7ELpNGdM0/nWH4Nx
	XFpiAQt8gasCYZk+3YezUyud/GgAj43nhjMr/S39UBzBBtOTc7YFXudIWwZL2bPI7UcvcNv8Wd0Jv
	CNxl2M1z23PTGTnrjSMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCbti-00HV5n-R2; Tue, 03 Jan 2023 07:39:46 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCbtN-00HUwk-EU
	for linux-um@lists.infradead.org; Tue, 03 Jan 2023 07:39:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id CD910B80E1C;
	Tue,  3 Jan 2023 07:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C89C433D2;
	Tue,  3 Jan 2023 07:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1672731562;
	bh=eWPmdF3PdeSUNMy7+C83wlhZISWVN0tbMEJRT7xl4Q0=;
	h=Subject:To:Cc:From:Date:From;
	b=pXkKAUsAvlFyMXXKmS7ATRp8ZpgzLZUU5Qr7fPLindXJPAJFQfhp8dDeiAP91Dp7x
	 p8lcxpIkBYb7ZqAcMoj/78NrzjksAhTIhpZWxs8PGxj5r5+2+nDM7A2tvHabNlK4uf
	 SKs7RcLJNxcD+Tu7PTIgcjMi2RUEmNi8k2WEaeB0=
Subject: Patch "um: add support for TIF_NOTIFY_SIGNAL" has been added to the 5.10-stable tree
To: anton.ivanov@cambridgegreys.com,axboe@kernel.dk,gregkh@linuxfoundation.org,linux-um@lists.infradead.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Jan 2023 08:36:32 +0100
Message-ID: <16727313928556@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230102_233926_009332_D952382C 
X-CRM114-Status: GOOD (  16.61  )
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


This is a note to let you know that I've just added the patch titled

    um: add support for TIF_NOTIFY_SIGNAL

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     um-add-support-for-tif_notify_signal.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 9b4d7860ca092440b774c82827455f53e649ee0f Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 9 Oct 2020 15:47:28 -0600
Subject: um: add support for TIF_NOTIFY_SIGNAL

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


Patches currently in stable-queue which might be from axboe@kernel.dk are

queue-5.10/x86-process-setup-io_threads-more-like-normal-user-space-threads.patch
queue-5.10/powerpc-add-support-for-tif_notify_signal.patch
queue-5.10/eventfd-provide-a-eventfd_signal_mask-helper.patch
queue-5.10/fs-provide-locked-helper-variant-of-close_fd_get_file.patch
queue-5.10/relay-fix-type-mismatch-when-allocating-memory-in-re.patch
queue-5.10/eventfd-change-int-to-__u64-in-eventfd_signal-ifndef.patch
queue-5.10/io_uring-pass-in-epoll_uring_wake-for-eventfd-signaling-and-wakeups.patch
queue-5.10/blk-mq-fix-possible-memleak-when-register-hctx-faile.patch
queue-5.10/fix-handling-of-nd-depth-on-lookup_cached-failures-in-try_to_unlazy.patch
queue-5.10/net-provide-__sys_shutdown_sock-that-takes-a-socket.patch
queue-5.10/task_work-unconditionally-run-task_work-from-get_signal.patch
queue-5.10/openrisc-add-support-for-tif_notify_signal.patch
queue-5.10/signal-add-task_sigpending-helper.patch
queue-5.10/net-remove-cmsg-restriction-from-io_uring-based-send-recvmsg-calls.patch
queue-5.10/alpha-add-support-for-tif_notify_signal.patch
queue-5.10/nios32-add-support-for-tif_notify_signal.patch
queue-5.10/ia64-don-t-call-handle_signal-unless-there-s-actually-a-signal-queued.patch
queue-5.10/task_work-remove-legacy-twa_signal-path.patch
queue-5.10/revert-proc-don-t-allow-async-path-resolution-of-proc-self-components.patch
queue-5.10/m68k-add-support-for-tif_notify_signal.patch
queue-5.10/s390-add-support-for-tif_notify_signal.patch
queue-5.10/um-add-support-for-tif_notify_signal.patch
queue-5.10/tools-headers-uapi-sync-openat2.h-with-the-kernel-sources.patch
queue-5.10/kernel-provide-create_io_thread-helper.patch
queue-5.10/iov_iter-add-helper-to-save-iov_iter-state.patch
queue-5.10/arc-unbork-5.11-bootup-fix-snafu-in-_tif_notify_signal-handling.patch
queue-5.10/arch-ensure-parisc-powerpc-handle-pf_io_worker-in-copy_thread.patch
queue-5.10/csky-add-support-for-tif_notify_signal.patch
queue-5.10/arm-add-support-for-tif_notify_signal.patch
queue-5.10/kernel-stop-masking-signals-in-create_io_thread.patch
queue-5.10/fs-expose-lookup_cached-through-openat2-resolve_cached.patch
queue-5.10/task_work-add-helper-for-more-targeted-task_work-canceling.patch
queue-5.10/nds32-add-support-for-tif_notify_signal.patch
queue-5.10/signal-kill-jobctl_task_work.patch
queue-5.10/hexagon-add-support-for-tif_notify_signal.patch
queue-5.10/sh-add-support-for-tif_notify_signal.patch
queue-5.10/riscv-add-support-for-tif_notify_signal.patch
queue-5.10/h8300-add-support-for-tif_notify_signal.patch
queue-5.10/io_uring-import-5.15-stable-io_uring.patch
queue-5.10/sparc-add-support-for-tif_notify_signal.patch
queue-5.10/blktrace-fix-output-non-blktrace-event-when-blk_clas.patch
queue-5.10/eventpoll-add-epoll_uring_wake-poll-wakeup-flag.patch
queue-5.10/parisc-add-support-for-tif_notify_signal.patch
queue-5.10/entry-add-support-for-tif_notify_signal.patch
queue-5.10/x86-wire-up-tif_notify_signal.patch
queue-5.10/task_work-use-tif_notify_signal-if-available.patch
queue-5.10/drbd-fix-an-invalid-memory-access-caused-by-incorrec.patch
queue-5.10/kernel-don-t-call-do_exit-for-pf_io_worker-threads.patch
queue-5.10/kernel-allow-fork-with-tif_notify_signal-pending.patch
queue-5.10/pata_ipx4xx_cf-fix-unsigned-comparison-with-less-tha.patch
queue-5.10/mips-add-support-for-tif_notify_signal.patch
queue-5.10/xtensa-add-support-for-tif_notify_signal.patch
queue-5.10/c6x-add-support-for-tif_notify_signal.patch
queue-5.10/microblaze-add-support-for-tif_notify_signal.patch
queue-5.10/net-add-accept-helper-not-installing-fd.patch
queue-5.10/ia64-add-support-for-tif_notify_signal.patch
queue-5.10/arm64-add-support-for-tif_notify_signal.patch
queue-5.10/arc-add-support-for-tif_notify_signal.patch
queue-5.10/revert-proc-don-t-allow-async-path-resolution-of-proc-thread-self-components.patch
queue-5.10/fs-make-do_renameat2-take-struct-filename.patch
queue-5.10/kernel-remove-checking-for-tif_notify_signal.patch
queue-5.10/arch-setup-pf_io_worker-threads-like-pf_kthread.patch
queue-5.10/nvme-pci-fix-mempool-alloc-size.patch
queue-5.10/fs-add-support-for-lookup_cached.patch

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
