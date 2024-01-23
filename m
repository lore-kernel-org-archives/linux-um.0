Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D114AC47258
	for <linux-um@archiver.kernel.org>; Tue, 23 Jan 2024 23:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+pfdCryokfJ1LEhDJ1PgJQZAZ0AXwZkyVJcgq44h8aQ=; b=jZADi9LL9KCjxrrdy6LrTH4Zzt
	w4Omqwm/4xn20MiWqiBbIx4R9e6AElx0DXUM8hWBz51bvfl7Rj7qcs9JJyhd74kQceXz169Mh+Rk9
	TGuHBON5U09s+grdlq+0h0cPOzx/FKXhnjLE5HIlX2pnIvHhuOJKnmpq/sXc/zyhZc+PWID3HnsEF
	+VmMInza7HrWD3eXpBJ2mQyRSoYrA0gg/YBGOldMQTYGtxOYzPLpOhQp6C3aAgbnM2G4EOcW4HL6F
	00H17+PdKtnPNXvRaO7Pju7n/vzc+wTx7ziiNKBkxnIu1bjiLnTPVXg2641sv7b7OO0hViAHnTLiq
	S2QdasRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSPkf-000lct-1i;
	Tue, 23 Jan 2024 23:00:17 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSPkc-000laB-1Q
	for linux-um@lists.infradead.org;
	Tue, 23 Jan 2024 23:00:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 96796CE3048;
	Tue, 23 Jan 2024 23:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73094C433F1;
	Tue, 23 Jan 2024 23:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706050810;
	bh=47d45/RRXMankzhMusTw5E76i3KancCT8EE4zAg0rGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hv9MKEwxpkkCCkQrEatypks4jWMZLmFrc201jDtKZrvVTqil/OWkpW2HYGAg3zXvM
	 gMNh2Ho5m6vOgxuB2hjiNRZSlChICJ0zQU+d3AZGJc81JMibhy1GnNDcbWlJQDAPw7
	 o6ZOXo5U19naO8rH8jduwiPgifsP58ZRT/8VH8KkisFvLzn+zBYz36FSYoKd82/Gif
	 YZApO56cPTyLi0bpM8E7S7ACjjrmJjkARStRRinS2CxJBMPuu31LK9cQgSxohWSrGG
	 fphJnxNbTS5rdh9Ro+VY9vZ9HKSCS2L05aL7blyt/JpHx+xhe0xAQbnCqU4Q4u9ZVU
	 PnTwLYkYnA+aw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 23 Jan 2024 15:59:55 -0700
Subject: [PATCH 2/2] modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-fix-uml-clang-18-v1-2-efc095519cf9@kernel.org>
References: <20240123-fix-uml-clang-18-v1-0-efc095519cf9@kernel.org>
In-Reply-To: <20240123-fix-uml-clang-18-v1-0-efc095519cf9@kernel.org>
To: richard@nod.at, anton.ivanov@cambridgegreys.com, 
 johannes@sipsolutions.net, masahiroy@kernel.org
Cc: nathan@kernel.org, nicolas@fjasle.eu, ndesaulniers@google.com, 
 morbo@google.com, justinstitt@google.com, linux-um@lists.infradead.org, 
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 stable@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=nathan@kernel.org;
 h=from:subject:message-id; bh=47d45/RRXMankzhMusTw5E76i3KancCT8EE4zAg0rGc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKkbXL7/kHuhv2nVz94j05xb+rcxrfI8Zv1VJ19xf4Pr/
 U8+V473d5SyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJTHFi+MN/aGvHkwsyHuev
 GRlp3JWeIr425ekSxR37Dmhc2TIpKs+YkWFNu471So56bseXdW7f9zf9v/pHgmdq6q0FNqd+doa
 /f8UGAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_150014_820047_08F205A4 
X-CRM114-Status: GOOD (  10.98  )
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

After the linked LLVM change, building ARCH=um defconfig results in a
segmentation fault in modpost. Prior to commit a23e7584ecf3 ("modpost:
unify 'sym' and 'to' in default_mismatch_handler()"), there was a
warning:

  WARNING: modpost: vmlinux.o(__ex_table+0x88): Section mismatch in reference to the .ltext:(unknown)
  WARNING: modpost: The relocation at __ex_table+0x88 references
  section ".ltext" which is not in the list of
  authorized sections.  If you're adding a new section
  and/or if this reference is valid, add ".ltext" to the
  list of authorized sections to jump to on fault.
  This can be achieved by adding ".ltext" to
  OTHER_TEXT_SECTIONS in scripts/mod/modpost.c.

The linked LLVM change moves global objects to the '.ltext' (and
'.ltext.*' with '-ffunction-sections') sections with '-mcmodel=large',
which ARCH=um uses. These sections should be handled just as '.text'
and '.text.*' are, so add them to TEXT_SECTIONS.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/1981
Link: https://github.com/llvm/llvm-project/commit/4bf8a688956a759b7b6b8d94f42d25c13c7af130
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 scripts/mod/modpost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index cb6406f485a9..f7c4d3fe4381 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -807,7 +807,8 @@ static void check_section(const char *modname, struct elf_info *elf,
 
 #define DATA_SECTIONS ".data", ".data.rel"
 #define TEXT_SECTIONS ".text", ".text.*", ".sched.text", \
-		".kprobes.text", ".cpuidle.text", ".noinstr.text"
+		".kprobes.text", ".cpuidle.text", ".noinstr.text", \
+		".ltext", ".ltext.*"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
 		".fixup", ".entry.text", ".exception.text", \
 		".coldtext", ".softirqentry.text"

-- 
2.43.0


