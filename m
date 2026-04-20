Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3D1F588C2
	for <linux-um@archiver.kernel.org>; Mon, 20 Apr 2026 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LFE7ltbdDd1Q3SkkFAvEOfm9y7HJx4yDPS6nrqtLz5s=; b=e5tNW6iM0LW1xg/HOV6cL6sndu
	bFtpANC87UvMu42Al8pP8YabZ5Fjkyp78HBclEqMpHdzCVvyFxrrkabbJ/TPP+d88EnMnIUlJlJpE
	cJIvJaqFrU+OtLn02VXpbBl2Kx7p5FALZoy+zrjsOm0Ldk47RwUo6ZMoSK40Bo9yINq1LWNCsy0VH
	2D5JHA9HxR9EfHhoccB5dYDfgBdeSGMSAHZKVugy6oS95h593OuShXpKI8QhzDh11zCOVYwvnNcKn
	s1IenLZygwOw3onmTvGe4e7ckS4b89ziH9Y4gBTJmu/hvcA3ZRKB0E8ODwJj6HjL7zDd1MmTr5pgX
	hOckOZWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEog4-000000071VH-2lRj;
	Mon, 20 Apr 2026 13:28:40 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEog0-000000071SB-3wLP
	for linux-um@lists.infradead.org;
	Mon, 20 Apr 2026 13:28:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=LFE7ltbdDd1Q3SkkFAvEOfm9y7HJx4yDPS6nrqtLz5s=; t=1776691716; x=1777901316; 
	b=wXhRGHCZYIsbvtbjfSwT7Y6vAtWyMT2LBH5RDseLvn+jUOehSUOOV5liYMjRoWkBOsDiJwAu2Pw
	fuVsk0POCfnuBqiKzJNmmoO52M0fL+euQUmxhGOJ7ZtUwxzE2XFA0r2oBvOjnQC+JhBowpTBvkU/O
	kuQ2+G/tDv4I8U/NDX7/T9ZSksAtA+ydrtXvaWea2EXlB/EJaJgeWx/xMEoZA/5HN7fupgpUCSaVG
	GsJEXh2ELqjjGmZrT9uqYgvOWSU+roURNGpPJ8TcQh5GHWG3POTRphbq7wHVcBWjMeurWERIIEHwk
	0wXHIXdBeW0p1iDk4xgvRzzBNGxnFc3VYQxw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wEofr-00000002g99-0ohD;
	Mon, 20 Apr 2026 15:28:27 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml-for-7.1-rc1
Date: Mon, 20 Apr 2026 15:26:12 +0200
Message-ID: <20260420132821.364484-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_062837_023279_E7C3A992 
X-CRM114-Status: GOOD (  10.06  )
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

Hi Linus,

UML doesn't have a lot of content right now. However, I should
note that Michael Bommarito, who shows up here with a build fix,
has been doing a sort of (LLM-assisted) security audit, so we'll
likely be back after -rc1 with fixes.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-7.1-rc1

for you to fetch changes up to 6522fe5c1b007c376fc5f2de1016c99a18b0af8e:

  um: Disable GCOV_PROFILE_ALL on 32-bit UML with Clang 20/21 (2026-04-10 09:28:59 +0200)

----------------------------------------------------------------
Mostly cleanups and small things, notably:
 - musl libc compatibility
 - vDSO installation fix
 - TLB sync race fix for recent SMP support
 - build fix for 32-bit with Clang 20/21

----------------------------------------------------------------
Kees Cook (2):
      um: Replace strncpy() with strnlen()+memcpy_and_pad() in strncpy_chunk_from_user()
      um: Disable GCOV_PROFILE_ALL on 32-bit UML with Clang 20/21

Marcel W. Wysocki (2):
      um: fix address-of CMSG_DATA() rvalue in stub
      um: avoid struct sigcontext redefinition with musl

Michael Bommarito (1):
      um: drivers: call kernel_strrchr() explicitly in cow_user.c

Randy Dunlap (1):
      um: time-travel: clean up kernel-doc warnings

Thomas Weißschuh (1):
      x86/um: fix vDSO installation

Tiwei Bie (3):
      um: Fix potential race condition in TLB sync
      um: Fix pte_read() and pte_exec() for kernel mappings
      um: Remove CONFIG_FRAME_WARN from x86_64_defconfig

 arch/um/Kconfig                    | 4 +++-
 arch/um/configs/x86_64_defconfig   | 1 -
 arch/um/drivers/cow_user.c         | 8 +++++++-
 arch/um/include/asm/pgtable.h      | 9 ++++-----
 arch/um/kernel/skas/stub.c         | 2 +-
 arch/um/kernel/skas/uaccess.c      | 4 ++--
 arch/um/kernel/tlb.c               | 4 ++--
 arch/x86/Makefile.um               | 2 ++
 arch/x86/um/os-Linux/mcontext.c    | 6 ++++++
 arch/x86/um/vdso/Makefile          | 2 --
 include/uapi/linux/um_timetravel.h | 6 +++++-
 mm/Kconfig                         | 1 +
 12 files changed, 33 insertions(+), 16 deletions(-)

