Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289CCCA101F
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 07:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x19kbUYL2Cg9MV223qYaCq31NCabilripCrs7bHYZWA=; b=VbLL28WIDaeIRbelYZ1p310r/P
	QhMNGwYAcobugxs3zUuWeGWnZ34a3/YKG6hi2bN1Pt8EvGttlbPPAIDTxlfPWdNDUr8w0C2Ekicr8
	scZFQFSKf2ifB0gG3QiZRVZIhZosTasdfqjlVmua6Jb6BXNs19LqbKJ2/vZdNxOzlRT5bjBsHfDRM
	u7YYSZVrYTTM+Dr5FGcGtuNIZGqC9epckN97r7DFbPmM2KAqOK7y01vE9YnqmYxEeL+c8wByFL94u
	acbNXbsoQEyIODIgehvGL2fSFnR0qPais9Ay/4xls5w/c7CS8N51Wxx9NPfKqaZUCSwxTMSU0zrU+
	E5BHqf4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XL-000000031jW-3Zvx;
	Mon, 15 Sep 2025 07:22:07 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XI-000000031hY-3png
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 07:22:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=x19kbUYL2Cg9MV223qYaCq31NCabilripCrs7bHYZWA=; t=1757920924; x=1759130524; 
	b=aFWdyqAkF8rSnhzMNpYiNQ8vjDhG6jD8MoBO5t7YtgcPtTCGuw5ZrJVzW9/yWxgMjtUU5ENWRqs
	U5QCjt2DT8dY1691tWgsf7wMAEhS3A+XpuRIKjumKb3cRApsOSLldptTuoKwSkllSPdtkmOe/IB3B
	k4F8U5OuRsEt1N6USLuZvBfqq3O74bgg2z/xVM0Yx/dW8z7hBmAHG+7jV+yS2XXY8zU5tfqCWhqbX
	dGE/5vsdeYTRimx9aQ1+tYCT2tC32Jo0+WvLw4rSEn4Oiy77yrF11mMt8aadeEHYyiAvh9u/CW7Mm
	X6ebzQNmRHzZ7NWYisesOYmBelAbKi30ln9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XC-00000005w6o-3hKR;
	Mon, 15 Sep 2025 09:21:59 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 0/9] Start porting UML to nolibc
Date: Mon, 15 Sep 2025 09:11:06 +0200
Message-ID: <20250915071115.1429196-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_002204_952155_BCA74EC3 
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

From: Benjamin Berg <benjamin.berg@intel.com>

For a while now, we have discussed that it may be better to avoid using
libc inside UML as it may be interfering in unexpected ways with kernel
functionality. A major point of concern is that there is no guarantee
that the libc is not using any address space that may conflict with
kernel addresses.

This patchset is an attempt to start a nolibc port of UML. The goal is
to port UML to use nolibc in smaller chunks to make the switch more
manageable.

There are three parts to this patchset:
 * Two patches to use tools/include headers instead of kernel headers
   for userspace files.
 * A few nolibc fixes and a new NOLIBC_NO_STARTCODE compile flag for it
 * Finally nolibc build support for UML and switching two files

The first two parts could be merged independently. The last step to use
nolibc inside UML obviously depends on the first two.

Benjamin

Benjamin Berg (9):
  tools compiler.h: fix __used definition
  um: use tools/include for user files
  tools/nolibc/stdio: remove perror if NOLIBC_IGNORE_ERRNO is set
  tools/nolibc/dirent: avoid errno in readdir_r
  tools/nolibc: use __fallthrough__ rather than fallthrough
  tools/nolibc: add option to disable startup code
  um: add infrastructure to build files using nolibc
  um: use nolibc for the --showconfig implementation
  um: switch ptrace FP register access to nolibc

 arch/um/Makefile                              | 32 ++++++++++++++++---
 .../um/include/shared/generated/asm-offsets.h |  1 +
 .../include/shared/generated/user_constants.h |  1 +
 arch/um/include/shared/init.h                 |  2 +-
 arch/um/include/shared/os.h                   |  2 ++
 arch/um/include/shared/user.h                 |  5 ---
 arch/um/kernel/Makefile                       |  2 +-
 arch/um/kernel/skas/stub.c                    |  1 +
 arch/um/kernel/skas/stub_exe.c                |  4 +--
 arch/um/os-Linux/skas/process.c               |  6 ++--
 arch/um/os-Linux/start_up.c                   |  4 +--
 arch/um/scripts/Makefile.rules                | 10 ++++--
 arch/x86/um/Makefile                          |  6 ++--
 arch/x86/um/os-Linux/Makefile                 |  5 ++-
 arch/x86/um/os-Linux/registers.c              | 22 +++++--------
 arch/x86/um/user-offsets.c                    |  1 -
 tools/include/linux/compiler.h                |  2 +-
 tools/include/nolibc/arch-arm.h               |  2 ++
 tools/include/nolibc/arch-arm64.h             |  2 ++
 tools/include/nolibc/arch-loongarch.h         |  2 ++
 tools/include/nolibc/arch-m68k.h              |  2 ++
 tools/include/nolibc/arch-mips.h              |  2 ++
 tools/include/nolibc/arch-powerpc.h           |  2 ++
 tools/include/nolibc/arch-riscv.h             |  2 ++
 tools/include/nolibc/arch-s390.h              |  2 ++
 tools/include/nolibc/arch-sh.h                |  2 ++
 tools/include/nolibc/arch-sparc.h             |  2 ++
 tools/include/nolibc/arch-x86.h               |  4 +++
 tools/include/nolibc/compiler.h               |  4 +--
 tools/include/nolibc/crt.h                    |  3 ++
 tools/include/nolibc/dirent.h                 |  6 ++--
 tools/include/nolibc/stackprotector.h         |  2 ++
 tools/include/nolibc/stdio.h                  |  2 ++
 tools/include/nolibc/stdlib.h                 |  2 ++
 tools/include/nolibc/sys.h                    |  3 +-
 tools/include/nolibc/sys/auxv.h               |  3 ++
 36 files changed, 108 insertions(+), 47 deletions(-)
 create mode 120000 arch/um/include/shared/generated/asm-offsets.h
 create mode 120000 arch/um/include/shared/generated/user_constants.h

-- 
2.51.0


