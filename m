Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F53C98302
	for <linux-um@archiver.kernel.org>; Tue, 22 Sep 2026 19:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kEUEdL6PQ0y4Z2Ibs3e9Oc0v1TI6Cd/Tg+0kQahnhZg=; b=jpg9N6he7CwbPKlwWSyqu9mSIW
	oNJBlkI+F1vn59OjJpx5zz55TSmcnitd6g49ymWFyCAlPXxBBRfhF+7Hi8vKLIO4TwxJTxtxgPQjL
	CWfa1EvflEStBOvaJA8WXantC8uBMUPelFKC7j5akyDZvIIoRUW6LVbnqE2E4wSlekZQFhFdKNf9J
	ncuoS98AatNn6GSyFllYXEER35ESy6QlxG6jYOhPGnfjzQAPnz9xuf/sEqxo3714RpzImgQhRy1bK
	UJek3scYmKxAnIwe4bhZwehvv9relSxMT0eVQDbf4JEM59DpSU1fvwnCyecDQhyvs74sJmPX1hfh3
	/rc4s62g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9639-00000006NX2-0qhI;
	Tue, 22 Sep 2026 19:21:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9635-00000006NVw-45pL
	for linux-um@lists.infradead.org;
	Tue, 22 Sep 2026 19:21:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790104861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kEUEdL6PQ0y4Z2Ibs3e9Oc0v1TI6Cd/Tg+0kQahnhZg=;
	b=bj6R+uBxbdNHQbqh5SSiBldMXvLidSILP5KU4Rs/ZWuknqxmhcOCS/8h5mUMZtkxorYpW+
	ceZvRRk23DOu3d3aj80vr4s+g6FIVH7VsaLFXtU2IZxdPmeTYxDWiic9y8DG0b0nvh0wHe
	mChQn0SApZSdX1vWTOtZso2k50P1twQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546--qBL0tg0PMOQ1u-kgEOasQ-1; Tue,
 22 Sep 2026 15:20:56 -0400
X-MC-Unique: -qBL0tg0PMOQ1u-kgEOasQ-1
X-Mimecast-MFC-AGG-ID: -qBL0tg0PMOQ1u-kgEOasQ_1790104852
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E30618011F0;
	Tue, 22 Sep 2026 19:20:47 +0000 (UTC)
Received: from wsxc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F291530001B9;
	Tue, 22 Sep 2026 19:20:23 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	bpf@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	sgrubb@redhat.com,
	oleg@redhat.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	monstr@monstr.eu,
	tsbogend@alpha.franken.de,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	tglx@kernel.org,
	peterz@infradead.org,
	luto@kernel.org,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v3 00/14] audit: log all six syscall arguments in the SYSCALL record
Date: Tue, 22 Sep 2026 16:19:52 -0300
Message-ID: <cover.1790088067.git.rrobaina@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: r_y46dWxPW4SCmq3Qd5SvkbLdzpOO4ktvMGn9-fj0jU_1790104852
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_122104_115465_AAC3B7E2 
X-CRM114-Status: GOOD (  14.07  )
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

The SYSCALL record currently logs only four of the six syscall
arguments (a0-a3), silently discarding the remaining two. This
leads to the need for auxiliary records when audit-relevant
data lands in the 5th or 6th argument of a syscall.

This series extends the SYSCALL record to log all six arguments,
by adding arguments a4 and a5 inline within the existing record.

Rather than plumbing two more argument registers through every
architecture's syscall entry path, audit_syscall_entry() now takes a
struct pt_regs * and retrieves all six arguments itself via
syscall_get_arguments(); the per-arch patches simply pass regs. The two
new arguments are also wired into the audit filter, so rules can match
on a4 and a5.

To keep the series bisectable, the new pt_regs-based helpers are added
first (patch 1), each architecture is converted one per patch, and the
final patch removes the legacy argument-register helpers and renames the
new ones back to audit_syscall_entry(). Every commit builds on its own.

The audit testsuite runs successfully:

 # make test
 make -C tests test
 Running as   user    root
        with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
        on   system  Fedora

 amcast_joinpart/test ................. ok
 backlog_wait_time_actual_reset/test .. ok
 bpf/test ............................. ok
 coredump/test ........................ ok
 exec_execve/test ..................... ok
 exec_name/test ....................... ok
 fanotify/test ........................ ok
 field_compare/test ................... ok
 file_create/test ..................... ok
 file_delete/test ..................... ok
 file_permission/test ................. ok
 file_rename/test ..................... ok
 filter_device/test ................... ok
 filter_exclude/test .................. ok
 filter_exit/test ..................... ok
 filter_inode/test .................... ok
 filter_saddr_fam/test ................ ok
 filter_sessionid/test ................ ok
 io_uring/test ........................ ok
 login_tty/test ....................... ok
 lost_reset/test ...................... ok
 netfilter_pkt/test ................... ok
 signal/test .......................... ok
 syscalls_file/test ................... ok
 syscall_module/test .................. ok
 syscall_socketcall/test .............. ok
 time_change/test ..................... ok
 user_msg/test ........................ ok
 All tests successful.
 Result: PASS

Changes in v3:
- Make the series bisectable, as requested by Will Deacon. Rather
  than changing __audit_syscall_entry()'s signature in place (which
  broke the build between the core patch and the per-arch conversions),
  patch 1 now adds audit_syscall_entry_regs()/__audit_syscall_entry_regs()
  alongside the existing helpers. The per-arch patches switch to the new
  helpers, and the final patch removes the legacy helpers and renames
  the new ones back to audit_syscall_entry().
- Drop the alpha conversion patch. Per Magnus Lindholm, alpha is
  being moved onto the generic entry framework, which removes its
  private syscall_trace_enter() and routes syscall auditing through
  syscall_enter_audit(); no alpha-specific change is needed once that
  series lands. This series should therefore be applied on top of it.
- Add "parisc: mask compat syscall arguments in syscall_get_arguments()"
  (new patch 8). Moving argument retrieval into syscall_get_arguments()
  would otherwise drop the low-32-bit masking parisc previously did
  inline in its compat audit path, exposing the upper 32 bits of the
  argument registers to audit (and seccomp) for 32-bit tasks. Mask in
  the helper instead, before the parisc conversion, so the series stays
  correct and bisectable.

Changes in v2:
- Rework the core change per Will Deacon's suggestion: instead of
  plumbing all six arguments through every architecture's syscall
  entry path, __audit_syscall_entry() now takes a struct pt_regs *
  and retrieves the arguments itself via syscall_get_arguments().
- Per-arch patches now simply pass regs instead of the individual
  argument registers.
- Fetch the arguments directly into context->argv, dropping the
  temporary array.

Ricardo Robaina (14):
  audit: log all six syscall arguments in the SYSCALL record
  arm: pass pt_regs to audit_syscall_entry()
  arm64: pass pt_regs to audit_syscall_entry()
  csky: pass pt_regs to audit_syscall_entry()
  microblaze: pass pt_regs to audit_syscall_entry()
  mips: pass pt_regs to audit_syscall_entry()
  openrisc: pass pt_regs to audit_syscall_entry()
  parisc: mask compat syscall arguments in syscall_get_arguments()
  parisc: pass pt_regs to audit_syscall_entry()
  sh: pass pt_regs to audit_syscall_entry()
  sparc64: pass pt_regs to audit_syscall_entry()
  um: pass pt_regs to audit_syscall_entry()
  xtensa: pass pt_regs to audit_syscall_entry()
  audit: rename audit_syscall_entry_regs() to audit_syscall_entry()

 arch/arm/kernel/ptrace.c          |  3 +--
 arch/arm64/kernel/ptrace.c        |  3 +--
 arch/csky/kernel/ptrace.c         |  2 +-
 arch/microblaze/kernel/ptrace.c   |  2 +-
 arch/mips/kernel/ptrace.c         |  4 +---
 arch/openrisc/kernel/ptrace.c     |  3 +--
 arch/parisc/include/asm/syscall.h | 18 ++++++++++++------
 arch/parisc/kernel/ptrace.c       |  9 ++-------
 arch/sh/kernel/ptrace_32.c        |  3 +--
 arch/sparc/kernel/ptrace_64.c     |  4 +---
 arch/um/kernel/ptrace.c           |  6 +-----
 arch/xtensa/kernel/ptrace.c       |  4 +---
 include/linux/audit.h             | 13 ++++---------
 include/uapi/linux/audit.h        |  2 ++
 kernel/audit.h                    |  2 +-
 kernel/auditfilter.c              |  2 ++
 kernel/auditsc.c                  | 19 ++++++++-----------
 kernel/entry/syscall-common.c     |  4 +---
 18 files changed, 42 insertions(+), 61 deletions(-)

-- 
2.55.0


