Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E42D11101
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+8dNUQeOSj7dzNA60rbFfA8cZI2mNnDyBxeMcHAwRUo=; b=3gY657e5G3/VumotEpAIN6zbcu
	j/qBiASczi8AHBNX5z8LsTTTaxgHf3ZvPHWuU572pCMeD+sXlyKAJ/vcpxx9iboPrvZXu0+gDFKAf
	ndfBGJJka4Z/ICCp4lg0khEv0m9LNZOgpWnYqeoU/vy+mmpSEMsFzOv1djD3O5K8sFStv/CPgxVjX
	j6FVMTtRDqcdWI0E56M5KoZJduDhKpxjmfKTSaXSkbN+qUvWf4Un3zvO/nb9UVt+dHUWNHrG2nghZ
	4LEz7M2x4RI6RSkGD06ErOrQV9gsZi6uRvKgmN7KU0ncR7W8DejEZfWQtkplViyqST1UXdi+ehDJH
	XkW0Khew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7cAS-0000000BbUT-2fGa;
	Sun, 03 Nov 2024 15:05:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7cAQ-0000000BbTi-2qR1
	for linux-um@bombadil.infradead.org;
	Sun, 03 Nov 2024 15:05:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+8dNUQeOSj7dzNA60rbFfA8cZI2mNnDyBxeMcHAwRUo=; b=Aj2/spgvoSmA5sZnXHyndH0eqd
	YMeW+Jc0flxLymXokcVwg382qEOKbwJc/NbjiPH1TaJnDPqpwqxqweRtr3sflgIOTmRIxtYwoVeKf
	dYo/2m1gvDFdtG3smIZciHM4FPS67Ck8FzgLXd45ckUZ0Y+1DnTz/6g+2qMGl96h69PBChOOLJ7ck
	WzHk4EHmRwnVrGvECSobjyPrXjW7Igz1RqNsBDf7iIgj9IMeqNLMDDH6N+sQ644Zvpz0TzZAdwzQX
	+JWYgNZAkz7gUnvrGrHzZC7Ex9GlTR+nYFfdpy7CE9684Ld94s8+bcrunuegREq+gaq+OWQGUzPru
	hX8p9uKQ==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7cAN-0000000B8fw-1VPo
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 15:05:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+8dNUQeOSj7dzNA60rbFfA8cZI2mNnDyBxeMcHAwRUo=;
	t=1730646323; x=1731855923; b=oTAhTI9hebz1WBC0256EXA9iDBzH4E2eVRs1dgEjzyBgk14
	KIXljEGJ5SwbN8jlENaTyhNvLkjAU34fkTKjKjq8kmZJ6LKEak+0ejh5enUdmZctY+tnDAtfw3tcP
	NKi8AAzRDLVoKy8pUNi9sMCis5uGRbbTxqTy8H+gB3jzM4Mof9KAoaUxU9dYYFIJmOjIF0E2GztBm
	7dVvKU1E9T/RI9LZM0HGjEWgxHa+c27U68Soe7zyG4tTkI6Kb2B9swMSJY8FHEkLf9E+ToWa3ImV3
	jFUH4b7js80KxYIuopQHsK97zodGItMJi1S76rFCxrlOABy1VrEOnF6d5oKX1j9w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7cAL-0000000D5NG-3qjV;
	Sun, 03 Nov 2024 16:05:22 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 4/5] um: remove duplicate UM_NSEC_PER_SEC definition
Date: Sun,  3 Nov 2024 16:05:05 +0100
Message-ID: <20241103150506.1367695-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103150506.1367695-1-benjamin@sipsolutions.net>
References: <20241103150506.1367695-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_150523_732808_FCFA85CB 
X-CRM114-Status: UNSURE (   7.11  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

Just remove the first entry as there is a second later on.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/shared/common-offsets.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 1d00fc6b6e92..73f3a4792ed8 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -6,7 +6,6 @@ DEFINE(KERNEL_MADV_REMOVE, MADV_REMOVE);
 DEFINE(UM_KERN_PAGE_SIZE, PAGE_SIZE);
 DEFINE(UM_KERN_PAGE_MASK, PAGE_MASK);
 DEFINE(UM_KERN_PAGE_SHIFT, PAGE_SHIFT);
-DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
 
 DEFINE(UM_GFP_KERNEL, GFP_KERNEL);
 DEFINE(UM_GFP_ATOMIC, GFP_ATOMIC);
-- 
2.47.0


