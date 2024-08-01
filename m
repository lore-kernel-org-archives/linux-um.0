Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4391C3DA7F
	for <linux-um@archiver.kernel.org>; Thu,  1 Aug 2024 00:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9QdcM1D+AX7Jk+0d3jBW/5HApVw3WooYaABqMGyr4zE=; b=uk6biKAPtvS2ZQD6lvDxZ8D8RC
	oKs6CWpgkJ+tP+oQFiVj3AR2CWEsBaoiQ9t95AiPPb9YS0Jvj/ImmbRNd+J7ZQJF1rr2MGQS3erkq
	QhJu1h1KKqSqHeJEfLjYFxj2qKRIYkMSKjZW+hIDtKBqhlhdg33UovnDlaeX2WwYKap7iCUq46ydt
	fTOKGzyf4XapYq9rQRaW1HVgA+txvWvmkHAlzHl2+52+t9lpifd3hVDCIYwdV+8aniQ8Ue9sz4Vt6
	FyTthIYwlxZMP8gYbBk+AGT8t7n6l23opQ4D5bvCFM2Q4RHiTE0CktvvCZBZIFr56o6bJJBdhh4sz
	/jzl4nmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJX2-00000002x5w-2jpw;
	Thu, 01 Aug 2024 00:19:00 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJWC-00000002wkT-1Z4G
	for linux-um@lists.infradead.org;
	Thu, 01 Aug 2024 00:18:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AF55F624CE;
	Thu,  1 Aug 2024 00:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202CDC116B1;
	Thu,  1 Aug 2024 00:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471487;
	bh=MyxFag4pLvPdYkUcDlgL1xkABfBZqiGJ1mTFCb2NG5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GeQx1zWg7F4z6ACwOJV2O3bQdPZB9Yi/Iwbj4tQfvGRdIlcc1rXKWliBl4pE5NJCh
	 8hPPa2Hj4/o5vypYKPlp8NqP3Q5wtEVQ4IVDjucB7SS2/vwmijv/i+XymojPp8Jiz2
	 IT/CQoUqnQKO6SfcxyMSkj9s3QeFIoNBREFXy8NHj1disVnmcCC9JiITRy2rwDciX5
	 6bFDRIT6yQm/7PeAHG0AVVYNg2KT6jkSzzBcmO/Ta1v1GYEZWr4bPqQaZhjM+RoIrU
	 nsgKi65w1dTeiVs4SSoly1MxFImFb7Ne1WGCu7D51F3NPKk+ZJyGhP4enyzyk9OTzO
	 nsqRzqa7/I7yQ==
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
	roberto.sassu@huawei.com,
	benjamin@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 107/121] um: line: always fill *error_out in setup_one_line()
Date: Wed, 31 Jul 2024 20:00:45 -0400
Message-ID: <20240801000834.3930818-107-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_171808_594848_3D4BE5C0 
X-CRM114-Status: UNSURE (   9.54  )
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
index d82bc3fdb86e7..43d8959cc746f 100644
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


