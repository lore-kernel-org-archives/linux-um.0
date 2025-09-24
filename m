Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67585CAC5AE
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 14:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yTv1BdIbryTeAGyOFxkWnnUwAIwyWmkYx+MS7rF1kYc=; b=n2yt9c5YB2tdPt6j2NY7RQlRDO
	sEDeiqXwue9XKAQjEG6lkHdDqKRXkvj3bldF2Wep7JAuTmieWwn5ISsIvSMoKFEPVwPu4juRKoLCv
	cNGtF7LMsJonj6V4ZbhSgwIDaMFF+KE3lCYDRTPpLLgBgcpLeSq+SqZ8zMiPugKIwSZy+M+AbLXbJ
	T/Cc/H4YA4rK2BO/aijbsPJZeoFjlwy9XKDH9elonInlBdS1ZvMYtpdh/AM/7Y9ToBhnNfRp7Oijd
	84hETX6lPZBqyf2AiSRNFQolj3JPGMmlc7MQhgww3OSWBlcSQK/XUBbdXrjN6g5BbyjtgzgCzrutr
	39yOnsug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNW-00000000ajy-37AF;
	Wed, 24 Sep 2025 14:21:54 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNU-00000000ag8-0KO3
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 14:21:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=yTv1BdIbryTeAGyOFxkWnnUwAIwyWmkYx+MS7rF1kYc=; t=1758723711; x=1759933311; 
	b=Ik6lAAE9aPvGgjW8SPaS2i4jrnY19wHAx79QOFpCXaVCdtnZcxnQ9ZwKJjY32uCTHPglqN+Jmje
	/cjmHd1LQSAj4nihGaY/SPiP/DZxIeEnvCjvrURtsx3gbp7v7ZxJZGY0wo73gXhXIMrNGS0BLXrbP
	R1YDux8fnI9Xp7o+tF+tnRfeW9JpUsR14NUjWflEDLHC7K+bjwrR0F7ir6gjIn0Zi0LOif/lt1EuP
	m0WrnJNd3puZyUFa1lWuxfV+ylHNevi+YFEvd3jTTEA9vrcSWW+3IjYHKeTLLco2C546GiswlrnpU
	5kiFvl4FFCHAvlS2VjYT9Cjk8SwpxdV6l4Hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNP-000000090Bz-2xkC;
	Wed, 24 Sep 2025 16:21:47 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 00/12] Start porting UML to nolibc
Date: Wed, 24 Sep 2025 16:20:47 +0200
Message-ID: <20250924142059.527768-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_072152_122663_2823C76B 
X-CRM114-Status: GOOD (  16.35  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

This patchset is an attempt to start a nolibc port of UML. The goal is
to port UML to use nolibc in smaller chunks to make the switch more
manageable.

Using nolibc has the advantage that it is a smaller runtime and it
allows us to be in full control about all memory mappings that are done.
Another libc on the other hand might map memory unaware of UML, causing
collisions with the UML memory layout. Such mappings could even happen
before UML has fully initialized (e.g. rseq being mapped into the
physical or vmalloc memory areas).

There are three parts to this patchset:
 * Two patches to use tools/include headers instead of kernel headers
   for userspace files.
 * A few nolibc fixes and a new NOLIBC_NO_RUNTIME compile flag for it
 * Finally nolibc build support for UML and switching two files while
   adding the appropriate support in nolibc itself.

v1 of this patchset was
  https://lore.kernel.org/all/20250915071115.1429196-1-benjamin@sipsolutions.net

v2:
  https://lore.kernel.org/all/20250919153420.727385-1-benjamin@sipsolutions.net

Changes in v3:
- sys_ptrace is now not a varadic function
- improve printf %m implementation
- keep perror as function available with NOLIBC_IGNORE_ERRNO
- change syscall guard and fix i386 build

Changes in v2:
- add sys/uio.h and sys/ptrace.h to nolibc
- Use NOLIBC_NO_RUNTIME to disable nolibc startup code
- Fix out-of-tree build
- various small improvements and cleanups

Benjamin

Benjamin Berg (12):
  tools compiler.h: fix __used definition
  um: use tools/include for user files
  tools/nolibc/stdio: let perror work when NOLIBC_IGNORE_ERRNO is set
  tools/nolibc/dirent: avoid errno in readdir_r
  tools/nolibc: implement %m if errno is not defined
  tools/nolibc: use __fallthrough__ rather than fallthrough
  tools/nolibc: add option to disable runtime
  um: add infrastructure to build files using nolibc
  um: use nolibc for the --showconfig implementation
  tools/nolibc: add uio.h with readv and writev
  tools/nolibc: add ptrace support
  um: switch ptrace FP register access to nolibc

 arch/um/Makefile                             | 38 ++++++++++++---
 arch/um/include/shared/init.h                |  2 +-
 arch/um/include/shared/os.h                  |  2 +
 arch/um/include/shared/user.h                |  6 ---
 arch/um/kernel/Makefile                      |  2 +-
 arch/um/kernel/skas/stub.c                   |  1 +
 arch/um/kernel/skas/stub_exe.c               |  4 +-
 arch/um/os-Linux/skas/process.c              |  6 +--
 arch/um/os-Linux/start_up.c                  |  4 +-
 arch/um/scripts/Makefile.rules               | 10 +++-
 arch/x86/um/Makefile                         |  6 ++-
 arch/x86/um/os-Linux/Makefile                |  5 +-
 arch/x86/um/os-Linux/registers.c             | 20 ++------
 arch/x86/um/user-offsets.c                   |  1 -
 tools/include/linux/compiler.h               |  2 +-
 tools/include/nolibc/Makefile                |  2 +
 tools/include/nolibc/arch-arm.h              |  2 +
 tools/include/nolibc/arch-arm64.h            |  2 +
 tools/include/nolibc/arch-loongarch.h        |  2 +
 tools/include/nolibc/arch-m68k.h             |  2 +
 tools/include/nolibc/arch-mips.h             |  2 +
 tools/include/nolibc/arch-powerpc.h          |  2 +
 tools/include/nolibc/arch-riscv.h            |  2 +
 tools/include/nolibc/arch-s390.h             |  2 +
 tools/include/nolibc/arch-sh.h               |  2 +
 tools/include/nolibc/arch-sparc.h            |  2 +
 tools/include/nolibc/arch-x86.h              |  4 ++
 tools/include/nolibc/compiler.h              |  4 +-
 tools/include/nolibc/crt.h                   |  3 ++
 tools/include/nolibc/dirent.h                |  6 +--
 tools/include/nolibc/nolibc.h                |  2 +
 tools/include/nolibc/stackprotector.h        |  2 +
 tools/include/nolibc/stdio.h                 | 10 +++-
 tools/include/nolibc/stdlib.h                |  2 +
 tools/include/nolibc/sys.h                   |  3 +-
 tools/include/nolibc/sys/auxv.h              |  3 ++
 tools/include/nolibc/sys/ptrace.h            | 44 ++++++++++++++++++
 tools/include/nolibc/sys/uio.h               | 49 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 11 +++++
 39 files changed, 221 insertions(+), 53 deletions(-)
 create mode 100644 tools/include/nolibc/sys/ptrace.h
 create mode 100644 tools/include/nolibc/sys/uio.h

-- 
2.51.0


