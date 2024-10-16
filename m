Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74B6D2F7C2
	for <linux-um@archiver.kernel.org>; Wed, 16 Oct 2024 21:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=N5jl8iqQn15K/r0lgu7yKrB8BOfggBKRG9RYqQ4n6HE=; b=vboAiCKCkRodV5
	ruu4VeNZNPkB0kpDnn3LCJzaFqvKLHigqTM6mWjqBxmce0d8OTIooyQlb6hw2YLkro52iD8Fx7pw/
	TuEoioRDgQ1wSwm6cTSvvVrRvaLPIh+1tOu+GG+tPX0w+uqaGIE3AM2Zlc7jMaQj5lObsiapLkeKY
	Raw6jVDED3cGfrVtYY7cjWVU0KdVa3PpYdNaWKGIPW1NYEkYiRW2UqoJas1esekPo3r/STh374JUR
	qnSvbxpT3iJqCZ/IsfTLi9oImxuMUEiwBiTnsGHsh7sy2VNLv8Ob3L6q9pzdyBUXCtHclIgu6U+wj
	m0fys6sb3NEWhhVOqcZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1BK6-0000000D1Vh-1mw0;
	Wed, 16 Oct 2024 21:12:50 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1BK3-0000000D1Ui-10dC
	for linux-um@lists.infradead.org;
	Wed, 16 Oct 2024 21:12:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4E015A40168;
	Wed, 16 Oct 2024 21:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574A9C4CEC5;
	Wed, 16 Oct 2024 21:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729113166;
	bh=gvPBuO8nQ4vzn798wSf1AJborcfkCDs17JO72U1ptd8=;
	h=From:Subject:Date:To:Cc:From;
	b=FebUSwRQvl0PbE0ZXrj2/PrRxH8Ez7cUli8GdVZ5DIYMqU7jkpTYmHeodo3RsPYK7
	 EfIseQ3Bkt1vQiawerXjuZmwrixuKeGOohUIKDZstNh7cxb+zstqyx1lYqWy760NuS
	 nJY5hyWc7IHGBUyLzsY94gRHgUuoFk6kv48OhwI8paK9uj9eVUCieeXQkJuPvPoKxk
	 SsEOZUTsnP4Y0p95pIcdEsdqoCmDUQc4Jdq4unoa7dHYq7gXhB3DrF4SjZ4qdri0W4
	 cTj2DQQeow7NGmQw+HVqZwCR2wrAsa4UNJVhWVl/7/RfWIP9HEICk3zaryibmkgPRJ
	 rAZDzx1FmtZcA==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] um: Fix a couple of issues with stub_exe when building
 with clang
Date: Wed, 16 Oct 2024 14:12:36 -0700
Message-Id: <20241016-uml-fix-stub_exe-clang-v1-0-3d6381dc5a78@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQsEGcC/x2M7QpAQBAAX0X729bduZBXkXTOYstXd0jJu9v8n
 JqZByIFpghV8kCgiyNvq4BOE/CTW0dC7oXBKGO10jmey4wD3xiPs2vpJvSzaOi7UtnC2KLPHEi
 8BxLrH9fN+37kp116aAAAAA==
X-Change-ID: 20241016-uml-fix-stub_exe-clang-cb8047247d3a
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Benjamin Berg <benjamin.berg@intel.com>, linux-um@lists.infradead.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=660; i=nathan@kernel.org;
 h=from:subject:message-id; bh=gvPBuO8nQ4vzn798wSf1AJborcfkCDs17JO72U1ptd8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOkCOj6mByZtudzw1bjhwXq5N+taffY8vMQ0JdVsWtESN
 4sVBen3OkpZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBE1OIY/kpnxObtuLc5RmNF
 xrLV/1Nm2uefZHXqN1qYc0h57veoX9EMf8W4fiXPq0qdbiU80UrY73a4MK/dR/vJZjwsU/xXPPe
 5yQUA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_141247_367423_5A7D5BD8 
X-CRM114-Status: UNSURE (   6.65  )
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

This series fixes a couple of issues I see when building ARCH=um
defconfig with LLVM=1 after commit 32e8eaf263d9 ("um: use execveat to
create userspace MMs") in -next.

This passes my basic build and boot testing with both GCC and clang.

---
Nathan Chancellor (2):
      um: Fix passing '-n' to linker for stub_exe
      um: Disable auto variable initialization for stub_exe.c

 arch/um/kernel/skas/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
---
base-commit: 41ab5fe7471ff38d2909d1c93b88197a89c6a00f
change-id: 20241016-uml-fix-stub_exe-clang-cb8047247d3a

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


