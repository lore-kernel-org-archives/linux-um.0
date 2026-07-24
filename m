Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5B7C531FC
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Dao2iqXCWyRPq3hK3bPK+RzJkKKL67akXCH650mrRjM=; b=F/sx0jM32s+egeHvsE4OG5DUdl
	WhjNaJ4QLkPX0sU6KPAf1e6FrTrEnssQvGkpEh+nwBM+ZBBDaTkxBAntDkqe+vM48B6nZMa3Se7Lq
	LYKePInDdCfZFD2bBwmEbRjfiRJfe1eMj97HGXL/oEpGE6mX3tk/fVlBEvibuF1CVrla+HDZMaFZe
	eLA8unTDlzTH6UX7T8IfLQPkBjwjANCP1i8QpFznDSZoi44IkA2g0+A5AjLQZ22ZUBIVMQFtrHPET
	NnOgnEaYg+ZsRb737i1pbCAUa1NOttM44IXqgzZC8GeRx3tOP+9DxZI58Rh5FRcIJLmaicw1/Pmrf
	EIh81uSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe4-0000000HGkK-0szo;
	Fri, 24 Jul 2026 21:41:28 +0000
Received: from lpdvsmtp09.broadcom.com ([192.19.166.228] helo=relay.smtp-ext.broadcom.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe0-0000000HGh0-39Cq
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 21:41:26 +0000
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 41717C0000FA;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 41717C0000FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929281;
	bh=WeY6EXWLASPU5s4Pi3iS3gMMXxDyW++YTi7U1oRTEl4=;
	h=From:To:Cc:Subject:Date:From;
	b=BaWmbRWz2li0YD34PDN3e0Mj+sEwGhWboDX3sY/fqc0Kwd1jp8fibwt3kqmyRjbXj
	 7vzE2m61rE+cy+C4NfMEz3BN8ebpb8tNMGxlnN5zB+jvheM3uZLH/bAp/1uMLT9x+n
	 xgEhEpsGAaqwiS84y1iYFd4RfgEdkbLqEfhhsPvw=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 0ED55ACD;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.12 0/9] Kunit backports for older systems
Date: Fri, 24 Jul 2026 14:41:10 -0700
Message-Id: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_144124_858324_7C2414CD 
X-CRM114-Status: UNSURE (   9.05  )
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

This patch series addresses an issue we encountered on older Ubuntu
20.04.6 LTS servers whereby running Kunit would not return to a prompt
and it would not be possible to Ctrl-C the running session either.

Benjamin Berg (2):
  um: Set parent death signal for winch thread/process
  um: Set parent death signal for userspace process

David Gow (1):
  kunit: tool: Terminate kernel under test on SIGINT

Shuvam Pandey (1):
  kunit: tool: skip stty when stdin is not a tty

Tiwei Bie (5):
  um: Add os_set_pdeathsig helper function
  um: Use os_set_pdeathsig helper in winch thread/process
  um: Set parent-death signal for ubd io thread/process
  um: Set parent-death signal for write_sigio thread/process
  um: Preserve errno within signal handler

 arch/um/drivers/chan_user.c            |  2 ++
 arch/um/drivers/ubd_kern.c             |  1 +
 arch/um/include/shared/os.h            |  2 ++
 arch/um/os-Linux/process.c             |  6 ++++
 arch/um/os-Linux/sigio.c               |  1 +
 arch/um/os-Linux/signal.c              |  3 ++
 arch/um/os-Linux/skas/process.c        |  3 ++
 tools/testing/kunit/kunit_kernel.py    | 39 +++++++++++++++++-------
 tools/testing/kunit/kunit_tool_test.py | 42 ++++++++++++++++++++++++++
 9 files changed, 88 insertions(+), 11 deletions(-)

-- 
2.34.1


