Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E42CDB46B
	for <linux-um@archiver.kernel.org>; Sat, 20 Jun 2026 03:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yJtTB3kYPQDo6qPyBmwUW8+Xd/EL9XzUwzLHmDVX5cg=; b=KMmrj8ANXlC8rOYSYHZy33GYwh
	Hirq5q9/aecJXPBTFVJrusvPgn+n7JXNi3i579BJYvYh+SZRRKLdpPCm5jrVHbw/H/Lu+o/Fm4xVG
	5PfSUC7XBiFZ2IiAx6n1o1GqHMnx0Bnk1OOHnMm5SPW8Xa7k3UNJtBL08CX1eUIcnE7NlFWdgZ+YU
	5cS4499OZl0MtQizGcgceNtwmBjWtuemsEVZ2bJvFIz8ZXs9kEo9h7zM2kUdK6hNPQs240b681cHU
	uQ6x89Qznx+vsx9puRW2JuC2C2mcX6LxJEHdNUzOxdMxBZX4UIy2mqiOOSmq9yEV8Sli3J+0e9B4w
	zJOG9ddg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamIK-000000038ru-48gV;
	Sat, 20 Jun 2026 03:22:56 +0000
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wamII-000000038qz-3udc
	for linux-um@lists.infradead.org;
	Sat, 20 Jun 2026 03:22:56 +0000
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-30b6dad2382so4940899eec.0
        for <linux-um@lists.infradead.org>; Fri, 19 Jun 2026 20:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925773; x=1782530573; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJtTB3kYPQDo6qPyBmwUW8+Xd/EL9XzUwzLHmDVX5cg=;
        b=C+kzKRVfcXNj25iJA/zwmb9N3jEyB9XKH7+wjecVZR4c7hPrQoxp9Jd9t9oQZzsSJi
         8CIWF5gci/u13QQ2/fQRMVqvbjiT/nO1HmrXLabg5AtV/J5qqUrWY48vY6qEfOA3rLyl
         yz6M9/ykznBPxd4PIHNtZ2DuFejwiI0e25yh13jxWFgiVYzj0RVSgIF3RGooqcabjnIk
         5paYOuQa+nfioyteqbgva+MCTA1R2xpksvdSQ7J+yxpsxgzi6a9cLc/matlpkga+ZN3I
         yw0uRIlVMz1ZgWnON6ea8//mf5z8WXrVumofDBxGfGwILB8O4dXvJdpV4NBPe+pP0T1m
         M6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925773; x=1782530573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJtTB3kYPQDo6qPyBmwUW8+Xd/EL9XzUwzLHmDVX5cg=;
        b=ko/dj/KYUbz/cpoPZZ7ioJDBKxGin49vInh/hcSl8vFr9uvWL7FsPClDs8yEIH3GgK
         Kn/9Mh5W9SksRzoNH4nlKOM1ki7VWP03FUiS86kBxrC6b63/ps17svm8ADYrbILCAVvA
         Uas7+4YsdiXdOf8bxB8aHRjR70yMZGRwof6sg5bkz1aqmtmCUmJBsjeZg+CHl+S6Baw7
         LeVcqMCc7VkM4370IY0HvbxCqAzF4ty1aSYEUh3k027/dEASR/gZzegnOL7hsqO3doys
         WxXSx3wN3YgExFmGMDQtniYySj2m2Y2nHZdd4b8IIJyyG1G/0wJ93cuItmHUf08oSa5i
         GtmA==
X-Forwarded-Encrypted: i=1; AFNElJ+0GxoOHyPvd6NthMWU9zRm0SrAmgevG4JZIEgvP0YxEWCnvM25Eh0JMDb1IkJjGanC3JRVjIb4cA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwqJ36YsDEoemHSNnpCqH+7k988RSMY10sTSgjflUaxiwixGYlQ
	0B9fykJTSE3hJo+UKcyiD6PXq+6R9wbE4MudtPHDxJyx1JVkMZMTU+MAddw/HQ==
X-Gm-Gg: AfdE7cmqcHmiykA9CVEW0JtQlSCmD/tSTGJcZHIelcYYMUjhmX1jzN2KpUAVhATU+0U
	Pvly1xQG3VMlgMYhUBIkhi+MllWJHIDbEGBZ4uYbKMNVhfqtLIQoSu8Mkyfix2S+vfSQQ6FQ5bS
	MKpJK1kxWNVac+pvENzDVwIPqvLf+53G/SUu+ayfaU34gbPILvGGbDnmyiWVu7XizV7NcaL2FmM
	IW3gTbDxSOp1c/YV5+4DHIIsVFKfJjDZh1bKzPJmqpKfnk7p4G/9urgePlWBoVBkI9BGhtHZsL/
	ed87wu4ouG7+gM2iiWn4eEhAyup8gRahJdgzTQKukOPE2O7NG8IuINYr3QAcNA90nJXu2Ig/KUU
	KOJc43gpvA6Tr6MJMVLV1gfWNJzs1M3rMHhpO8jqBGy0vNlwR1z17veUPpCJ8ry71G8Viuzo4K1
	88UkpXUwAP6rBcZnalga2m63UEFQNATeDoNAd4zUarqwesovHNaw==
X-Received: by 2002:a05:7301:fa10:b0:2ed:e12:376d with SMTP id 5a478bee46e88-30c0d2a4c7amr2417866eec.35.1781925772616;
        Fri, 19 Jun 2026 20:22:52 -0700 (PDT)
Received: from pop-os.. ([2601:647:6802:dbc0:ce45:b713:5d9f:6abd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f14fsm1902019eec.5.2026.06.19.20.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:22:51 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 0/7] um: skas: harden the seccomp userspace stub
Date: Fri, 19 Jun 2026 20:22:17 -0700
Message-ID: <cover.1781925126.git.xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260619_202254_979957_FAFEB00E 
X-CRM114-Status: UNSURE (   9.36  )
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

From: Cong Wang <cwang@multikernel.io>

In the seccomp ("SECCOMP") userspace mode, each guest userspace process
runs in a stub under a seccomp filter and traps to the monitor (the UML
kernel) on every syscall. Two items on the stub.c "Known security issues"
list could not be addressed by the filter alone:

  - a hijacked stub could mmap() arbitrary physmem offsets, which is an
    intra-guest disclosure and, on this base (single physmem fd, no
    kernel/user split), a host escape; and

  - a hijacked stub could block SIGALRM via a crafted rt_sigreturn to
    evade preemption and wedge the monitor indefinitely.

This series closes both:

  1-2: route the stub's mmap() through a SECCOMP_RET_USER_NOTIF listener
       owned by the monitor (no behavioural change yet).
  3-4: validate each mmap() against the mm's page table -- allowed iff the
       PTE already maps the requested frame with no more access than it
       grants -- including out-of-batch mmaps a hijacked stub issues on
       its own.
  5:   route and validate munmap() the same way (range-confined below
       STUB_START).
  6:   add a watchdog thread that detects a stub which stops reporting
       back (e.g. blocked SIGALRM) and SIGKILLs it, letting the monitor
       recover via the existing teardown.
  7:   drop the now-resolved "Known security issues" note and refresh the
       seccomp= help text.

After the series a hijacked stub is confined to the frames its own page
tables reference and can no longer reach arbitrary guest/host memory; one
that evades preemption is detected out of band and killed rather than
wedging the monitor.

Verified on UML (UP and 2-CPU SMP): boots and survives fork/exec storms
and heavy mmap/munmap churn with zero false denials or false kills; an
artificially SIGALRM-blocked busy loop is killed in ~5s and the monitor
recovers, while syscall-making processes are untouched. Each patch builds
and the series is bisectable.

---
Cong Wang (7):
  um: skas: create a seccomp USER_NOTIF listener and hand it to the
    monitor
  um: skas: gate stub mmap() through the USER_NOTIF monitor
  um: skas: validate stub mmap() against the guest page table
  um: skas: handle out-of-batch stub mmap notifications
  um: skas: validate stub munmap() against the guest address range
  um: skas: kill stubs that block SIGALRM via a watchdog thread
  um: skas: refresh stub security notes after closing the known issues

 arch/um/include/shared/skas/mm_id.h |   1 +
 arch/um/include/shared/skas/skas.h  |   5 +
 arch/um/kernel/skas/stub.c          |  22 --
 arch/um/kernel/skas/stub_exe.c      |  19 +-
 arch/um/kernel/skas/uaccess.c       |  48 +++++
 arch/um/os-Linux/skas/process.c     | 315 ++++++++++++++++++++++++----
 arch/um/os-Linux/start_up.c         |   6 -
 7 files changed, 344 insertions(+), 72 deletions(-)


base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
-- 
2.43.0


