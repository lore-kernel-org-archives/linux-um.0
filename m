Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B46EC5CFCF
	for <linux-um@archiver.kernel.org>; Thu, 13 Aug 2026 17:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o+r4ruNkApE26fuyn6KtkFW0QuXubfwA1Uwqu5ezEYw=; b=vJcOEbZZTjTQbgl1e3WJu60Bae
	VYSPKYMjyiNbCS2ZSvOjJDrctEAqjJA47kDbZ8+ACppSydqPEW9c1rGCB/v6IYvPBf5RkjsR8e6HJ
	TK5EyMfpnhjv7KTg4t9rC/P/sm2HewZr62hA9fgeLkuRMCAJsDO0LpOhqsoO1NtDZCR2QhLUmxUSo
	mTnUTtta2/rMUcRepKwvOl7sRGYrCoIYXMDL3M5yMKuEhNFk3DS332azN3VIC7mDjgTg7XOvEq6AK
	Yt5Ij9q88AEj9krz6/0BN9dy1UXUQJk1lh8zi9MWqttKO1AftEbL9DTOMzj6CJdVBUgu5ZfAQjpPG
	8fDwEYKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYqc-00000001Dqf-0djl;
	Thu, 13 Aug 2026 17:04:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYqb-00000001Dq5-16ok
	for linux-um@bombadil.infradead.org;
	Thu, 13 Aug 2026 17:04:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=o+r4ruNkApE26fuyn6KtkFW0QuXubfwA1Uwqu5ezEYw=; b=iHgnmYdZmCoZTJmyP22dA+pl9z
	kO6eBPkvYDA9Sc/n5qFWbFUaTNW0SOtBr+2mYOMHpWbWhTsk32az9JS8Yb2XGRQJdLrldo5G1iQo0
	PsfLS1wm7sF8lu8En+KP/9msU+yj7rprXySPqTr3ptWnhxp0qMIL8mFuuIUgWwhXfLCAR1p9yqJGm
	K50NSM/z6ig3TDJiwVaOtQS6Rq3fwkAm9c+x8cqFOiy6mdC4AGjMgleIrd3CKqAo2Q+yl/zAu2TPO
	Ij8F+yZkzgGoBCuv0Ntrsk/11215fjHhHgB+AGJw9u2hgBWx4JBWXDXpzjKGUkMLys4pt2Lfhl80J
	TGFf/DFQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wuYqY-0000000GMNl-1VU3
	for linux-um@lists.infradead.org;
	Thu, 13 Aug 2026 17:04:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o+r4ruNkApE26fuyn6KtkFW0QuXubfwA1Uwqu5ezEYw=;
	b=AUiGMuMkTsqDPDXC1KY/NpKJEwrcNdBxMi8lNHUgWaIVk1LObxEcQJcAEYUUd4QYQUwW6d
	AB+7EVbKb0dIzQMuTxtWsCDRGqyW1rU3jkvhi1rJ+vH/x8P6T9+oQbDvByvpjFPVsFjw/H
	PwsH/SIT8YqV4CUGOhzAT95SmLOue60=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o+r4ruNkApE26fuyn6KtkFW0QuXubfwA1Uwqu5ezEYw=;
	b=ARYHGwsjw6PMZq+RpT57Fij5JKucAJQylJ3bqeCCPBIcJJUMiwexQtf/QcbPKP0pRm5byF
	4kca2ESVN+vCdgxZrrDdbMRVxtUmJ0OIvQuM/Pp+oLdAub4KGVohw56OEeWSKXv7CBxZqg
	e9L2UadaWNZfTELH6fblt4vJx3l+lKM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-3v5IuKYOPO-SU8jOK2nwmw-1; Thu,
 13 Aug 2026 13:03:46 -0400
X-MC-Unique: 3v5IuKYOPO-SU8jOK2nwmw-1
X-Mimecast-MFC-AGG-ID: 3v5IuKYOPO-SU8jOK2nwmw_1786640620
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63C311800650;
	Thu, 13 Aug 2026 17:03:36 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F76A195608A;
	Thu, 13 Aug 2026 17:03:19 +0000 (UTC)
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
Subject: [PATCH 00/13] audit: log all six syscall arguments in the SYSCALL record
Date: Thu, 13 Aug 2026 14:02:50 -0300
Message-ID: <cover.1786626275.git.rrobaina@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: fw3k9z7r5xmzQ8KbK1XsGXR6VmmoB4RFReXMXjdzFoc_1786640620
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_180402_589792_9439642D 
X-CRM114-Status: UNSURE (   6.76  )
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

The SYSCALL record currently logs only four of the six syscall
arguments (a0-a3), silently discarding the remaining two. This
leads to the need for auxiliary records when audit-relevant
data lands in the 5th or 6th argument of a syscall.

This series extends the SYSCALL record to log all six arguments,
by adding arguments a4 and a5 inline within the existing record.

The audit testsuite runs successfully:

 # make test
 make -C tests test
 chmod +x */test
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

Ricardo Robaina (13):
  audit: log all six syscall arguments in the SYSCALL record
  alpha: pass all six syscall args to audit_syscall_entry()
  arm: pass all six syscall args to audit_syscall_entry()
  arm64: pass all six syscall args to audit_syscall_entry()
  csky: pass all six syscall args to audit_syscall_entry()
  microblaze: pass all six syscall args to audit_syscall_entry()
  mips: pass all six syscall args to audit_syscall_entry()
  openrisc: pass all six syscall args to audit_syscall_entry()
  parisc: pass all six syscall args to audit_syscall_entry()
  sh: pass all six syscall args to audit_syscall_entry()
  sparc64: pass all six syscall args to audit_syscall_entry()
  um: pass all six syscall args to audit_syscall_entry()
  xtensa: pass all six syscall args to audit_syscall_entry()

 arch/alpha/kernel/ptrace.c      |  3 ++-
 arch/arm/kernel/ptrace.c        |  2 +-
 arch/arm64/kernel/ptrace.c      |  3 ++-
 arch/csky/kernel/ptrace.c       |  3 ++-
 arch/microblaze/kernel/ptrace.c |  3 ++-
 arch/mips/kernel/ptrace.c       | 11 ++++++++---
 arch/openrisc/kernel/ptrace.c   |  3 ++-
 arch/parisc/kernel/ptrace.c     |  7 +++++--
 arch/sh/kernel/ptrace_32.c      |  3 ++-
 arch/sparc/kernel/ptrace_64.c   |  3 ++-
 arch/um/kernel/ptrace.c         |  4 +++-
 arch/xtensa/kernel/ptrace.c     |  3 ++-
 include/linux/audit.h           | 11 +++++++----
 include/linux/entry-common.h    |  3 ++-
 include/uapi/linux/audit.h      |  2 ++
 kernel/audit.h                  |  2 +-
 kernel/auditfilter.c            |  2 ++
 kernel/auditsc.c                | 31 ++++++++++++++++++++-----------
 18 files changed, 67 insertions(+), 32 deletions(-)

-- 
2.55.0


