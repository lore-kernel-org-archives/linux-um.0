Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F86FF885C
	for <linux-um@archiver.kernel.org>; Sun, 26 Apr 2026 00:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FaiLW/pVXClx0hGhS3rNh2hU+gA/RQ/q+swTpIKpuX4=; b=qwbj+2yo+qh+7jKnuUmrp7dw0j
	CT73sG9zMfE1x1Id4WKkXhkx4MBIochxDZ1FTB9laPL/aZnYAs4w+L067l8JkHndGecUUKo+YUIuz
	gg74jqxYREDbJWDXK9Tj8pRvT74Q1BlFGk86POIPhuHWUv5V80/Mm+txEewHB57LzZMR9VZE4aQDd
	JmyDKyiCQyKQ+B6GJjzNJKiWrzpYMIlBTIKn+aAmns4DO2WoHbrQ8Z6NU4RtB67Zlw2tjw603rpJU
	9zMYPu+W9+Y6Wug6NSLah8nj+eXcaIjQxPmvhXwh/MxiYUXbUB3EEVblWUXcJrSbG/NhNYd1JDkXI
	450FRKwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGmyN-0000000F5vx-2fDd;
	Sun, 26 Apr 2026 00:03:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGmyL-0000000F5vb-33Kb
	for linux-um@lists.infradead.org;
	Sun, 26 Apr 2026 00:03:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6026744056;
	Sun, 26 Apr 2026 00:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F96CC2BCB0;
	Sun, 26 Apr 2026 00:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777161821;
	bh=l0kIGOnwEOk/z/NCHNJe/hFxFNb+wlfcj7Roc12943g=;
	h=From:To:Cc:Subject:Date:From;
	b=QZfBuGEwfNmc903opHbEC2LM1hIjcYDq/xfEddYzpJK9w0JLj84Y1tK6RmZUMzMq+
	 hhcEU0eDJ581PMmJTWzs69zze7rrClxHxmETLJ6OwFVAzxzA8p4DwZCM6DUUtB3HRf
	 c/yXvFhh1KMSZrmAoZfljdvj4tIiOjwL08DhAB2qdS4t2jnxwLh3uVXvKtABMD0Ast
	 u2PoDEb4fkH/QPi4cSxHTPqtj18Ke/Alnjg+Ul0pF11pZkv2wz65jdUyOHed3Wh5m0
	 7hAUzotbSfTQObc+TYJgHt9MMnk/3PVvkZq9S5IZVtkRd4rC3d8lxszGHLyQFLc9Of
	 tw9GkrTcY2nTQ==
From: Sasha Levin <sashal@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: Consolidate MAGIC_SYSRQ into generic Kconfig definition
Date: Sat, 25 Apr 2026 20:03:39 -0400
Message-ID: <20260426000339.57049-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260425_170341_831333_F00979E5 
X-CRM114-Status: GOOD (  16.04  )
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

kconfiglint reports:

  K008: config MAGIC_SYSRQ has prompts in 2 separate definitions

MAGIC_SYSRQ is defined in two places with complementary conditions:

  arch/um/Kconfig:213 — depends on MCONSOLE (UML only)
  lib/Kconfig.debug:665 — depends on !UML (everything except UML)

The UML definition has existed since the initial git import in
commit 1da177e4c3f4 ("Linux-2.6.12-rc2"). UML needs MAGIC_SYSRQ to work
through its mconsole interface rather than through keyboard input, so the
UML version depends on MCONSOLE while the generic version excludes UML
entirely with `depends on !UML`.

These two definitions are logically complementary: on UML, MAGIC_SYSRQ
requires MCONSOLE; on everything else, it has no special dependencies.
This can be expressed as a single definition with
`depends on !UML || MCONSOLE`, which evaluates to:
  - On UML: requires MCONSOLE (same as before)
  - On non-UML: always satisfiable (same as before)

Consolidate into the generic definition in lib/Kconfig.debug by changing
the dependency to `depends on !UML || MCONSOLE` and merging the UML-
specific help text that explains the mconsole-based sysrq interface.
Remove the now-redundant definition from arch/um/Kconfig.

This follows the same unification pattern used by commit 7bd291abe2da
("sched: Unify the SCHED_{SMT,CLUSTER,MC} Kconfig") and our earlier
SCHED_MC consolidation for SH.

No functional change — the resulting Kconfig behavior is identical.

Assisted-by: Claude:claude-opus-4-6 kconfiglint
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/Kconfig   | 19 -------------------
 lib/Kconfig.debug | 10 ++++++----
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index d9541d13d9eb0..5af245ede463f 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -210,25 +210,6 @@ config MCONSOLE
 
 	  It is safe to say 'Y' here.
 
-config MAGIC_SYSRQ
-	bool "Magic SysRq key"
-	depends on MCONSOLE
-	help
-	  If you say Y here, you will have some control over the system even
-	  if the system crashes for example during kernel debugging (e.g., you
-	  will be able to flush the buffer cache to disk, reboot the system
-	  immediately or dump some status information). A key for each of the
-	  possible requests is provided.
-
-	  This is the feature normally accomplished by pressing a key
-	  while holding SysRq (Alt+PrintScreen).
-
-	  On UML, this is accomplished by sending a "sysrq" command with
-	  mconsole, followed by the letter for the requested command.
-
-	  The keys are documented in <file:Documentation/admin-guide/sysrq.rst>. Don't say Y
-	  unless you really know what this hack does.
-
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
 	default 2 if 64BIT
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8ff5adcfe1e0a..695e118f910fb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -664,7 +664,7 @@ menu "Generic Kernel Debugging Instruments"
 
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
-	depends on !UML
+	depends on !UML || MCONSOLE
 	help
 	  If you say Y here, you will have some control over the system even
 	  if the system crashes for example during kernel debugging (e.g., you
@@ -672,9 +672,11 @@ config MAGIC_SYSRQ
 	  immediately or dump some status information). This is accomplished
 	  by pressing various keys while holding SysRq (Alt+PrintScreen). It
 	  also works on a serial console (on PC hardware at least), if you
-	  send a BREAK and then within 5 seconds a command keypress. The
-	  keys are documented in <file:Documentation/admin-guide/sysrq.rst>.
-	  Don't say Y unless you really know what this hack does.
+	  send a BREAK and then within 5 seconds a command keypress. On UML,
+	  this is accomplished by sending a "sysrq" command with mconsole,
+	  followed by the letter for the requested command. The keys are
+	  documented in <file:Documentation/admin-guide/sysrq.rst>. Don't say
+	  Y unless you really know what this hack does.
 
 config MAGIC_SYSRQ_DEFAULT_ENABLE
 	hex "Enable magic SysRq key functions by default"
-- 
2.53.0


