Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E6EC531CF
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AgdfRrRpoRaHmrJEKH0Gd9dP64PaN2dmXjM+iVKArhw=; b=ojRsT80abXhV/vaygmlTLODVl7
	uZ6JKhFEaJzQRPiWjYcFTmo1ZkiLmZLY+A1EE2HUo+kwn9azEDFBKGnBjTIAxpkziYr8m1KVB3VZi
	JA45J1JBHSuHQzBN5u0agyvmdaxoYtoXJwyIZxK+1RIgoPleb7mt/csRL4A5vYgnQQwb5BrSsV+HO
	fd0IIppMpvfqBx6lZQLXJfHY2/dS7A9pMMO8fX7xIcoyJnTFYvPpWfwjl5FbR5CielEI2PICMGdY+
	r73Z8/y+l7zPaFEZo7LO7GarI9S/Zo2TfiemWDbDKPBVcrcBo5pDvq9ugDaVr+1N2bYhkQ4/ecHgQ
	Yqy+Bmtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmprA-0000000DrpS-47Pv;
	Thu, 23 Jul 2026 09:36:44 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmpr6-0000000DrkN-2Ku0
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 09:36:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=AgdfRrRpoRaHmrJEKH0Gd9dP64PaN2dmXjM+iVKArhw=; t=1784799400; x=1786009000; 
	b=rHq8lg/70puuJxOQxQfwewNpCH3ko6IdAdL37yQRgnU3JbabNKqOOqZSbIXbtvK26vYEqMMfZVP
	im/K+gwmexv/QEc3O/oqIH15klWyZhm2TWeFs9XyF0wliiEh1ufOCJlcmHxj8SFFfazEteA7Putsf
	EEAhcwRC7ktPpjDqsWx2nb+AAgx1j2/bSvmMFO2GM+eoxTAxGQgAzRcGjuT9DqVRFb2n2YWa4HC9G
	uixl82LTq96rMmWJQLcNp4tEad+lk0TvXVqloOcwi3lndh13y4r8BBjgRyol9IoPRCOeNaI2P1kqw
	+/t84NgKX20YZePtYfz8Sy0VASuGIZTgaD7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmpr2-0000000Aeqq-03tY;
	Thu, 23 Jul 2026 11:36:36 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>,
	liam@infradead.org,
	ljs@kernel.org,
	Ricardo Koller <ricarkol@google.com>
Subject: [PATCH v2 00/10] simplified UML/NOMMU approach
Date: Thu, 23 Jul 2026 11:35:41 +0200
Message-ID: <20260723093633.140989-12-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_023640_657030_F4D95F4B 
X-CRM114-Status: UNSURE (   3.26  )
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

Prior RFC/v1 was here:
https://lore.kernel.org/linux-um/20260720185103.530603-11-johannes@sipsolutions.net/

I cleaned up and added the docs commit now, other changes:
 - fixed futex implementation after discussions
 - fixed regression in earlier uname change

johannes


