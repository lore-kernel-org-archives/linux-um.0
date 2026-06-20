Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD6CCD98F6
	for <linux-um@archiver.kernel.org>; Sat, 20 Jun 2026 03:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+rpRVe9Hsw2jSF3s9E1dtu3MLLkjm3viLJHyanmAnm4=; b=01sr6YIU0z/fs6lei5sZDHFj+x
	hhNGiaTrM1ClIe3/TAdNaBzezlHBW3crY1BtFn2oBtpOQEUJ4SOLBE2D6T1nU9j0HBbGT3eE8YZ4/
	SjuHZV5iDQjVB+jFTmd8Hypso095iHow3yR8KNs9DLPtpS+2thY33k1gjp3WeNUDeO3IR6wCtnzbE
	DLhXRyeyaWnwo+B2cHbj2wnsw4fZN/2QLigf6foeLwHndj8d6fd1xbxGEsexkgJziQZd8WC8LCqlm
	EZb7k+f06YXXbZhQNdEXHsaKVgVSaCdQhDRaFPm65ri0oly/7N7ld6LwBey2228Z9xaalrLtQgxMD
	sKJ4NzNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIX-0000000390E-0Wim;
	Sat, 20 Jun 2026 03:23:09 +0000
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIS-000000038wY-1CPb
	for linux-um@lists.infradead.org;
	Sat, 20 Jun 2026 03:23:07 +0000
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-139aff562e1so97421c88.1
        for <linux-um@lists.infradead.org>; Fri, 19 Jun 2026 20:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925783; x=1782530583; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rpRVe9Hsw2jSF3s9E1dtu3MLLkjm3viLJHyanmAnm4=;
        b=pbWvlwzX+3sp7tsJqhd4AVsgSktS63JwcF0sGD4/WucXn9zH1Qrhsijl8mYgZHYTkQ
         rbIhwGR5fnThLbjribAwXWcjh4zEC+Ne0xkS4sVTWUOSqm+c/5BvB/yBzXgSy9LOvb7Y
         B0lxYcvAanAT9YbN0UPw8Wibjxsn+W7aty/ERDVNClNPWwjpGy/jiAjFFVzC35E7XMp9
         1UsN4nJNWhjFMIB4Z5SrYILzail858Sq2umwmxuXEubSE2wKDK4iBafcGGraUb9UzQFa
         XT+TbHM7jtDK+4vfI/NnRjen0ZKHS7IjwYZXOJUa/mn7Ij33V5FVShJwUChNITfJGzBy
         ID8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925783; x=1782530583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+rpRVe9Hsw2jSF3s9E1dtu3MLLkjm3viLJHyanmAnm4=;
        b=ooDMxf18vnOe8CaK35MGgiKwv80KgPD7fNfiDgObwbrCc/p4lR68nytwXvgdnwsdJo
         3x5gLcmwhyx4mtIekINf+3z+GFiPL2xsIdmApbH8mAlnGcKSjMOciGYYBve7c5KEc3fj
         yCOfVe6Dk18GpIp/n36jWFXzRe0e9/EuPcDt0Mf2Ot490jHxsVbM9fqIZ3rahrQJa+jJ
         0VIhUEcpdNYfJUbJNmqF9oXFiMC83SuBIcptMhmbQnzjJBveO37qYcjfJmGuBPyd3H4E
         0qhKxKLTsYrIGuQ2nYL47CQ/hKNc3Jw+npc15SXswqM8PMdySRvlILYbBXwIPnYKWn+K
         7LdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ztc0Y5z0p+5/Zcx9fmTY2DOibKUG8clZIW41B1H1ckJdC3vVHx+UAHg+9qBeP9gK+owlMEwwoWQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxjLBT13cL1kanVUaZjDJ73xx4QKrPL7dtfFZvP3Pxe0sEDtDqD
	XSLyeiJX6cTFYaToUCV1a+e0cgIgSE3DCFWWlbMXdVBnnWteZaTOt6zu
X-Gm-Gg: AfdE7clfDZjA9sR/WINVepe87umTp/GodEEKxbc4J7ADD/896wR8wWcLyCMwTH3WcYj
	AZu+yljUZJChiGgB8HasySNXuUU21VB/z/RWMtd9KI0jRcJ8DWgcM5O2bJWKRNkfzIubnLghTdP
	F7yJTft7Dwkk9ndlcjWe0DfMb68dte1ZT/OHqTYrqbA3zKUAoBN3CgxvbiH7DQWv4V29+5p1ils
	KW2pP5ACSrfUV/KIz3IDlvWVxOW1HisklEEa2jMlByadPaHEErPMbxaxgOF4TcuIt+BmKkO8MWM
	FpCuxoE4chSu5v7TwybbGIhkoMPDmIb1HBpO3exnqcm9VGdcjFDTnzqe3WGKXXcmm1yP+m2ZS+F
	oXKyFXHQG5CCKRXCRSs/7mHDJUKDs/13AmniJHtddZbpxL5JtcKXJi3DI4BDniogBtL5A1CRZv/
	D23n9XgDZCMQolfNoVMeOcDOjPdsTWivYeHIJrK/kYzLOD6Az67g==
X-Received: by 2002:a05:701b:4353:b0:139:abb7:a9c0 with SMTP id a92af1059eb24-139abb7aa79mr925800c88.12.1781925783269;
        Fri, 19 Jun 2026 20:23:03 -0700 (PDT)
Received: from pop-os.. ([2601:647:6802:dbc0:ce45:b713:5d9f:6abd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f14fsm1902019eec.5.2026.06.19.20.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:23:01 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 7/7] um: skas: refresh stub security notes after closing the known issues
Date: Fri, 19 Jun 2026 20:22:24 -0700
Message-ID: <d54d4b5fc21b2f3b027c73876292c07bdad58e3e.1781925126.git.xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781925126.git.xiyou.wangcong@gmail.com>
References: <cover.1781925126.git.xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260619_202304_390271_8F87D535 
X-CRM114-Status: GOOD (  15.70  )
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

Drop the stale comment and update the seccomp= setup help text, which still
warned about these exact issues and labelled the mode "insecure".

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/um/kernel/skas/stub.c  | 22 ----------------------
 arch/um/os-Linux/start_up.c |  6 ------
 2 files changed, 28 deletions(-)

diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
index e09216a20cb5..7845638d595d 100644
--- a/arch/um/kernel/skas/stub.c
+++ b/arch/um/kernel/skas/stub.c
@@ -9,28 +9,6 @@
 #include <sys/socket.h>
 #include <errno.h>
 
-/*
- * Known security issues
- *
- * Userspace can jump to this address to execute *any* syscall that is
- * permitted by the stub. As we will return afterwards, it can do
- * whatever it likes, including:
- * - Tricking the kernel into handing out the memory FD
- * - Using this memory FD to read/write all physical memory
- * - Running in parallel to the kernel processing a syscall
- *   (possibly creating data races?)
- * - Blocking e.g. SIGALRM to avoid time based scheduling
- *
- * To avoid this, the permitted location for each syscall needs to be
- * checked for in the SECCOMP filter (which is reasonably simple). Also,
- * more care will need to go into considerations how the code might be
- * tricked by using a prepared stack (or even modifying the stack from
- * another thread in case SMP support is added).
- *
- * As for the SIGALRM, the best counter measure will be to check in the
- * kernel that the process is reporting back the SIGALRM in a timely
- * fashion.
- */
 static __always_inline int syscall_handler(int fd_map[STUB_MAX_FDS])
 {
 	struct stub_data *d = get_stub_data();
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 054ac03bbf5e..b01942bec953 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -452,12 +452,6 @@ __uml_setup("seccomp=", uml_seccomp_config,
 "    This method is overall faster than the ptrace based userspace, primarily\n"
 "    because it reduces the number of context switches for (minor) page faults.\n"
 "\n"
-"    However, the SECCOMP filter is not (yet) restrictive enough to prevent\n"
-"    userspace from reading and writing all physical memory. Userspace\n"
-"    processes could also trick the stub into disabling SIGALRM which\n"
-"    prevents it from being interrupted for scheduling purposes.\n"
-"\n"
-"    This is insecure and should only be used with a trusted userspace\n\n"
 );
 
 void __init os_early_checks(void)
-- 
2.43.0


