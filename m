Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379A1C3DA64
	for <linux-um@archiver.kernel.org>; Thu,  1 Aug 2024 00:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GFIC7tmVN/CitJFKk0jv6DsYe9UZjb0QxzNdKldEhvI=; b=nTyXeYzH7qTPU9gczhcTZ+60MU
	+X+LqYrBasKaGdGweS9iWTTW49XnF2dwra80kcPQWGShqbMZSM4Bf2FuJsMpcvO6bBDsxKg5XV34t
	6vfJj1TNfDoMHvuUtvrUMF+vRiuqlSSadMSzB4XMts0aot5UUqH1SUHQ3q7e6BQ98R0B7VOROJs/+
	i/bnfBos2brXmkyHJUnzNbrNM74BDM/1JNLoz8PpV/uzzNZtosJGrHG3Vk/0gY81qsaSdzcO4nbka
	o3Mbd0ti9PTBwdhEILy7Y6E9jSCRUr+g6yGvKECzj+d2ZkqlsVDaasCXfmqwR1S+NpskEQWJCCgfi
	VVA1shsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJq7-000000033qg-3eIN;
	Thu, 01 Aug 2024 00:38:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZJq4-000000033oY-3XZI
	for linux-um@lists.infradead.org;
	Thu, 01 Aug 2024 00:38:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1707E6242B;
	Thu,  1 Aug 2024 00:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ED5C32786;
	Thu,  1 Aug 2024 00:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472719;
	bh=rqDUbOVXDFFtEVVtQDyq3JIl6HOKBMmf6+UCPAyyNfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EeQTXA+UwNMMGVNa1fE1EJq7gKEKuH8ohiYS4OX3bmeYprcJefDpovlekdC+EKPEP
	 Ffqw1v8HKFEGBVQ0E9sc1PdBe/XV7mZfwYi8UJywHufx2dCyD/g5MVbspOC2ktYdpG
	 DmjTEQEUe71tiF3gGdtdZ/E6E6Hr/rJUDRuGDKBzZpw1KFFEq63+VKf5meD5TE8pjK
	 V7SieAdNwB6G1HV4avM2vTPsNG1HvRl9ByMx9IPcolwtjfYOOd5WLsZ6wI0w41e+2d
	 XsC9zo/bbyxxeEzLFDSlePNbyjDsi3HdVuuNd/RSk9bhleIy4AYmGqY+DJ9V2vUdqM
	 eiiGBXDW1oToA==
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
	benjamin@sipsolutions.net,
	roberto.sassu@huawei.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 32/38] um: line: always fill *error_out in setup_one_line()
Date: Wed, 31 Jul 2024 20:35:38 -0400
Message-ID: <20240801003643.3938534-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_173840_969550_0E3D94E2 
X-CRM114-Status: UNSURE (   9.66  )
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
index 37e96ba0f5fb1..d2beb4a497a2a 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -378,6 +378,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			parse_chan_pair(NULL, line, n, opts, error_out);
 			err = 0;
 		}
+		*error_out = "configured as 'none'";
 	} else {
 		char *new = kstrdup(init, GFP_KERNEL);
 		if (!new) {
@@ -401,6 +402,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			}
 		}
 		if (err) {
+			*error_out = "failed to parse channel pair";
 			line->init_str = NULL;
 			line->valid = 0;
 			kfree(new);
-- 
2.43.0


