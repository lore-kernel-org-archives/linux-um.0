Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B158EC3ABB6
	for <linux-um@archiver.kernel.org>; Fri,  2 May 2025 22:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ONTWqXPK16P/0zEJ7tS2nkTgsRlCDOKxvUHOtWHZvaE=; b=jXzX4o/sqHUkcSpLh3R/tlVqJj
	jr6dR9+vdsauboLcaBMgEiyhK3hkhlP+H2gHtLWPbpb1NmXHd4Lwbwo99CHqm4sPyQ9t0gF2hmXaT
	o+ukMfGjcXcB9b5gpfxdWDlmYGO7hvTfOWeUB9rHeVdE9+vYvQ0N06muh1Itbut6IJdAgquIRWr7Y
	f5eOcDMph40QTJX+boRtchkEcdavbXliCQdzQ89XQSl1ystZmrtDZbO8crEcmQ18y+p1UUlmI391I
	Jkm+LW9uW4rLrlcgVaJAIq3AXXWdHus6QgPDB+gwWxg7M4AFEdKD00eXz8VLr2rb4BYg1ig57jZUE
	m2IXYZvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAzGx-00000003C8v-2aE9;
	Fri, 02 May 2025 22:54:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAzGv-00000003C7K-01Ku
	for linux-um@lists.infradead.org;
	Fri, 02 May 2025 22:54:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0C1495C5C85;
	Fri,  2 May 2025 22:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C407DC4AF0B;
	Fri,  2 May 2025 22:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746226459;
	bh=WdmZa5l99Vhwe/hFJDeUIG6hQ5O76/7JBHbFIhtajXs=;
	h=From:To:Cc:Subject:Date:From;
	b=mosauOqkxwLCmrF6kKUM0Ys45QpPFJotZsAsfrJWceDUgkC5uIJ/Rxh6TUpH8Emrq
	 7H0gfHbVxPbigbxSx08rlCCOSJFIomzKDzsINhG1PzkXhVwh+0mDXfiZAN79x2ih2I
	 WHnfFIMnVaoE81Ivdex81HcLXf5mRDyvuVvC3chp7Bst2V4beOikMiJsy7IuDiPu7F
	 wZOQ877oEHqjOAwM0MrKFcL5exqAhEvl6ZCB3XOkTK/x8snrF4WtHYuDUnQgpY4D4G
	 QAppMMclUn/+cWRO0+OyXP/XjNfalLChyp7pPSrOYYqE5QsCXyxoHYxp5c9IGfP+7L
	 E9Mewxx5aoTsg==
From: Kees Cook <kees@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Justin Stitt <justinstitt@google.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-um@lists.infradead.org
Subject: [PATCH v2 0/3] Detect changed compiler dependencies for full rebuild
Date: Fri,  2 May 2025 15:54:12 -0700
Message-Id: <20250502224512.it.706-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2704; i=kees@kernel.org; h=from:subject:message-id; bh=WdmZa5l99Vhwe/hFJDeUIG6hQ5O76/7JBHbFIhtajXs=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmivmLBof3JZfffi9rwZtw7k6/bbaezi+3JSpdr0XPDs s7wqC3uKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmEi1HiND56y7zgsOn5/caBvL LfxQ6GifRFBVWdwigd+l/Ac1fQtuMvx34tjpIpfatU6iObfAvlz2Uh5X7+Vuc869+hoTXMp+JLI DAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_155421_155219_5252BA75 
X-CRM114-Status: GOOD (  15.49  )
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

 v2:
  - switch from -include to -I with a -D gated include compiler-version.h
 v1: https://lore.kernel.org/lkml/20250501193839.work.525-kees@kernel.org/

Hi,

This is my attempt to introduce dependencies that track the various
compiler behaviors that may globally change the build that aren't
represented by either compiler flags nor the compiler version
(CC_VERSION_TEXT). Namely, this is to detect when the contents of a
file the compiler uses changes. We have 3 such situations currently in
the tree:

- If any of the GCC plugins change, we need to rebuild everything that
  was built with them, as they may have changed their behavior and those
  behaviors may need to be synchronized across all translation units.
  (The most obvious of these is the randstruct GCC plugin, but is true
  for most of them.)

- If the randstruct seed itself changes (whether for GCC plugins or
  Clang), the entire tree needs to be rebuilt since the randomization of
  structures may change between compilation units if not.

- If the integer-wrap-ignore.scl file for Clang's integer wrapping
  sanitizer changes, a full rebuild is needed as the coverage for wrapping
  types may have changed, once again cause behavior differences between
  compilation units.

The best way I found to deal with this is to:
- Generate a .h file that is updated when the specific dependencies change.
  e.g.: randstruct_hash.h depends on randstruct.seed

- Add a -I argument globally to be able to locate the .h file.
  e.g.: -I$(objtree)/scripts/basic

- Add a conditional -D argument for each separate case
  e.g.: RANDSTRUCT_CFLAGS += -DRANDSTRUCT

- Include the .h file from compiler-version.h through an #ifdef for the define
  e.g.:
  #ifdef RANDSTUCT
  #include "randstruct_hash.h"
  #endif

This means that all targets gain the dependency (via fixdep), but only
when the defines are active, which means they are trivially controlled
by the existing CFLAGS removal mechanisms that are already being used
to turn off each of the above features.

-Kees

Kees Cook (3):
  gcc-plugins: Force full rebuild when plugins change
  randstruct: Force full rebuild when seed changes
  integer-wrap: Force full rebuild when .scl file changes

 Makefile                         |  1 +
 arch/um/Makefile                 |  2 ++
 include/linux/compiler-version.h | 10 ++++++++++
 include/linux/vermagic.h         |  1 -
 scripts/Makefile.gcc-plugins     |  2 +-
 scripts/Makefile.ubsan           |  1 +
 scripts/basic/Makefile           | 20 +++++++++++++++-----
 scripts/gcc-plugins/Makefile     |  8 ++++++++
 8 files changed, 38 insertions(+), 7 deletions(-)

-- 
2.34.1


