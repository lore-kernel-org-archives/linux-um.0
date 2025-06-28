Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851F9C7EE39
	for <linux-um@archiver.kernel.org>; Sat, 28 Jun 2025 16:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+vv4yR9oqXyWfqRP4L1SN63wwPwk9iH4aPID46OwQoY=; b=1K7h7HdUZzBlfrOZ0UTqKF59cg
	C+hrvBUed7kvTg9Oa2fAscD27cFn5rRfjrJdEuIJ7rhIm110AR44JxQ/4bkX//iwXYEYEbreXF/8y
	JNTf3qp5hXzLx9x2eU86kjJ8zXOuCZ228h1W/frx4XmtS3nXL/7ZWGT7n+jT3G1WLqs9vthgtZMFs
	5IQ5av/aAgkAeB9btFvdLa3pq/eGz+ll0a2SKxaj9u00Zj2L7u1tJSIyr+IM8WftxK1XeW0+o1TBE
	+uDwuevmEGaHIcFEVsBHE4JSKNf1F5ARIQTjjZZRXFChhisW7b9fXnPxpjxeSXTWgcyG91r8AKGO9
	D/d0zrFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVYii-0000000H2Y4-0v62;
	Sat, 28 Jun 2025 16:48:04 +0000
Received: from out0-201.mail.aliyun.com ([140.205.0.201])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVYie-0000000H2Xe-3q6V
	for linux-um@lists.infradead.org;
	Sat, 28 Jun 2025 16:48:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1751129272; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+vv4yR9oqXyWfqRP4L1SN63wwPwk9iH4aPID46OwQoY=;
	b=nUoKfrGllOlK43JoG7lvNxAQvCLcrt+WZLP5cqNBhLBFFYcDwOE/XQWCb3+6IRV/QGxFxGlYe5BMqmnqHJ5RhCFRbSfFj1trG/jFJkHja2nDdmVjLeTY/5wKMsJ79Xcbu6p+A3v0G76gO7CXZzZG97qL9uusIqJT86eFSvmqHd0=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.dYsn1bO_1751129264 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 29 Jun 2025 00:47:49 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>,
  "kernel test robot" <lkp@intel.com>
Subject: [PATCH] um: Turn HAS_IOPORT_MAP off
Date: Sun, 29 Jun 2025 00:47:40 +0800
Message-Id: <20250628164740.353989-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250628_094801_644352_0D2E17E9 
X-CRM114-Status: UNSURE (   5.42  )
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

Since we don't have port I/O support, we should turn HAS_IOPORT_MAP
off as well. It will fix clang warnings like below:

./include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
 1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
      |                                                   ~~~~~~~~~~ ^

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506271049.MtzHqdSd-lkp@intel.com/
Fixes: b8c9c3b822fe ("um: stop using PCI port I/O")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
Strictly speaking, the -Wnull-pointer-arithmetic warnings reported
by lkp has been fixed by commit b8c9c3b822fe ("um: stop using PCI
port I/O"). But it introduced new -Wnull-pointer-arithmetic warnings,
and this patch fixes the newly introduced warnings.

 arch/um/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index f08e8a7fac93..76aa954520b1 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -54,6 +54,9 @@ config UML_IOMEM_EMULATION
 	select INDIRECT_IOMEM
 	select GENERIC_PCI_IOMAP
 
+config NO_IOPORT_MAP
+	def_bool y
+
 config ISA
 	bool
 
-- 
2.34.1


