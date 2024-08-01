Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60B0C3DA64
	for <linux-um@archiver.kernel.org>; Thu,  1 Aug 2024 00:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vafjY/cPJRVJCeUUdTLSyF6LyRgnAB2N/GfDzbXZUDo=; b=thN0O0F+a5XwwCyCBYikjeZ0oS
	3ZUBK2vP8G4sTwfL+UezpDTRmL4nqm9K/4ct+cN1DuocC/GRXD/lD8jVYLm8Qk742I0Pp9qyB255z
	v1C65HcO8v0Ew+gA1y06MwNzCJXZ1gmPJtQmQupVsHya61rfc1gx1jKuvSGhR7NDWhWaaVmD/HHOS
	ZUcQGL5XtV55oHE6Cmm9UHKzK216cnS4C55ZbGmB7mHP2HyIQq4UIkfnVpAGY1PNj/FSafU+RIitz
	W/OcXFarYQikr/kL4PzujJzGfUKp7tgAmowcHFkOMIyjOEZ/aUY2cdy/rwK64mOvcHTLihEOt6s01
	gZPufCAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJra-000000034My-4Aox;
	Thu, 01 Aug 2024 00:40:14 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJrX-000000034Li-2vHl
	for linux-um@lists.infradead.org;
	Thu, 01 Aug 2024 00:40:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0759DCE17A6;
	Thu,  1 Aug 2024 00:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C8DC4AF0C;
	Thu,  1 Aug 2024 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472808;
	bh=wguXzFw4PTlSl66Xt0Za4x3FwfE7FPyPh62+x4i+tY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5kAzFON4T3+mghcsQQGaclL5p380bQjj4/VF3bWYKKd3V+EfhoDMLSW7OzerIN1d
	 dURuODL9ImoPLARcv1dgjZshximL2qpLrIdPpMQN3TQWPLDVoSG8ksnLs2QNEScdUy
	 8LgCSXLcn6hXoaHKkGuQdJUcPAhOilu3+MkfDIEvWpV4s0d1FvNJQjbmmX8yFp+LRu
	 T943EtgC7KDCc9F4eOIWOCyWpJlnL/weRlp+yvDGsj0wROq9ckOtIAKinve3tlgeTN
	 9rmZqATfF2Oqj55ZmFKkC50QTD1eFZF74VMcl1LNtHj6Pl8evb0lPo5LtlBQj0tO8E
	 OjAoojpFREOig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	johannes@sipsolutions.net,
	jirislaby@kernel.org,
	gregkh@linuxfoundation.org,
	benjamin@sipsolutions.net,
	roberto.sassu@huawei.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 16/22] um: line: always fill *error_out in setup_one_line()
Date: Wed, 31 Jul 2024 20:38:45 -0400
Message-ID: <20240801003918.3939431-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003918.3939431-1-sashal@kernel.org>
References: <20240801003918.3939431-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_174011_944606_8414BFDA 
X-CRM114-Status: UNSURE (   9.56  )
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
index d6a78c3548a55..de0ab2e455b03 100644
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


