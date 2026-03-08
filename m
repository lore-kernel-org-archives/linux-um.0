Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE4BF5512F
	for <linux-um@archiver.kernel.org>; Sun,  8 Mar 2026 06:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ggyfITsbBlqmEMsxipGeK/LeS8dDLvPv62gGa4+IqBE=; b=MV6B63SGgyiW4svR87+y2qZp6k
	AFgnW9ciOSWouXyfe8N0LISInOipV/vIceWHUnGuhKBhSOYNBSvsi5VKCdIUFzaVRAWz7+srloTmL
	4QfPZ54kIda+5BusuYHcwREc7gag23kHNt3GgrmY3e1zuZrL9xaLfsynYqDIfaQh9azr42zlJ7JeJ
	8aMDnpMQH3z5isnpyxFQsGe9jXkYXE0bdRUPmz4+PHLPGyWGlH3pBPw/u/62vVB5P5JtUqLA9QBgl
	vZJbZ3UfIcE9BqKBxGiMuhTW+MJK6SQqq+3zrIhkbJZt5Vt67BfjcGYqhsqtBdWWt/8yz9lCeqNJ2
	LZU97CeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vz7G4-00000005kAY-3iFT;
	Sun, 08 Mar 2026 06:04:56 +0000
Received: from out28-197.mail.aliyun.com ([115.124.28.197])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vz7G0-00000005kAA-41q9
	for linux-um@lists.infradead.org;
	Sun, 08 Mar 2026 06:04:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1772949882; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=ggyfITsbBlqmEMsxipGeK/LeS8dDLvPv62gGa4+IqBE=;
	b=m2ybpR+h0biyb92KuslXzn6GMn4v9t7f2CGZDV91DF1fLAUea4PAvwawzqHY4AskLmFLuxEMWr/XfsD5mnNWHBc2RuaMefoDOvhyTNIVgnqX9D1yEWTGUvENC6+p80VP7UpWfcpCL3orsxvfebHcIG3xDUwZF908TDFBRIuIj6c=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.gne18gZ_1772949852 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 08 Mar 2026 14:04:39 +0800
From: Tiwei Bie <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	Tiwei Bie <tiwei.btw@antgroup.com>
Subject: [PATCH] um: Remove CONFIG_FRAME_WARN from x86_64_defconfig
Date: Sun,  8 Mar 2026 14:04:06 +0800
Message-Id: <20260308060406.2772832-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260307_220453_596828_FAFEBDBD 
X-CRM114-Status: UNSURE (   7.06  )
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

The CONFIG_FRAME_WARN=1024 setting in x86_64_defconfig originates
from arch/um/defconfig, which was split into i386_defconfig and
x86_64_defconfig by commit e40f04d040c6 ("arch/um: make it work
with defconfig and x86_64"). Currently, it's even smaller than the
default on 32bit (i.e., 1280). It's no longer suitable for 64bit.
Building with x86_64_defconfig triggers the following warning:

lib/maple_tree.c: In function ‘mas_wr_bnode’:
lib/maple_tree.c:3740:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
 3740 | }
      | ^

Since we have a larger CONFIG_KERNEL_STACK_ORDER on 64bit (twice
that of 32bit) by default, we could increase CONFIG_FRAME_WARN
accordingly. Let's remove the CONFIG_FRAME_WARN=1024 setting from
x86_64_defconfig and just use the default value (2048 for 64bit)
defined in lib/Kconfig.debug, as we do for 32bit.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/configs/x86_64_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index cf309c5406a2..af6ff784e2d3 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -60,5 +60,4 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NLS=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
-CONFIG_FRAME_WARN=1024
 CONFIG_DEBUG_KERNEL=y
-- 
2.34.1


