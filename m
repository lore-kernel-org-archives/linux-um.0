Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A626C5516E
	for <linux-um@archiver.kernel.org>; Thu, 30 Jul 2026 19:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9OKwkKKrni4xuNcZe47h6GqmHd/H1WVHl+VoGcRux0U=; b=Ul3c1n+KpFc4y8esgkqqa51usn
	4ieHM2XTYMwddhiyGwvJ3TPbzf/iUDzEoqo6Fdy7nJu0py5Mr4a5sjhMTstug2pQiGFIEJrPwHci3
	/2dRUQMdZ92MtTcW3iEnEIQ1d5woZaBaYPNH+gqADWlOvUi5uIC+bziSyRHGRVVr549eTpfb0XTQ6
	IyaYZIcWO6A8+4bI7P6TBgQv+j1POjqk+MapGHNIH867ov5Ac52uSA3hSUQ8hKSTslEotGj0IY3gE
	nZsavdzxvcaSobJesuWrbm7CVpt0LwB2mvJa/nIvKdpuN+7LU/FENxUlByWyj2EBOC6tWXDGysiNw
	tNdhT4qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpW2c-0000000BCOg-43Vb;
	Thu, 30 Jul 2026 19:03:38 +0000
Received: from relay.smtp-ext.broadcom.com ([192.19.166.231])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpW2a-0000000BCNf-1O41
	for linux-um@lists.infradead.org;
	Thu, 30 Jul 2026 19:03:38 +0000
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 309B6C0000D6;
	Thu, 30 Jul 2026 12:03:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 309B6C0000D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1785438213;
	bh=HgBI0p3L78A2gotBtRXW+DqrxGUnWnjoc1ImI8EwE6I=;
	h=From:To:Cc:Subject:Date:From;
	b=nHEFK/Hqfyuiu+tmUEQ1GQ5PNfZiZ5Imb0eoZcwf4gJgu7OcW+nHKXBgUZjj5liqt
	 77IFOYSYUTL+bd1gV+Km3j9CGju2yzu7OcaELc02e14fxFDkUfOfzDR2MHtu6bB2g4
	 DwiaFdX/d7/IK1h3F+c8CMpjDTiIGZkm9BC0RPTY=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id EBFDFADD;
	Thu, 30 Jul 2026 12:03:32 -0700 (PDT)
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
Subject: [PATCH stable 6.18 0/2] Kunit backports for older systems
Date: Thu, 30 Jul 2026 12:03:27 -0700
Message-Id: <20260730190329.3388222-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_120337_016847_88BFFB4B 
X-CRM114-Status: UNSURE (   8.45  )
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

David Gow (1):
  kunit: tool: Terminate kernel under test on SIGINT

Shuvam Pandey (1):
  kunit: tool: skip stty when stdin is not a tty

 tools/testing/kunit/kunit_kernel.py    | 38 ++++++++++++++++-------
 tools/testing/kunit/kunit_tool_test.py | 42 ++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 11 deletions(-)

-- 
2.34.1


