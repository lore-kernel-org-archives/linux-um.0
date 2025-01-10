Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF35C02183
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 13:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QH8mbQVExXZoipf/fdX286AUcuRmZMtNOzYrG1fTkZk=; b=tC7WwMU5xMKGKRqh+WXWcJBQwR
	XZWhJkZ3MCLnUu7BcKKsivBeNIrTqj+TCKe3Wjrno1ncVsB66DaUHQTGfGt9HAQCpwgvb1Bn9oZmn
	P/7/o0YS5DjAUxy+qU3NYB8r7nEJreVLx611uRS7840Zrpqe37jdwR6+iCM8H2i/OzKwp16FrxS+Y
	pD7Baxf6YhtQvLB7TNE5BJlhkjPtDSupqG7lUtycbBXS7BhD463+cysF0TF/6NHK7zgs0GsbRZryA
	CDj8i0DdgiP0xwhbmGdT8LjlbOhLn+mpk+OHnigrHy3KUK7EZ1IEO3DooNsige+mBfyIqpCezBJxu
	u8bJAfDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWEpn-0000000FQgZ-1Ggs;
	Fri, 10 Jan 2025 13:13:55 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWEYQ-0000000FMiv-2a1B
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 12:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=QH8mbQVExXZoipf/fdX286AUcuRmZMtNOzYrG1fTkZk=; t=1736513756; x=1737723356; 
	b=T3Lt3YXWG+PsLSuYPNVOfIclEKML7yQ8p5dT3lpauskz+80uCt93cz/pgGQqrZtYxivsoS18r3M
	ZUuU/kAEoBP2SE9YsYE7PzJHTYm4ixjGGBsR/0A4sh7QJXlzHEPTNcjtHl5c6UUx0q3VQSn7XHeZS
	Prgqd1STxQUUX3oleap7HuF65Gn+fpfR/mDtctcbCFeOqgebHiRjMJTxNGxcn7QKlUcuoUzpSQupE
	cD9gWYRhRhIoEgFxnwKcJLqiUyq5AeZ9FID+vQegEjBu4FK9IuU+qhesWNqnlDjzYe1aqGtmTzUvQ
	3/uTz1iS5dNDki8AO72t2mpTEAGI8dxNXHcg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tWEYL-0000000Aaru-1LtJ
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 13:55:53 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Subject: [PATCH 0/3] um: irq locking fixes
Date: Fri, 10 Jan 2025 13:54:03 +0100
Message-ID: <20250110125550.32479-5-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_045558_666462_DCA9760F 
X-CRM114-Status: UNSURE (   3.84  )
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

Some locks changed to be raw, and we now need to also
do that across UML.

johannes


