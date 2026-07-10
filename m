Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF33C44501
	for <linux-um@archiver.kernel.org>; Fri, 10 Jul 2026 20:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=13qA2fJAs5tJqvbMzl890ijH0mJhzYe7F+N4H+bA7a0=; b=hC6ba8Dv0afD1ifa319QAuZTMj
	67wYMBUVQM2UOGb7glRoMQEeNPyUDUkqwtVgUvy8d0ZBQvH/qtzXkw39zftl2zZ8YB95pAAQY6mrS
	FFEw1l3Y3QAgGYYSYOYr8x/WWD/d6/XAz//7sQzfBfLnCV1Ij5ewN/DtHZOqdUmioWPZ06ei0WOq6
	CQAF2NYuOMQmRCzqmr4/eqbixtStMaSfgHNjsHlUxIVn3dAvgggQc8yUHoaOXWp0AwbSSMAoUUrZW
	TiUB+EXafdTF7IHqFRFgx5WRfIj7Z4asGJ4/mhHUkbhk55XhYCn/gYL5Ck7n95ElCJtpEo2umQhpo
	W9glNOwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIEQ-00000005jel-11jV;
	Fri, 10 Jul 2026 20:53:58 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIEN-00000005jds-3OOq
	for linux-um@lists.infradead.org;
	Fri, 10 Jul 2026 20:53:57 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso1379918a91.2
        for <linux-um@lists.infradead.org>; Fri, 10 Jul 2026 13:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783716834; x=1784321634; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=13qA2fJAs5tJqvbMzl890ijH0mJhzYe7F+N4H+bA7a0=;
        b=XN+GFoE28RMqWCDNyrTNJupPhtGKmE4/Fn/QQIp96GYDfRz2n59Ltjb8plXVV7WizM
         KeUPkyjBBpPy833DxtXFTB8Ono7zS3eoEfDK3zE/lZOhmhIZp2pLwEmzZZkUNJ5T1OVq
         OJnBuwnCpBuNguegapbcM69fkCe0RcTWz68QbJWOopBAK1T3l99x2Eo50TP6cvQNjpoT
         r1r+utEpoWnd1dt3jCXoFJn/bO2eQ9i1H/nT5y/7GDqfAr+UsL1ZAVQWoUMFgYxISkCY
         r2P3zpK5iVf8zoXxZgjhF0+aQHhWgV98f2BeMjPnVDngx3P8RIM9kOgPteoMeXsxESx8
         /iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783716834; x=1784321634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=13qA2fJAs5tJqvbMzl890ijH0mJhzYe7F+N4H+bA7a0=;
        b=DLyfaoe7iEktGrRRB907ysI3AyE82FFF/K8JqUN+U9IBHzqTEaMUUTCqHX+nocXNB2
         JDgVEbCbxQnvTKggyr9A1aZ4+HJLEQtZU09Qj8UyfP53lvS8GBae0EKd5Xk3Cwq9mlTb
         uMFMck8ruFqEjX5jFl8mhCPKXsFvADZNotpiY0+SnMVEboBmx5diFcDz1Czj1EouIIxY
         mgx9aAB3G9Hb0x1srybrOpnSwTgH4jZ93JfXWG0PW57z1Vt2gZDFWsCELkGyFgm7Oy56
         LdT9KWSLvK7QVDZZ25ioiKzTzJLw5l0UGFKC/iVvoFyftykO5fk0T/qxeHQNM5nIQEUG
         NSEg==
X-Forwarded-Encrypted: i=1; AHgh+RoG4BPwFEWrMFIGgOEoOYVUa1Tg+05Nrx95XvmIkxpfuNNY+Gi5sAo+7YMWFmB/2xiflVkkTMxRMA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx63OM6JaobBKzFmK3Gus4U/fzhMx2dKNBwKYGkpsybExPrOS42
	Vk7eLlgo9vIcw8CozFWCOMWPpDcI9SqxqR+FP9KyW/UAFMrhphHNJoJX
X-Gm-Gg: AfdE7cnEGA20F/sKESgmwb71ywhjFZ9tmDueDoOph4swKyvN7DOldLmdjWE07YZH5X7
	1SD4+R6kiyBQ5HqTYJxXOXQG8fR0bPePDMbjfWaQc0qoYVEd68euAFPFw5xZKF654cJcwyEL5NC
	pH/XGcpKt/k8oEVoprSS7yYbj2Ldc2Ey5FBGXqjkdlyiNch6RtRAwspmQqoksf8oeDTA9LU2iHU
	200azwvmUYoarJ8kj3F9P8TlpSPOfvBERyGFbIe5n95z+Vr0WK/DLeiA8UwP+OjEuW9uwxAL4Xa
	G3R4pbVLy6kxi5jdupPluWmyGg7j0o+7BJZL9ycUcUwfOhiUP+YJ5aSEa/KNWwHVV2R4qCJcoKl
	7CCh9dxfDr9R071LoGqnJFyabBUAQMiYd9mJLDYW8P2JMgIZcRwRvKbvVdnqMXDuYrryA+QADCQ
	g3Iax6hQmUHPuArCw9pDWZ+2/7BDrpnkkfyocMXslUtsvhVK0pw/qeWZ0=
X-Received: by 2002:a05:6a21:9f17:b0:3c0:9c19:65c4 with SMTP id adf61e73a8af0-3c110aaff03mr652395637.76.1783716834255;
        Fri, 10 Jul 2026 13:53:54 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119c2a7bb5sm21724371eec.25.2026.07.10.13.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:53:53 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [RFC PATCH 0/6] um: introduce pidfd_mmap()/pidfd_munmap() syscalls
Date: Fri, 10 Jul 2026 13:53:18 -0700
Message-ID: <20260710205324.1343217-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_135355_852939_0F8ED50D 
X-CRM114-Status: GOOD (  11.77  )
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

This RFC adds two syscalls, pidfd_mmap() and pidfd_munmap(), that let a
supervisor install or remove a mapping in another process's address space
without target-side cooperation, and converts User Mode Linux to use them.

  pidfd_mmap(int pidfd, struct pidfd_mmap_args *uargs, unsigned int flags)
  pidfd_munmap(int pidfd, unsigned long addr, unsigned long len)

The backing fd (if any) is resolved in the *caller's* fd table, mirroring
pidfd_getfd()'s cross-task install model. Both are gated by
ptrace_may_access(PTRACE_MODE_ATTACH_REALCREDS); LSM/fsnotify hooks run
against the caller. pidfd_mmap() takes an extensible, size-versioned
argument struct (clone3/openat2 style) since an mmap-shaped call exceeds
the 6-argument syscall limit.

They build on the mm-side remote-install primitives vm_mmap_remote()/
vm_munmap_remote(), posted separately as:

  https://lore.kernel.org/all/20260704231831.354543-2-xiyou.wangcong@gmail.com/

UML is the motivating user. Its SKAS monitor previously installed guest
mappings by driving the stub to execute mmap/munmap itself: in seccomp
mode it passed the physmem fd to the stub over SCM_RIGHTS, and in ptrace
mode it batched STUB_SYSCALL_MMAP/MUNMAP entries for the stub to run.
pidfd_mmap() lets the monitor install mappings into the stub's mm
directly, so the stub never touches the fd or executes mmap/munmap. With
both modes converted, the entire stub-syscall batcher and the SCM_RIGHTS
fd-passing become dead code and are removed (net ~530 lines). The ptrace
conversion (patch 5) is included mainly to demonstrate the primitive's
reach; the security caveats pidfd_mmap() does *not* address (e.g. a guest
blocking SIGALRM to dodge scheduling) are preserved in stub.c.

As this is an RFC, the UML side _intentionally_ does not handle host
portability: it assumes a host kernel that provides pidfd_mmap() and
deliberately omits any detection or fallback for older hosts (which would
otherwise pick the ptrace path, or fail the seccomp probe). That belongs
in a non-RFC version and is left out here to keep the series focused on
demonstrating the impact on UML.

---

Cong Wang (6):
  pidfd: add pidfd_mmap()/pidfd_munmap() syscalls
  um: acquire a stub pidfd via CLONE_PIDFD in seccomp mode
  um: install guest mappings via pidfd_mmap() in seccomp mode
  um: forbid mmap/munmap in the stub seccomp filter
  um: install guest mappings via pidfd_mmap() in both modes
  selftests/pidfd: add pidfd_mmap()/pidfd_munmap() tests

 arch/um/include/shared/os.h                   |   4 -
 arch/um/include/shared/skas/mm_id.h           |   8 +-
 arch/um/include/shared/skas/stub-data.h       |  28 --
 arch/um/kernel/skas/mmu.c                     |   9 +-
 arch/um/kernel/skas/stub.c                    | 151 ++--------
 arch/um/kernel/skas/stub_exe.c                |  20 +-
 arch/um/os-Linux/skas/mem.c                   | 275 ++----------------
 arch/um/os-Linux/skas/process.c               |  92 ++----
 arch/um/os-Linux/start_up.c                   |   8 +-
 arch/x86/entry/syscalls/syscall_64.tbl        |   2 +
 include/linux/syscalls.h                      |   5 +
 include/uapi/linux/pidfd.h                    |  18 ++
 kernel/pid.c                                  | 132 +++++++++
 scripts/syscall.tbl                           |   2 +
 tools/testing/selftests/pidfd/Makefile        |   3 +-
 tools/testing/selftests/pidfd/pidfd.h         |  34 +++
 .../testing/selftests/pidfd/pidfd_mmap_test.c | 234 +++++++++++++++
 17 files changed, 520 insertions(+), 505 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_mmap_test.c


base-commit: 69288464b0af40a988958c0e1b29ff15ccd2acb7
-- 
2.43.0


