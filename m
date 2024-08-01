Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2994C3DA64
	for <linux-um@archiver.kernel.org>; Thu,  1 Aug 2024 00:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=81TmlVsQT8AHJJUrZ6fvZaJI0YO+DqBGAyMeyVkWqcM=; b=m9qFWxv/oKg5UG2cVgOEbcPwD5
	Pyr4lwjsy6xWn7l9Lg4+nGdS9y3yDAaLpSXkgvtldCcGrd9xFvxwc5oNBQDtXfmpkg67tOBh1WMNI
	933wYn48KB4CfqbV8PC97Nrmwd88VE6rNSB0tjJVb+Yalwf6hu/EDCpUQqfskfAMg3M225A7XZWQs
	HOCA5xDLAdQMq9GNDz4L/o/rH9DcoxSoHswVoED29uM806Lo6KE0HAZHPDVoVZQFHG3M7etqNXO29
	hpl7uWbqi4tRqHP+xQwmIUap9OVUvv6oqDt8bJBfCFia8ZZEUYdcwbIuWkPnJfYSG500Qj2xvnyRM
	JiunBuJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJjX-000000031i5-1Q3i;
	Thu, 01 Aug 2024 00:31:55 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJiy-000000031TT-34yy
	for linux-um@lists.infradead.org;
	Thu, 01 Aug 2024 00:31:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1448E624C0;
	Thu,  1 Aug 2024 00:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83577C116B1;
	Thu,  1 Aug 2024 00:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472279;
	bh=uP4TlehPy0hVgRkfWi8usR0oWixCZMo03YZrwSkKnko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ex1SRMYbgBd7k6IZKdADjh4EBFc83gdfztoa3Oi2fvDN6N/G5Se16M1JVLoKGVpL5
	 sKYkX+lWEPhMNIWoB7ISC1Kh/pDW5lW8VQHcG5Tnn808EjHodRK8tBoubH5N/V3jex
	 vc4qsIbB8ADqthxF1VpknXMzjSKWSwbEqASmA/Upu8oxMLyj6HYaQegoDDG35A6ig6
	 XYF7lkPQ1owFW87amsszHE7gQggEOD5gbwLGOde3+/3YfGQZwvrgYSCYnbOXIGQ/0L
	 Aeae6h0/qL73RO8JnxAM8dwZUPF1zqh7JdhZMyswRt8fQfBI9l+nI9bpS2UyYXfMoZ
	 B6SQ0cvkVtXaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	roberto.sassu@huawei.com,
	benjamin@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 53/61] um: line: always fill *error_out in setup_one_line()
Date: Wed, 31 Jul 2024 20:26:11 -0400
Message-ID: <20240801002803.3935985-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_173120_869782_FD8C1642 
X-CRM114-Status: UNSURE (   9.47  )
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 824ac4a5edd3f7494ab1996826c4f47f8ef0f63d ]

The pointer isn't initialized by callers, but I have
encountered cases where it's still printed; initialize
it in all possible cases in setup_one_line().

Link: https://patch.msgid.link/20240703172235.ad863568b55f.Iaa1eba4db8265d7715ba71d5f6bb8c7ff63d27e9@changeid
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/line.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 95ad6b190d1d1..6b4faca401ea1 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -383,6 +383,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			parse_chan_pair(NULL, line, n, opts, error_out);
 			err = 0;
 		}
+		*error_out = "configured as 'none'";
 	} else {
 		char *new = kstrdup(init, GFP_KERNEL);
 		if (!new) {
@@ -406,6 +407,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			}
 		}
 		if (err) {
+			*error_out = "failed to parse channel pair";
 			line->init_str = NULL;
 			line->valid = 0;
 			kfree(new);
-- 
2.43.0


