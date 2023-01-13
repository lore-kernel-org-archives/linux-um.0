Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2498BC54EBD
	for <linux-um@archiver.kernel.org>; Fri, 13 Jan 2023 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=e+hzXAJMyex1CQH+tAizuqUlzxTnuTM8RNWISdDnNhM=; b=GfhMM64AXQRYvI
	dRzlp4HLpyrjujFTBXXRx8P0iY5Fw3LDA1GnHcJCFrNV1gyhcN2LaZ2ucYCgBfEyHtC75eU9P2Ck+
	/2XxLMBI8W7+PXpnHmiK7wmbcbnVdhwW+ne58o6TjC2g2pwlH9HSJLMUkzbX96NI+jiNrGhbsnF/o
	gIFD4o/lt24f1iRz2NB32xi+hiC2eDGR8jVFkeQ6Eq0jphtm7QCjIm1LeDT3hjZHl7NnuXGkSq/PH
	h2no9lmO8L1SMvw7Lkb8NGpkz1OvLrLg6MVSIX8wKApJ0jHzLeMvawqhiBCP3TZJ0d6IPf9J7EM2I
	cNEmsYOprcSHFpVbONww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGNLp-003XM2-0H; Fri, 13 Jan 2023 16:56:21 +0000
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGNLm-003XL4-GW
	for linux-um@lists.infradead.org; Fri, 13 Jan 2023 16:56:19 +0000
Received: by mail-vs1-xe35.google.com with SMTP id k6so13898603vsk.1
        for <linux-um@lists.infradead.org>; Fri, 13 Jan 2023 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TOZ2XXqS0p7ft3IrzNrVta3tYhszOavdjeGJQ4dCn8k=;
        b=MBOddXeYiZqcidLAeKir46cRJsI/dSEbGP+R7EM2jqabnjoLy6eWPZQ8R3KDN2unkC
         YknhoVm0yuTpp1gYD3640UlKsC6F1dKMvORGg0IepWdBvNkb7M4YvmCHOYYg2o12p/5C
         nYQfznuYAuoEzciyKdMlW9RcIlG2+049Gl4kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOZ2XXqS0p7ft3IrzNrVta3tYhszOavdjeGJQ4dCn8k=;
        b=iMEno+oKN2J6bKkhgC9Y3tMlpNCJGL2AKJkyaXe2ANwj6Sz8gOq/5AzZ79NnASNpji
         WHGqgNHe3Ae98r9lIErbmMDVEZk8jlcMRxbvIdhEK7OUXqBO96rOe/zh+aMGS5yCAQss
         CAR5BubYQas6SPiDdp+rGcCwcB0kJ95ope0wsxbwIzXBXgcPUWFxVZV4vJNRR+2dnnT2
         wVZ6aIOZ2QMpTAnatu+FAJuM/e+yv9B0cAFZhnjJgDbROgwMeoiO4b7EMljcWWKCKTr1
         Wjr/rekDqYHFFb3EhbcG8tQwN4J3JlG8vuDGvJUBgUNYfFytoYQTFSDrBv76sDg+xgB/
         Wh3A==
X-Gm-Message-State: AFqh2krohlJGnL3ykYxlYsX+TFFomxu0y618MsLE9cS697GCj5nN8fiA
	qx9JWzyGG7NIho2jvfPh1pg5GQ==
X-Google-Smtp-Source: AMrXdXtA4jJhbap9Mesgi8AFhu+BzYgf1NF+0+LILeIyGvLezURePTUOrnBbv4PeaVdpL8R78SDOMA==
X-Received: by 2002:a05:6102:510e:b0:3d0:dafe:9e57 with SMTP id bm14-20020a056102510e00b003d0dafe9e57mr9244569vsb.26.1673628975033;
        Fri, 13 Jan 2023 08:56:15 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id bq35-20020a05620a46a300b00704c9015e68sm13018930qkb.116.2023.01.13.08.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:56:14 -0800 (PST)
From: Peter Foley <pefoley2@pefoley.com>
Date: Fri, 13 Jan 2023 11:56:11 -0500
Subject: [PATCH] um: put power options in a menu
MIME-Version: 1.0
Message-Id: <20230113-umpower-v1-1-faa1459f7ab3@pefoley.com>
X-B4-Tracking: v=1; b=H4sIACuNwWMC/x2NywqDQAwAf0VydmEf2oe/Ij3EbVpzcJVEqyD+u
 2uPwwzMDkrCpNAUOwj9WHlMGVxZQOwxfcnwOzN464N1LphlmMaVxIS7jZV/1E+81ZDrDpVMJ5hi
 f/UD6kxyiUnow9t/0b6O4wR7aiR2cgAAAA==
To: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673628974; l=663;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=gLu5+b7mdNXFx8A5ZK+VNsmqzaiQBj+qX4NXuo5RyRE=;
 b=qBQxQSZ3UYV8DOtEChK0c5gvyxQKmXVdcCWG+2ylzNq1O2S4pN9rRXq8UEdHHrJw+wXh2Ojg7LS+
 XDKm421CBIcXLzu6aX9ISdvvt61jR0H8BODLTABtkLWhQ83/dwJ+
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230113_085618_670516_A294BA15 
X-CRM114-Status: UNSURE (   6.95  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Because having them all dumped at top-level is a bit messy.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 arch/um/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index ad4ff3b0e91e..65bc4c5f2e64 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -242,4 +242,8 @@ source "arch/um/drivers/Kconfig"
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
+menu "Power management options"
+
 source "kernel/power/Kconfig"
+
+endmenu

---
base-commit: d9fc1511728c15df49ff18e49a494d00f78b7cd4
change-id: 20230113-umpower-370c42859a65

Best regards,
-- 
Peter Foley <pefoley2@pefoley.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
