Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222A2C54733
	for <linux-um@archiver.kernel.org>; Mon, 26 Aug 2024 10:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gV4YuhNr3rLW09QhC/TCMiLgjL0RM1UYr/GPl7N5E/g=; b=aad6e7mhQg3xeCmvvUcXIW351f
	Zb4gnomf5rx67wnBID9u9MF0hme3QypBo7gUMy1Yi3sAycCn0EE+FSgjAaqTRCoEp6kaPOiVnnQwB
	pm0Nwc609R4RcjCkRfBnXP2I0Kdd+qRhcDcKOfNQoCjhP7jyEy6TYvXl1CPVcB1NZG/qDjwkPlCil
	EDAggWFl1RwbQO2Y6XW0AGtg/CPviG99FKT6U0mYplDmQTfXyRPd42oCAPWbI55ESEotlgzC95OWp
	r9JL0HYbohboY0nls5s1qGjtPokY12kZ698QVm4YfsnJusR7zXiXFh0XizR19FnV7UPOSdcQ9k6En
	rrulXyPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWll-00000006sz8-3UHT;
	Mon, 26 Aug 2024 10:16:17 +0000
Received: from out0-210.mail.aliyun.com ([140.205.0.210])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWeH-00000006qtL-0ZqH
	for linux-um@lists.infradead.org;
	Mon, 26 Aug 2024 10:08:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724666906; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gV4YuhNr3rLW09QhC/TCMiLgjL0RM1UYr/GPl7N5E/g=;
	b=oNfqA+5EJKqszyVOIqYSyhvEww3ctxWH3LVVhnJw3p4EHzJu1jLyjUvy/9y0fdC08bIfucEY4+TPwTrJlxMNkgUo085vVGr0LBp4E9uxpcXsQibBV2dSFrkz/+NxXLnAqfif+owmi1/I7d11w2vyC+/SXAcKS6tPdc21+ev2/h0=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Z2YRsYx_1724666898)
          by smtp.aliyun-inc.com;
          Mon, 26 Aug 2024 18:08:25 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 0/7] Some minor cleanups for UML
Date: Mon, 26 Aug 2024 18:08:08 +0800
Message-Id: <20240826100815.904430-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_030833_693004_C1C236CA 
X-CRM114-Status: UNSURE (   8.43  )
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

Changes in v3:

- Remove "um: Remove declarations of undefined functions";
- Add "um: Remove the declaration of user_thread function";
- Add "um: Remove outdated asm/sysrq.h header";
- Minor tweaks on commit log;

Changes in v2 (https://lore.kernel.org/linux-um/20240816095953.638401-1-tiwei.btw@antgroup.com/):

- Remove the pointless union (suggested by Benjamin Berg);
- Minor tweaks on coding style;

v1: https://lore.kernel.org/linux-um/20240816015447.320394-1-tiwei.btw@antgroup.com/

Tiwei Bie (7):
  um: Remove unused kpte_clear_flush macro
  um: Remove the redundant newpage check in update_pte_range
  um: Remove unused fields from thread_struct
  um: Remove unused mm_fd field from mm_id
  um: Remove the call to SUBARCH_EXECVE1 macro
  um: Remove the declaration of user_thread function
  um: Remove outdated asm/sysrq.h header

 arch/um/include/asm/pgtable.h           |  7 -------
 arch/um/include/asm/processor-generic.h | 20 +++++---------------
 arch/um/include/asm/sysrq.h             |  8 --------
 arch/um/include/shared/skas/mm_id.h     |  5 +----
 arch/um/include/shared/skas/skas.h      |  1 -
 arch/um/kernel/exec.c                   |  3 ---
 arch/um/kernel/process.c                |  8 ++++----
 arch/um/kernel/reboot.c                 |  2 +-
 arch/um/kernel/skas/mmu.c               | 12 ++++++------
 arch/um/kernel/skas/process.c           |  4 ++--
 arch/um/kernel/sysrq.c                  |  1 -
 arch/um/kernel/time.c                   |  2 +-
 arch/um/kernel/tlb.c                    | 16 ++++++----------
 arch/um/os-Linux/skas/mem.c             |  2 +-
 arch/um/os-Linux/skas/process.c         |  2 +-
 arch/x86/um/sysrq_32.c                  |  1 -
 arch/x86/um/sysrq_64.c                  |  1 -
 17 files changed, 28 insertions(+), 67 deletions(-)
 delete mode 100644 arch/um/include/asm/sysrq.h

-- 
2.34.1


