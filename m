Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B92C47DDC
	for <linux-um@archiver.kernel.org>; Tue, 23 Jan 2024 23:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kVWB2B6b1SkZxFbX8o1aqdzEjq9KkibZHN2ZlBQSy1A=; b=yjSnnR7z17CJIr
	lpLWAslyn82ooEfODigkiKPWZVsUu9YzO5vhpXgcw5eSR4wiPIeMWDqRCxYX/krUZimKGJQ+ESOyE
	FoC7mO21ARGvCZl2Kh91sVAatTHqnJ+Pm6axlKqG0LzNk1mgwVwoOoghPANinx5DLr103DI0lq+o+
	JDaE42pvbE0X4iXzXySh15KQQm/QFrUEC2porNi5gUd4eTfDj4RUY4M3mUSNgANJipASqij3hD03t
	6YA5KC+sLG4o6k4hjKWcPXxwhZftgD4K1ABGWtNi63ONVrmHSlMvCJUpgo3XPQ3M2llO99VA5vBKk
	aRkdt09y9bAVIipNQXuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSPkf-000lcj-0e;
	Tue, 23 Jan 2024 23:00:17 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSPkc-000la9-1M
	for linux-um@lists.infradead.org;
	Tue, 23 Jan 2024 23:00:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 27B9ECE3024;
	Tue, 23 Jan 2024 23:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938A2C433F1;
	Tue, 23 Jan 2024 23:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706050808;
	bh=67FZIBdOOMCQ00N5ExH/7I5y2V442bu28UsHFtb9aa8=;
	h=From:Subject:Date:To:Cc:From;
	b=JaNthWnXcGwKpArT4gZBJLpz0LIWEXmCpSDD0+/8ZuNXyS2CWAwvKCmYXJq+DYD4U
	 LnS7oKY33pmSxtlKQoD/rgTNf/egd/gKNvmrpb+Z66FnOzMbrjifw6SKak4nuUgHIK
	 XeVstqf0j6Twv0YiV5mFl4qmC2qH+65woTdelyT8MRxzyKz556XrVBJ85kQnFCY5UW
	 fV/y/mU4sbDiC0wyBzP3zlFa0TIMOv509gqAmj4oiSlyrj/8RXiqKhcM7SZQAxXFTv
	 DXityBgBNutwWEv804J54v8W6jsnhgTJvGQmX/ReSmeF2qhjopSEsZZ3VkhWnkDm9o
	 Y6WWicXzEF+8Q==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] Fix UML build with clang-18 and newer
Date: Tue, 23 Jan 2024 15:59:53 -0700
Message-Id: <20240123-fix-uml-clang-18-v1-0-efc095519cf9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOlEsGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0ML3bTMCt3S3Bzd5BygrC5QINXYzDTJwNTAONHIUgmoraAoFagGbGR
 0bG0tAKpI5MxiAAAA
To: richard@nod.at, anton.ivanov@cambridgegreys.com, 
 johannes@sipsolutions.net, masahiroy@kernel.org
Cc: nathan@kernel.org, nicolas@fjasle.eu, ndesaulniers@google.com, 
 morbo@google.com, justinstitt@google.com, linux-um@lists.infradead.org, 
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 stable@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=nathan@kernel.org;
 h=from:subject:message-id; bh=67FZIBdOOMCQ00N5ExH/7I5y2V442bu28UsHFtb9aa8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKkbXL4LvJZlsGizYPisv8E0OzhMcnZHkoH7u5p9BR9rO
 BLff/nfUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACai/JmRYab++ijpXc8kine8
 mrJv8+RIo90Zk+8s836w1e9xjcgR/kMMfwXuGnXtO7tSPqfhUY306w0zZ+X5Pjzf+H7GlX1+Ud7
 c3UwA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_150014_654756_6723800D 
X-CRM114-Status: UNSURE (   8.41  )
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

Hi all,

This series resolves two independent but related issues that were
recently exposed by two LLVM changes.

https://github.com/llvm/llvm-project/commit/ec92d74a0ef89b9dd46aee6ec8aca6bfd3c66a54
exposes that '-no-pie' is not getting added to the linker flags with
clang, resulting in building objects with '-fno-PIE' that are linked
with '-pie', to which the linker rightfully errors with:

  /usr/sbin/ld: init/main.o: relocation R_X86_64_32 against symbol `saved_command_line' can not be used when making a PIE object; recompile with -fPIE
  /usr/sbin/ld: failed to set dynamic section sizes: bad value

https://github.com/llvm/llvm-project/commit/4bf8a688956a759b7b6b8d94f42d25c13c7af130
adds '.ltext' (and '.ltext.*' with '-ffunction-sections') when using
'-mcmodel=large' (which UML does), which causes a segmentation fault
with modpost.

I have tested these patches with all supported versions of clang,
noticing no regressions.

---
Nathan Chancellor (2):
      um: Fix adding '-no-pie' for clang
      modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS

 arch/um/Makefile      | 4 +++-
 scripts/mod/modpost.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)
---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240118-fix-uml-clang-18-e365b0503a29

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


