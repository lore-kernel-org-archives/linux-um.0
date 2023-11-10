Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A479EC4167B
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 11:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/O1s6f5mtG9Lus+NxVEGe2Fk4f2PjIiKy6edJj/oiyE=; b=2SwBAVA+LvYGaB
	EsrLTUbaEr5Qj9GvdyZyYor9Lpvu9ykPYOLA9hX5Hc2WahHInzt+Wcbe7IDQtVnre2VNWxXrYcqDj
	f89g8GVIL8VRW5a5WArvpBMtGwxQf5yYJE9JzreplPPROBpyr/99qnj53ULBZfGYpauyEeiAdPaAz
	lNz1fCJksBUfO+r67YHnfcZK5I/9c7BuDI60fYZ/+MYe+9LP0kPH3eg+WqppIqrvhGoxSImgbe9rd
	zMr6KaTx6vDFl2p4DvyhYZA9A1sZlwVe6rDLwKibBSOx8QtNj9+oD0i+y2ulGgH7HVcRqTko11OZR
	/Dz8w0nlXxL0CZh6mibw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJF-008LuW-0q;
	Fri, 10 Nov 2023 11:04:21 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1PJD-008LrE-12
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 11:04:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=1z6Smdd7o4NVLwjNVu0wZxj7u6lnVborwjyq7DlsI0U=; t=1699614255; x=1700823855; 
	b=tvWPe89+4w7CDO/d/9fPeDg1odXoN6OZd/TJAQNfQXTCKEQvWWDx5LC3avvLf3YZzCaFhHhSiVI
	1UVnY7AryMKWN/an4Nro/mIOPR+WtKYav+yM48z+QmDkmIfYRo/Soo7k8W3qS12D6bKOrW8xioMNL
	UhyAOUOaTxw51cgOmwln4a/eM/eSnpU4vETZXfGIOnWH1g40l8BKcGomxJdbJ9dY6LMuMcUwdlF2/
	00/MLgeemGq0dIRRdN1wDhKTosb4ruwuqIQl1i5JSPYRP2fyxxhHN4qtf6HWaa5XjnsZ1OyRJY5Mx
	tWbkuwd7mU0RkD9HrBFctGwv1J6vFrWDsLxA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1r1PJ5-00000002xHc-3Z3g;
	Fri, 10 Nov 2023 12:04:12 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v3 00/11] General cleanups and fixes from SECCOMP patchset
Date: Fri, 10 Nov 2023 12:03:37 +0100
Message-ID: <20231110110348.1815612-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_030419_360321_C6727FB0 
X-CRM114-Status: GOOD (  12.49  )
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

From: Benjamin Berg <benjamin@sipsolutions.net>

Hi,

the SECCOMP patchset is not ready yet as I need to change it quite a bit
for the FD passing based security model that was proposed.

Until then, the cleanups and small fixes from the start of the patchset
are still relevant and it could be nice to pull them in anyway. So I am
resending just these.

I purely rebased the patchset. There should be no other differences
between v2 and v3 here.

Benjamin

Benjamin Berg (11):
  um: Drop support for hosts without SYSEMU_SINGLESTEP support
  um: Drop NULL check from start_userspace
  um: Make errors to stop ptraced child fatal during startup
  um: Don't use vfprintf() for os_info()
  um: Do not use printk in SIGWINCH helper thread
  um: Reap winch thread if it fails
  um: Do not use printk in userspace trampoline
  um: Always inline stub functions
  um: Rely on PTRACE_SETREGSET to set FS/GS base registers
  um: Remove unused register save/restore functions
  um: Mark 32bit syscall helpers as clobbering memory

 arch/um/drivers/chan_user.c             |  42 +++++----
 arch/um/drivers/line.c                  |  13 ++-
 arch/um/include/asm/processor-generic.h |   1 -
 arch/um/include/shared/kern_util.h      |   3 +-
 arch/um/include/shared/os.h             |   3 -
 arch/um/include/shared/ptrace_user.h    |  41 ---------
 arch/um/include/shared/registers.h      |   2 -
 arch/um/kernel/process.c                |  12 +--
 arch/um/kernel/ptrace.c                 |   2 -
 arch/um/kernel/signal.c                 |  12 ---
 arch/um/os-Linux/registers.c            |  20 ----
 arch/um/os-Linux/skas/process.c         | 117 ++++++++----------------
 arch/um/os-Linux/start_up.c             | 111 ++++------------------
 arch/um/os-Linux/util.c                 |  19 +++-
 arch/x86/um/asm/elf.h                   |   4 +-
 arch/x86/um/asm/processor_64.h          |   3 -
 arch/x86/um/os-Linux/Makefile           |   1 -
 arch/x86/um/os-Linux/prctl.c            |  12 ---
 arch/x86/um/ptrace_32.c                 |  24 -----
 arch/x86/um/ptrace_64.c                 |  26 ------
 arch/x86/um/shared/sysdep/ptrace_32.h   |   4 -
 arch/x86/um/shared/sysdep/ptrace_user.h |  12 +--
 arch/x86/um/shared/sysdep/stub_32.h     |  39 ++++----
 arch/x86/um/shared/sysdep/stub_64.h     |  17 ++--
 arch/x86/um/syscalls_64.c               |  62 +++----------
 arch/x86/um/tls_64.c                    |   2 +-
 26 files changed, 159 insertions(+), 445 deletions(-)
 delete mode 100644 arch/x86/um/os-Linux/prctl.c

-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
