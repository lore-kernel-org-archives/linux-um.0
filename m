Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71660C3DA64
	for <linux-um@archiver.kernel.org>; Thu,  1 Aug 2024 00:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=81TmlVsQT8AHJJUrZ6fvZaJI0YO+DqBGAyMeyVkWqcM=; b=fMYS2zfpmAPw7K9jSb/2G0/16U
	1N0kX6yNn7YGMzVJocNhuJrAxnrc+DOR0+DgIVDzkxPk2mLvnIQdf6etx6wov7stVgKSqN3IfBppI
	x7ZnpTC01Tj5pAPk4QcQHqzDr9EFrUjX2lBZC2mZj6B2+lPWf/x1hDlZr/dlHbS65kvJKglw8qd9N
	5ydte6wuU2nvNNIam0dvn7c3fiog/LeWhwimAcbCjNU5c6NqR3x7gAtrZzvN5p199wMFdqra+OSJJ
	EzxWa+Jsluc6GCZLHWIb0yaDkXX3CWlVRLfGmbpkW60HnFt5/EkTotDJ08mqRY2ougsqidaNcmzLA
	8ibXnhtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJn1-000000032qF-0HEd;
	Thu, 01 Aug 2024 00:35:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJmy-000000032oY-0w0B
	for linux-um@lists.infradead.org;
	Thu, 01 Aug 2024 00:35:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 90EA26173E;
	Thu,  1 Aug 2024 00:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07698C4AF0F;
	Thu,  1 Aug 2024 00:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472527;
	bh=uP4TlehPy0hVgRkfWi8usR0oWixCZMo03YZrwSkKnko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cE+z+1tW6Zghv39FLJUoqQHJNs6yd1U4A3pUEtppzKOq6k63O8cp0rzWGlxo6ytut
	 BnDMlQ94zZvV3NwrOvbps11+Ui/CdWKOERmwyOeGlpasT9guYAXVQBlT3QGNN5LK3Y
	 Xyzp+qk9jnXJGlZ2GkP8YcUWbnaLZqPacbaEmcZlW44vP+91pUEYBfbnAztfm/G1ac
	 WoYZEj7y72uF2wGiZqL1ZfTg5fzz/V8UbIkXR8xxgVdg6iBYTok736+ilBPbd338RK
	 hogjX0QGEvWnNPpkmxY5UdONAhjIDpc2FYXYgEGTEDvU3u4XwdlLxafr+t3qiWl2Es
	 h28hq9R4aZaxg==
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
Subject: [PATCH AUTOSEL 5.15 40/47] um: line: always fill *error_out in setup_one_line()
Date: Wed, 31 Jul 2024 20:31:30 -0400
Message-ID: <20240801003256.3937416-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_173528_316611_48D308C0 
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


