Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437D1CDB46D
	for <linux-um@archiver.kernel.org>; Sat, 20 Jun 2026 03:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ipyo0A26I6KXuc8v9xpKUuVMO/nd9Gz0uNh0ITUISt4=; b=YuKx+/TZ7BCdTJYXTirNKrkJcr
	YnjBXwn+DwyJQqR1z2e1RlrQaHgmcJqJaxODhRWuL/9qCrh1v2AlPY7hcdd71psejeuA4YxNAX0tJ
	AbnxmxiTdA+OudlqREjwJ7CGpsAaztcEOdvhbtHGIZtXomzWsobevPL5iO+JBn4kIJ3a26aNfi7/g
	XWWTKpSwird/FoAa6MAv5jnfkKOpM2wiVLowE/0RFE+8tzgAsdSRyxYHLVfd9RnkLlnipalCBavCU
	kUUt4mh2zJbsebwk3dr4inv3GySVu/qSaSqZBeR/8XUcdIYn97r4eastLaaHrS0yUMigPxxjCQr5l
	XOXy6ffA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIQ-000000038vR-3dFc;
	Sat, 20 Jun 2026 03:23:02 +0000
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIN-000000038sY-0Rfu
	for linux-um@lists.infradead.org;
	Sat, 20 Jun 2026 03:23:00 +0000
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-30bcdf8232fso5991678eec.0
        for <linux-um@lists.infradead.org>; Fri, 19 Jun 2026 20:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925778; x=1782530578; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipyo0A26I6KXuc8v9xpKUuVMO/nd9Gz0uNh0ITUISt4=;
        b=bROP7/XEr1v55Tl1fVm/hLAKyuxsDjx4Rq5bnCBAe/Xt6fsUE1eXSxlTJa6TrE+5rm
         AMjvJYeE/os3QWRSyENugrOH1TmEormKqiKOpN+KGoF/2oos94uQHZGXD5HcW41c3iNf
         SvnC6QjIgj3e6L9Sga5z4k/IIY5j8e9jpkPTJA/9osN1OQnJvTcXBxH1MyubcLPPwVli
         AfLFU6sI8MJkhN0kSNYtDU3ttlPVndBC5nf9sGnzBrK0Ks4X1rAX6E47WmGBLBlpglF5
         WM2TJwWn767s8WwFV1wRO1BVhlB36DbfQFjd96Y+a2ZE4SilGdPj21AdoF9zRkypNbNK
         63iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925778; x=1782530578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ipyo0A26I6KXuc8v9xpKUuVMO/nd9Gz0uNh0ITUISt4=;
        b=XViInzecVXgNKRjTQIbUFo2t2fGX1/RsrEb6/YbTafgGFfFZko03SNM79mbkbb0VZE
         /yKwDuZkNIJaK4cv2iLn2/AHkA9VN3dsxJ9g2JmwCe9jwtOAmM/ZWhxbDNzOONbD2JDd
         oxMHSbLuR7R4icb38YbCIJ+AxXmr19B/IGnUiFIT3Mk4VGpG36kfVV+uyCcVu8yDUZj7
         t4mu8ChbDqV45yIgdVe6e/A73g7AfGXdHMN8Flp4i3G/o5os+Y4VdOIztivAR3qnW3CR
         W9kxS7RCvFhgSj4DxQ3Xr2zRRGj9Bn8I/t/G3B+wXWn6tfqqs758fiWeebkVnY9moekO
         U5uw==
X-Forwarded-Encrypted: i=1; AFNElJ+1CtCfjeXQJhLkpfIAQmaKAOKZ+N8GEzrms/+KSOHrsbwGPYpTu2dtAok+JcauRVFw46ZuoJ/ryw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0N3nX8eI/dXeUvqjuf32QvQW4m8Y/KWIaXu47Csw9SMqgH3Wx
	FQuikNbxIj4TqYbm14Du/KpsEDyMF9jO/P0azQZCqAXcgIHw+yTYbUIw
X-Gm-Gg: AfdE7cmYzlXj9BrK4Qjw/udOV8Ar8VEIawjdpqWpKpKAwhKZLtwWrIU0g4OuDi5vcr4
	wfWewqrjqVaBLCTXfGmMkA9BWoPeiaEG9w7ZGf77DQDlbvY7GfJYAvnIt/i+TVstx44+y1nRpUn
	nNgWM7rLqzllQQ2mtn+BpZuuNtLsAPm67QY7WConBzbcGZHuN9xj0uYDvJoxbvi8xNyo1HNljZ2
	d28qeEknGbCKvSp9WLo4miy5CvA33hJ8NPE27NyFDmmI0GP31A3eV9cWtP3jEg3d4WzIEsOQNbq
	JhxSlYHo5//5auJ78SsQD7xS50/HshgFhmm/bGkD1aFZ4w4NMhVJB4/HtGvXalaYVHVRjmOojR9
	5yzp1qsf9YScmi/eBtjtVM43uJy5i6j+CrIJ4btFgetnUP1SRLWKq4To00X2qW2D+lcnQykVFgv
	VGS4JMt4COGNgwgWCo1EVEZto/nyWnxQpku8wCaba09ObJXOU5iA==
X-Received: by 2002:a05:7301:3d17:b0:304:df0e:9db2 with SMTP id 5a478bee46e88-30c07035e0dmr3324120eec.24.1781925778165;
        Fri, 19 Jun 2026 20:22:58 -0700 (PDT)
Received: from pop-os.. ([2601:647:6802:dbc0:ce45:b713:5d9f:6abd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f14fsm1902019eec.5.2026.06.19.20.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:22:57 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 4/7] um: skas: handle out-of-batch stub mmap notifications
Date: Fri, 19 Jun 2026 20:22:21 -0700
Message-ID: <599277ebecd4c7896c475553797d6969fd793efb.1781925126.git.xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781925126.git.xiyou.wangcong@gmail.com>
References: <cover.1781925126.git.xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260619_202259_636737_4AF281EF 
X-CRM114-Status: GOOD (  14.29  )
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

From: Cong Wang <cwang@multikernel.io>

The mmap validation so far only runs for mmaps the monitor itself queued.
A hijacked stub can instead jump to the in-stub mmap on its own, outside
any batch. Such an mmap traps to the USER_NOTIF listener and suspends
in-kernel (so it discloses nothing) but it never signals the monitor
via the futex, so the monitor, waiting only on the futex, would block
forever (a guest-triggered DoS of the whole UML).

Drain the listener whenever the wait wakes: after each FUTEX_WAIT in
wait_stub_done_seccomp() (which already wakes periodically on SIGALRM and
tolerates EINTR), poll the listener non-blocking and service anything
pending. An out-of-batch mmap therefore stays suspended only until the
next wakeup and is then validated like any other: denied with -EPERM
unless it maps exactly what its PTE allows. No disclosure occurs while it
is pending, and the monitor no longer hangs.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/um/os-Linux/skas/process.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 3a31e52cdcf8..0987eb79ce76 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -32,6 +32,7 @@
 #include <linux/seccomp.h>
 #include <linux/threads.h>
 #include <sys/ioctl.h>
+#include <poll.h>
 #include <timetravel.h>
 #include <asm-generic/rwonce.h>
 #include "../internal.h"
@@ -215,6 +216,21 @@ static int seccomp_notify_serve(struct mm_id *mm_idp)
 	return 0;
 }
 
+static void seccomp_notify_drain(struct mm_id *mm_idp)
+{
+	struct pollfd pfd = {
+		.fd = mm_idp->seccomp_notify_fd,
+		.events = POLLIN,
+	};
+
+	if (mm_idp->seccomp_notify_fd < 0)
+		return;
+
+	while (poll(&pfd, 1, 0) > 0 && (pfd.revents & POLLIN))
+		if (seccomp_notify_serve(mm_idp) < 0)
+			break;
+}
+
 static void seccomp_serve_mmaps(struct mm_id *mm_idp)
 {
 	struct stub_data *data = (void *)mm_idp->stack;
@@ -265,6 +281,9 @@ void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
 				       __func__, errno);
 				goto out_kill;
 			}
+
+			/* Handle any stub mmap that trapped out of band. */
+			seccomp_notify_drain(mm_idp);
 		} while (data->futex == FUTEX_IN_CHILD);
 
 		if (__READ_ONCE(mm_idp->pid) < 0)
-- 
2.43.0


