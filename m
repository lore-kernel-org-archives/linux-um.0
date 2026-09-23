Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDEAC98304
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PmKYWUrhpHEpqcz4PbP7ld4iy2zHrXZGlRyQ2gAi3ds=; b=Cd6xNQ707y1ZKSyVr1ToAunQy7
	YfkL659BRI/NE+nj/vQboeFUuNbs7x20jQuTARqxTc0eMpzpvAEcGubT1xoFcsTNM7Qd+l6ZFGG12
	oPHtsLVZVe+/UMr8A3GOoah/5TNldxEDeAuJT7mLKQqlgf7jlFja4+eE6eh44pungW5+UPOAT8Fkm
	2IgF8L6aSpgzxjQar7iDSByAUpYz7Ce2uCEB9OgpwD8dejP+ojSQjphRyVzeKFcLhyzh61vXsvzhN
	esM1na6PmV/esoEL3gZxuKARuwV+NAiQMlbsJtpvRUQ5kdEg9oO9yyB4iMx4QgwO9qE7JoydFTl66
	xE+FyUtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9P0S-00000008kr7-24JM;
	Wed, 23 Sep 2026 15:35:36 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9P0O-00000008koY-3n8l
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 15:35:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=PmKYWUrhpHEpqcz4PbP7ld4iy2zHrXZGlRyQ2gAi3ds=; t=1790177732; x=1791387332; 
	b=Cs0GGlNJtrlHlMuqO5dzlF7CotW3wZyRUlu8TnYMBCG/2du45xozDX6+fw62ByM0ZwPl/VLDAD/
	KVFSlB15CLD7yFOsnGKGjF3JqqjIpAVEDa5ppdqMzShZMvwvHy2ZAEkJZNNMgKee5pFE75znpDp7+
	nSvEpOjsRTBlk0g5kKi39SL/8P6xog9xs728R8ZKTRB+SSu3/9neiQodOUlAS6OhG5JwHk0vtU/Bs
	XyXUeGRLJ8qXeCLU1o3RYzz61GcDFyF4qsi10NQ+wiu7tH7T9pLzrdvVR3/yre1rAm4Pm9h6xCJcB
	552xZ2ytQeBlPWLo3NYJl2tAQER80UqsrhIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9P0J-000000083zz-0CK3
	for linux-um@lists.infradead.org;
	Wed, 23 Sep 2026 17:35:27 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Subject: [PATCH 0/3] um: clang fixes
Date: Wed, 23 Sep 2026 17:34:29 +0200
Message-ID: <20260923153523.987904-5-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_083533_243301_138B0D72 
X-CRM114-Status: UNSURE (   4.35  )
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

Yesterday I tried to get things working with clang 23, and it
didn't really work fully, so I ended up fixing a few things.

johannes



