Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EE7C3ABAD
	for <linux-um@archiver.kernel.org>; Sat,  3 May 2025 05:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AWeCNhOb1HG0U3gu+0GdR4gVRiBHz4K0tZlTHh8dPoc=; b=urKUgenvwEr5CZs4sGwVxuG1iA
	ahqnja1TI4jOJpKwOlLy2Bh8Hp4jWkYHvygqsXbSIMK9O47W7flfakj+C10m2WdlppxTCT3pA0HNB
	5CV1sMrmykvGATBoRnzdGnPHYZeewhu/zqUsd9KWfuUlAxKCAS6CCYCW5w4kB0PHXIETCBjEOawr7
	72el72nYffxRHb42T6x45/n1TuKY51goCpf8r7i0Y2zikg3kUl283/0B2h8Y4muKcLoKXdI0EWel2
	k9fxWxSQSg4VcVaFkTO9GNQIh+fbphW/o87THAo8/fVzqxRpgOJxZYdTRRmqsasbcLZS8EqaH97EZ
	s8a99+Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB5Fk-00000003Vl3-4653;
	Sat, 03 May 2025 05:17:32 +0000
Received: from out0-215.mail.aliyun.com ([140.205.0.215])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB5Fh-00000003Vig-1DJU
	for linux-um@lists.infradead.org;
	Sat, 03 May 2025 05:17:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1746249444; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AWeCNhOb1HG0U3gu+0GdR4gVRiBHz4K0tZlTHh8dPoc=;
	b=1eaZFZg1XoXALYaYLl9+YMMtOwQRe1dIGaCQoYUm4SO0uedwDIV8RepZz9tIS4LUi5AS74MaZn9UZKbfqRRcPnr9a0vF0lMN6t2NbkOewRpm7kFh2b3NL2jl/XozETvPa+bPrKL2fQW/GECjePYMjKQ8PTG8khPBZouBvTsFa6U=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cdmPQ9I_1746249437 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 03 May 2025 13:17:23 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/3] um: Remove legacy network transport support
Date: Sat, 03 May 2025 13:17:07 +0800
Message-Id: <20250503051710.3286595-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_221729_691595_8D7A53B5 
X-CRM114-Status: UNSURE (   5.57  )
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

Tiwei Bie (3):
  um: Remove obsolete legacy network transports
  um: vector: Eliminate the dependency on uml_net
  um: Remove legacy network transport infrastructure

 .../virt/uml/user_mode_linux_howto_v2.rst     |  47 +-
 arch/um/configs/i386_defconfig                |   7 -
 arch/um/configs/x86_64_defconfig              |   7 -
 arch/um/drivers/Kconfig                       | 196 +---
 arch/um/drivers/Makefile                      |  20 +-
 arch/um/drivers/daemon.h                      |  29 -
 arch/um/drivers/daemon_kern.c                 |  95 --
 arch/um/drivers/daemon_user.c                 | 194 ----
 arch/um/drivers/net_kern.c                    | 889 ------------------
 arch/um/drivers/net_user.c                    | 271 ------
 arch/um/drivers/slip.h                        |  21 -
 arch/um/drivers/slip_common.c                 |  55 --
 arch/um/drivers/slip_common.h                 | 106 ---
 arch/um/drivers/slip_kern.c                   |  93 --
 arch/um/drivers/slip_user.c                   | 252 -----
 arch/um/drivers/slirp.h                       |  34 -
 arch/um/drivers/slirp_kern.c                  | 120 ---
 arch/um/drivers/slirp_user.c                  | 124 ---
 arch/um/drivers/umcast.h                      |  27 -
 arch/um/drivers/umcast_kern.c                 | 188 ----
 arch/um/drivers/umcast_user.c                 | 184 ----
 arch/um/drivers/vde.h                         |  32 -
 arch/um/drivers/vde_kern.c                    | 129 ---
 arch/um/drivers/vde_user.c                    | 125 ---
 arch/um/drivers/vector_kern.c                 |  52 +-
 arch/um/include/shared/net_kern.h             |  69 --
 arch/um/include/shared/net_user.h             |  52 -
 arch/um/include/shared/os.h                   |   1 -
 arch/um/os-Linux/Makefile                     |   2 +-
 arch/um/os-Linux/drivers/Makefile             |  13 -
 arch/um/os-Linux/drivers/etap.h               |  21 -
 arch/um/os-Linux/drivers/ethertap_kern.c      | 100 --
 arch/um/os-Linux/drivers/ethertap_user.c      | 248 -----
 arch/um/os-Linux/drivers/tuntap.h             |  21 -
 arch/um/os-Linux/drivers/tuntap_kern.c        |  86 --
 arch/um/os-Linux/drivers/tuntap_user.c        | 215 -----
 arch/um/os-Linux/file.c                       |  15 -
 37 files changed, 63 insertions(+), 4077 deletions(-)
 delete mode 100644 arch/um/drivers/daemon.h
 delete mode 100644 arch/um/drivers/daemon_kern.c
 delete mode 100644 arch/um/drivers/daemon_user.c
 delete mode 100644 arch/um/drivers/net_kern.c
 delete mode 100644 arch/um/drivers/net_user.c
 delete mode 100644 arch/um/drivers/slip.h
 delete mode 100644 arch/um/drivers/slip_common.c
 delete mode 100644 arch/um/drivers/slip_common.h
 delete mode 100644 arch/um/drivers/slip_kern.c
 delete mode 100644 arch/um/drivers/slip_user.c
 delete mode 100644 arch/um/drivers/slirp.h
 delete mode 100644 arch/um/drivers/slirp_kern.c
 delete mode 100644 arch/um/drivers/slirp_user.c
 delete mode 100644 arch/um/drivers/umcast.h
 delete mode 100644 arch/um/drivers/umcast_kern.c
 delete mode 100644 arch/um/drivers/umcast_user.c
 delete mode 100644 arch/um/drivers/vde.h
 delete mode 100644 arch/um/drivers/vde_kern.c
 delete mode 100644 arch/um/drivers/vde_user.c
 delete mode 100644 arch/um/include/shared/net_kern.h
 delete mode 100644 arch/um/include/shared/net_user.h
 delete mode 100644 arch/um/os-Linux/drivers/Makefile
 delete mode 100644 arch/um/os-Linux/drivers/etap.h
 delete mode 100644 arch/um/os-Linux/drivers/ethertap_kern.c
 delete mode 100644 arch/um/os-Linux/drivers/ethertap_user.c
 delete mode 100644 arch/um/os-Linux/drivers/tuntap.h
 delete mode 100644 arch/um/os-Linux/drivers/tuntap_kern.c
 delete mode 100644 arch/um/os-Linux/drivers/tuntap_user.c

-- 
2.34.1


