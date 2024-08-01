Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55251C3DA64
	for <linux-um@archiver.kernel.org>; Thu,  1 Aug 2024 00:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7pWV1tyiTR6SQO+zInlwDTyWETwymhw931IkYHPGpjA=; b=FKhxUqVENU5VkbjgY0WHFuWCsJ
	U3JqrQZ8hbMQN9k+dUO/JM2XqNAFrP4d8gUmC1xEGd6bbaQwQvyBH4fE2NtPwufklgsrLA7CrcYCC
	cgMc5YahzY+8HsGVmS88FFmGksY/M9NDEJ/QZn1XpanpQNLE7G2ezUFTs3kS5m0HY0JmFCKPPJCkw
	G64UPI1uRqj08un3UdnnGZ64hjXek19YMdAICUdv6LzYjCSKsqNCbzR3eRyEvlVZ4FgCPVhzIF1yE
	6urNvpYeXr8KX+D8NV2+0UERz0c++9a5Op8CnmxLo4FH/eclXg2mEUpXL04+dGiI+/b9P50UmzT9r
	jdiFjh/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJsP-000000034e9-3ovA;
	Thu, 01 Aug 2024 00:41:05 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJsM-000000034cz-2ksT
	for linux-um@lists.infradead.org;
	Thu, 01 Aug 2024 00:41:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0A490CE13BD;
	Thu,  1 Aug 2024 00:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C86C4AF10;
	Thu,  1 Aug 2024 00:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472860;
	bh=aAZs5msIReOHMjel2MWfn1tq9+vDR7M4zBIfaF1jOzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=taNDLm08JFZhiS/K65x4bMo5yFFgsCyPt72V3YMOjIVVRJdnUfvhMXZBNZNpM+uR/
	 2/eDfG9LXSIsuaOb9xK/nQMf437qBzovbfPuWGB7dsmaMeJBIAdfOnkO5BYwIwEqIh
	 KBIj17K3AWvU9W5LYO2TllK0TsrCR5bC96uHlf2SGN7sELom59DOaSWiphgMx39SGp
	 tW6IM+k0satV6FL+p257Brq09wEG+o3hlPzgXSGmQ8Wv+D+kjnWjO8efVgsZUObUYx
	 1F3CcofkX8SnWGOR/kMXkJGfyAfM45wUHNNXlAm6WOLD3G5pIMic6Nwqo9SRYaJ5/c
	 RLonjGwl/6OaQ==
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
Subject: [PATCH AUTOSEL 4.19 09/14] um: line: always fill *error_out in setup_one_line()
Date: Wed, 31 Jul 2024 20:40:17 -0400
Message-ID: <20240801004037.3939932-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801004037.3939932-1-sashal@kernel.org>
References: <20240801004037.3939932-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_174102_892711_F74D2406 
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
index 71e26488dfde2..b5c3bc0e6bce0 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -391,6 +391,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			parse_chan_pair(NULL, line, n, opts, error_out);
 			err = 0;
 		}
+		*error_out = "configured as 'none'";
 	} else {
 		char *new = kstrdup(init, GFP_KERNEL);
 		if (!new) {
@@ -414,6 +415,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			}
 		}
 		if (err) {
+			*error_out = "failed to parse channel pair";
 			line->init_str = NULL;
 			line->valid = 0;
 			kfree(new);
-- 
2.43.0


