Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B4BCAC592
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2kkh21e/IwlRCoBO9MaQ5jF2MRbtUk5+kD17PYi26nM=; b=KAUEgVtCPMEO++9gtJrVjtepAK
	T0J1YKtRYSetOGhEpm04Ki6q7ivz4GooUT2NDFgJsKHA07M9dNDzEOZHpxZTsfaCWqI5/HhLL73Rr
	z2N9QYnG75o+UX5fzTkqXNd7ST/5FTAAruy+l5rNdCCHcxBysiWC8KS8aTdiQQ88RQlub2UGp6nYt
	UNdLqCxBl/m1/2tOrwCE2rJeykDNDysTjz1rImzLTst6Y0/QdrjEldwa0RMC1w/7FB7g+3Bfzn8Ou
	1ahz25eV5oGjFVbFjiewTMbyUpysq8mwZ6Bfq7RST8//MBxhasd29oGcf+qZgCAJ8HxlqNqymF9MJ
	rweH7qXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9d-00000003ME5-3dgN;
	Fri, 19 Sep 2025 15:36:09 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9Z-00000003MAZ-1GSY
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 15:36:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=2kkh21e/IwlRCoBO9MaQ5jF2MRbtUk5+kD17PYi26nM=; t=1758296165; x=1759505765; 
	b=icRMPzI0kQIXt2kc8Qz2xm4IevFKA7HmB4lEStpqe3txw9zg+ctwSptgYukVtdEmmyRIbm1ot2/
	Ga5IUaqtxRvZY8eOSea0wwGCFLZ73FMfhJf0pF9HH/tVszoLCrwOtAs/FM19A//ai3liHX/hv+l60
	39DTV4Jyr4uAY6nFdNfoN9ieVNbWXeOTAjFzQ5KET+Ax4TfpAmy8HYeEjTLN3Zwxj7evb8a4+XD7D
	8vWFtlhgC0qeyi0MajI+mrXLbSja2+yg4WofGzw0281WNxxXcIXvL2lh5hwDM8bey24kXPQ6RNPcU
	tbFd+fLadpEsjJ+dpt4Eip5OusE8SVVyIEgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9S-0000000G6O6-33lI;
	Fri, 19 Sep 2025 17:35:58 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 00/11] Start porting UML to nolibc
Date: Fri, 19 Sep 2025 17:34:09 +0200
Message-ID: <20250919153420.727385-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_083605_365439_ABCD144F 
X-CRM114-Status: GOOD (  16.92  )
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

There are three parts to this patchset:
 * Two patches to use tools/include headers instead of kernel headers
   for userspace files.
 * A few nolibc fixes and a new NOLIBC_NO_STARTCODE compile flag for it
 * Finally nolibc build support for UML and switching two files while
   adding the appropriate support in nolibc itself.

v1 of this patchset was
  https://lore.kernel.org/all/20250915071115.1429196-1-benjamin@sipsolutions.net/

Changes in v2:
- add sys/uio.h and sys/ptrace.h to nolibc
- Use NOLIBC_NO_RUNTIME to disable nolibc startup code
- Fix out-of-tree build
- various small improvements and cleanups

Should the nolibc changes be merged separately or could everything go
through the same branch?

Also, what about tools/include/linux/compiler.h? It seems that was added
for the tracing code, but it is not clear to me who might ACK that fix.

Benjamin

Benjamin Berg (11):
  tools compiler.h: fix __used definition
  um: use tools/include for user files
  tools/nolibc/stdio: remove perror if NOLIBC_IGNORE_ERRNO is set
  tools/nolibc/dirent: avoid errno in readdir_r
  tools/nolibc: use __fallthrough__ rather than fallthrough
  tools/nolibc: add option to disable runtime
  um: add infrastructure to build files using nolibc
  um: use nolibc for the --showconfig implementation
  tools/nolibc: add uio.h with readv and writev
  tools/nolibc: add ptrace support
  um: switch ptrace FP register access to nolibc

 arch/um/Makefile                             | 38 +++++++++++---
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
 arch/x86/um/os-Linux/registers.c             | 16 ++----
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
 tools/include/nolibc/stdio.h                 |  2 +
 tools/include/nolibc/stdlib.h                |  2 +
 tools/include/nolibc/sys.h                   |  3 +-
 tools/include/nolibc/sys/auxv.h              |  3 ++
 tools/include/nolibc/sys/ptrace.h            | 52 ++++++++++++++++++++
 tools/include/nolibc/sys/uio.h               | 49 ++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 11 +++++
 39 files changed, 222 insertions(+), 48 deletions(-)
 create mode 100644 tools/include/nolibc/sys/ptrace.h
 create mode 100644 tools/include/nolibc/sys/uio.h

-- 
2.51.0


