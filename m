Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B602CD3423
	for <linux-um@archiver.kernel.org>; Sat,  2 May 2026 13:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z+W/yjquw37SF0By8PEAxaL4ODnBVGLJHUR6gmAC5nQ=; b=Hkd65MMndKZEb5Tl++P4poRH+I
	5QulzZ+bfF9bw700IadzRUh2sOplo41F5SzIs3B6qi7o00LDuvt9S0X5H9uYFyoRMtNac9MyeUeYW
	AFDqaiqOf3OGv/VBm+a2GGX0QWmGTPKx1m9K9Ys9iLptn28jU5n0UPVRDaW1GacZGOB0wIZ/T1uaI
	whV5xrd5ngQ6+YTg87RvMp7lMYnrbFWsA8T9T1Q9UYHTo+cK3pGuscnhVU5Z5wMKyISYW2m7s2W8N
	h4KQDBJMcuJlC8IDyYeN54ZMOMjlPWd1asKl31Yp9QBe5zEl2OgtVEcR3daaQhvObpBw3SG+XOJc8
	qSfziNzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJA67-0000000937E-1at5;
	Sat, 02 May 2026 13:09:31 +0000
Received: from xmbghk7.mail.qq.com ([43.163.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJA64-0000000936a-34ob
	for linux-um@lists.infradead.org;
	Sat, 02 May 2026 13:09:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777727366; bh=z+W/yjquw37SF0By8PEAxaL4ODnBVGLJHUR6gmAC5nQ=;
	h=From:To:Cc:Subject:Date;
	b=hPYYpV5vEenFbBfRh0aVD0aFYxIyuM7YBeu3VAI3IqNXO5pDg2cBzaUBYkXjueuQG
	 BnOHpt/IbdeErEYEtjvd+sl6uDOunzC7tT9lSkEjIr1mGtDVxbs9x1UpHqPH6XmZtw
	 y9ALlEMrfG6PJzgssAfWmW26pQoLo+nF9G1yTx8w=
Received: from Lang.smartont.net ([2409:8a44:2312:14e1:56d8:1e1e:3f0b:d0f3])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 25602278; Sat, 02 May 2026 21:09:22 +0800
X-QQ-mid: xmsmtpt1777727362tzookrlu4
Message-ID: <tencent_4146F4975C2BC4DC82A0655C1C24F1CDD308@qq.com>
X-QQ-XMAILINFO: MKUhwZFKNyqxSbeA+sASx3u1uYJ7AfytbBDGtganaIuYjwqDti/5ckMIxXeym7
	 8sdqF7pHHg9TWGeugy0okyBLfnh7c8mJoAXkqWKvYWdRmDPwQeDT9cvdzM6BpYe9yThJEIwHLds7
	 WWbNgAgJOl0hgcC4ZLI6B/co8tHst+8EF/KXUpE99y5/97FquhXeWvaIpGvsfJB9g/0bFzCm02xz
	 gY31eTvLSlBHsGU3qat7eMFfsMZaH7K1xFJQmcFbzbOzVvOJCsPVouTBWqgPy53ls/mGDofFNFsK
	 DNJVB/zQ8mEfVDPIWz5jcxhWT+Wyy9ilGQwZeleaIT6a5WHheKnYMNfMH9njBiuI1UxnLLNJoGA/
	 btYcvXQ7RPG+9Es3uy7d2zs8RzbUS30tqs+PzI0vzcV1eU3ddrNHr5JR0pIqAaDTS6K2fMunCYsh
	 dQ9DRp2TduPtWp+NaPmkZz1BEwzE+JWfCPbHW+fkQBa9CTOGOb+WX9swk/WbhnVIqjyUiDfDzjsR
	 gL5zI36TIN6/EbDQZ2AYyze7sCxUUxaeItZbZx7BK4aUigmKfYWmFrvB1VNeqH8wztEcJWwCBhSR
	 /2hnlzE5el1h1z7U0s1A1RsMserSIYTTQGzQMV9TX00FxBwZshRkjzMFcdp7RfmPrfSoRr8s1gvH
	 DHzIPJfkJzYhK8f2Rz23mj70QegQnyxXBWRx4vKuvC0COXhZpKuusycTqR2U7as4Bu7xaGXYnoUG
	 5M4ZmXfGSc6nS3lNuFy0zDqJmBMMbX5YUuYHSVTiDzeyS6LEFY40/EDIKrdOBYELro5o5ebo/rXo
	 Snuozx+V/MWqegHChTQu2fsr7Ru2gPN7pV8taRAQbjT4olYiSKCVukCLyxUeLZt2xXZvw2KMtU15
	 NKhemyomYS7WjR+p4XwJTlt+U1Tr/vVO/6VtQtPhL3HPtp6nyPOlWLhrx9/nQF5K8+Kbh0ksqf9a
	 aiFD6S9NcUeVT2mpNHzgeJa/SpMKCwO5EjQVBRWeElxARKr2G56LKtRhylJDY2khQBDVxRasTL1w
	 fkPfVHzMjOvdWKE/50grkVFVn2nvY7dgkBjRGJZb0NedWS8jspdosl+Xv/tM+JslbJ4jcgFZaPAC
	 PBJon0
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Wang Zihan <jiyu03@qq.com>
To: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-um@lists.infradead.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	corbet@lwn.net,
	mchehab@kernel.org,
	richard@nod.at,
	linux-kernel@vger.kernel.org,
	Wang Zihan <3772548978@qq.com>
Subject: [WITHDRAW] Documentation: Fix duplicated words - "in in" was not an error
Date: Sat,  2 May 2026 21:09:18 +0800
X-OQ-MSGID: <20260502130921.638440-1-jiyu03@qq.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260502_060929_083475_3D7731E5 
X-CRM114-Status: UNSURE (   4.99  )
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

From: Wang Zihan <3772548978@qq.com>

I apologize for another incorrect patch. After review by Björn Persson,
I realized that "in in" in switchdev.rst was not an error:

Original: "what position a port is in in the overall topology"

This is correct English:
- "what position a port is in" = the position that a port occupies
- "in the overall topology" = within the overall topology

My change incorrectly altered the meaning to suggest that a port IS a position,
when in fact a port is IN a position IN the topology.

I am withdrawing the "in in" part of this patch:
- Message-ID: <20260502111916.145238-1-3772548978@qq.com>

The other parts ("The the" -> "The" and "on on" -> "on") were also incorrect
as previously acknowledged.

Thank you for the correction. I will be more careful in analyzing English
grammar before submitting patches.

Apologies for the noise.

Wang Zihan


