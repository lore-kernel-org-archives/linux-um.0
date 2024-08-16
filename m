Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C80EC3DA4A
	for <linux-um@archiver.kernel.org>; Fri, 16 Aug 2024 10:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lQzoUbWA0uPjbm9HtmRPATyMTXIf86gHTMmcjgrN4O8=; b=2cKzVvI9Na+o5j+uATz2xL8lpZ
	k4QFht8hmIZ6/swJoMnahg1oOXVR4GktuOqbCXNEjUbpU8C4e34Ykjs+OPxkD078GeAqljs4KzuW8
	JBw/SbuLhlxhbLI/z/bTm8ZbQAESQhDG7mbnzKs5VvYM3J2r6JsN6Q17YU3CuqexzX2GjZMoZC5si
	pPQuFLSSt5Ut5un9QDfXk1kdQkJnza2O4tEqm0TTJLLhTYPC57GL9+G60Iwa1LnZ0sNP5D+70oZMQ
	eWiBOgQIOZOBJrdISyGmmiCubcHprLJxV3KcmLbhk2od5PT2VVA0TM4eZmq30ZmzoIT4HS0hu0TLB
	q5cB2Y1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1setki-0000000CWNH-2vSe;
	Fri, 16 Aug 2024 10:00:12 +0000
Received: from out0-213.mail.aliyun.com ([140.205.0.213])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1setke-0000000CWK9-0nI6
	for linux-um@lists.infradead.org;
	Fri, 16 Aug 2024 10:00:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723802404; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lQzoUbWA0uPjbm9HtmRPATyMTXIf86gHTMmcjgrN4O8=;
	b=x9F/YvFcARj1+V5YWMa7fcuaYgE9VrP6qMsrYit23H26wtK8+DOQ5GT7InC4fOxx9AuGNU5xo5fhBU2GvK5MiLv1g0yCCNWB+Rb1MoPJpdZ/su7gooasfuzDdcoe/h8zLMN9lcXdppKG10kJ7SgdfuUYtfbgcx8NPQWcJCrVAmg=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtmFE-Y_1723802396)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 18:00:03 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 0/6] Some minor cleanups for UML
Date: Fri, 16 Aug 2024 17:59:47 +0800
Message-Id: <20240816095953.638401-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_030008_728230_630B018E 
X-CRM114-Status: UNSURE (   6.53  )
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

Changes in v2:

- Remove the pointless union (suggested by Benjamin Berg);
- Minor tweaks on coding style;

v1: https://lore.kernel.org/linux-um/20240816015447.320394-1-tiwei.btw@antgroup.com/

Tiwei Bie (6):
  um: Remove unused kpte_clear_flush macro
  um: Remove the redundant newpage check in update_pte_range
  um: Remove unused fields from thread_struct
  um: Remove unused mm_fd field from mm_id
  um: Remove the call to SUBARCH_EXECVE1 macro
  um: Remove declarations of undefined functions

 arch/um/include/asm/pgtable.h           |  7 -------
 arch/um/include/asm/processor-generic.h | 20 +++++---------------
 arch/um/include/shared/skas/mm_id.h     |  5 +----
 arch/um/include/shared/skas/skas.h      |  2 --
 arch/um/kernel/exec.c                   |  3 ---
 arch/um/kernel/process.c                |  8 ++++----
 arch/um/kernel/reboot.c                 |  2 +-
 arch/um/kernel/skas/mmu.c               | 12 ++++++------
 arch/um/kernel/skas/process.c           |  4 ++--
 arch/um/kernel/time.c                   |  2 +-
 arch/um/kernel/tlb.c                    | 16 ++++++----------
 arch/um/os-Linux/skas/mem.c             |  2 +-
 arch/um/os-Linux/skas/process.c         |  2 +-
 13 files changed, 28 insertions(+), 57 deletions(-)

-- 
2.34.1


