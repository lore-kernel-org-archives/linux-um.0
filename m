Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899F7C52D1D
	for <linux-um@archiver.kernel.org>; Thu,  1 Aug 2024 00:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ge90lDq/sY8eQ/qNQmY7RpqdVsYd+AnJLUf4729VF7w=; b=IyEWd22OotRTBkyaWvu35HNWKE
	vLOssCLw2tF1QHd/Xp2szx5tJPxBzFrhghK/1nzgovateguR6VOQpLXYJJjhyuVrfneDFvIICbHsf
	7988yGxI90b9/8kddgvKnB/V49F7/ZEgqYMjkpIAMPXoQknCzptaUaxn0YQoz20JEA49QPx+++8Jm
	JaxtpUBMJJt00tZXAgapMH6o7T6YmrekFJefWaquiyem7Km8Vi/huA9/Nvp5nUPIwyysEUTQfF0CX
	8iBaNravqZKYNbGpXb0Mfq3BrbtzOVWm64I1/jbx5r5gxMLWyzo/VvXeMicyD54xtv0Q1PAhkAYsn
	yvjP9wKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJeA-00000002zXz-0e5v;
	Thu, 01 Aug 2024 00:26:22 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJdk-00000002zNm-2OhC
	for linux-um@lists.infradead.org;
	Thu, 01 Aug 2024 00:25:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E3462CE1872;
	Thu,  1 Aug 2024 00:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94967C4AF0C;
	Thu,  1 Aug 2024 00:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471954;
	bh=lMtDDwjMzEvoyqQbFczBqC9w3VNXar/Xa5HXpkj92t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BwZkJV8aTZIevwSfuoTqbcHVmvKfIpw+r4eMpAGwzgDjjg79yf6fOalstisRY7+fB
	 ZdLVFHbhpPw4v0OEZb/E1xdl9iCf2AaPsZ0HrUSFMsGboqc6CbxPK8wQI0NOChDIbQ
	 xerzq3168ZqUTE44eGeuDa2a9hvmBwqC6Xb2KgS3x+6DmL6vZTdW8fuU/MhE9+1aJ6
	 NM5g2F7yYKd5NyNpXXhrycEDZnQN93vaP4/eWq6RRHZ4fgowzDO8AXw95HMKwI2KDi
	 foVHJ5pS5QqdDMwskoWJ72pxHC9V9BpDKf/uVAIlGgSgWFKTAdhMRU9qc3KJof3dSW
	 3i8qqIbRxD6rw==
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
Subject: [PATCH AUTOSEL 6.6 72/83] um: line: always fill *error_out in setup_one_line()
Date: Wed, 31 Jul 2024 20:18:27 -0400
Message-ID: <20240801002107.3934037-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_172556_810757_9FAF69ED 
X-CRM114-Status: UNSURE (   9.48  )
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
index 375200e9aba9a..2ba4e0d4e26b0 100644
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


