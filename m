Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9275BC3DA4A
	for <linux-um@archiver.kernel.org>; Fri, 16 Aug 2024 10:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LTmj84zcrMSG/7oxdcFgD9iQDmdedlra1IBnqpPooqs=; b=Ko10va1d4Pl/uHBmKrNhb3AU2N
	CE0Y4y+a7dSqBpY483OGNhhBZjmk+0xKPHfS57kJiPCgsO1aVqXg1IWgDFh/2P6VFlrrRvB+TUolM
	GZMp43zfVwvJHjS8l+PXCOGNkN38q2TuTo5vVVac+/wH5C+ztTXxcczJm0grgMVBWlIg0JN+Tgm0C
	LOaca4e50hbGWdQ24zCB9kpwLYBrn0TAUmw2MooXlsLuHkfK796h8BdH8UUkpWjO9rQS1o2yRQKQe
	rHFEnrF7j37FrENt1gEqS3cNtJ/y0Fo0mqXaVC5Zx1vRGnktp118kzdfsFrhkK65btcsQvzfvBvgF
	YS3RF+BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1setlP-0000000CWbT-1G4q;
	Fri, 16 Aug 2024 10:00:55 +0000
Received: from out0-201.mail.aliyun.com ([140.205.0.201])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1setke-0000000CWKI-3Epb
	for linux-um@lists.infradead.org;
	Fri, 16 Aug 2024 10:00:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723802407; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LTmj84zcrMSG/7oxdcFgD9iQDmdedlra1IBnqpPooqs=;
	b=XdYYewaPrMo9/+AgJfhMNQ1KDSv4RGHJrqIsf/ckER/TlkZIfQrz4bij6YEb+yz41NqTfjbWbsh9Ch4P7oMMdWI4dkt1Gh/y6OOhi/fycAY3aGBSwKM7Xadq8Gr1XkgPl7yC34JbmlIsScFMobdTZs6bbrIuxYeweuAEL1UgZQ0=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtmFE9t_1723802405)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 18:00:05 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 6/6] um: Remove declarations of undefined functions
Date: Fri, 16 Aug 2024 17:59:53 +0800
Message-Id: <20240816095953.638401-7-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816095953.638401-1-tiwei.btw@antgroup.com>
References: <20240816095953.638401-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_030009_191010_90C859CB 
X-CRM114-Status: UNSURE (   5.93  )
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

The definitions of these functions do not exist anymore.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/skas/skas.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index ebaa116de30b..85c50122ab98 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -10,10 +10,8 @@
 
 extern int userspace_pid[];
 
-extern int user_thread(unsigned long stack, int flags);
 extern void new_thread_handler(void);
 extern void handle_syscall(struct uml_pt_regs *regs);
-extern long execute_syscall_skas(void *r);
 extern unsigned long current_stub_stack(void);
 extern struct mm_id *current_mm_id(void);
 extern void current_mm_sync(void);
-- 
2.34.1


