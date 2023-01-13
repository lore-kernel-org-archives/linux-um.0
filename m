Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F0FC678D4
	for <linux-um@archiver.kernel.org>; Fri, 13 Jan 2023 04:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PjoUksG+DJ+T5sdAXVLgenmO6crBDwCbzEpHXA3rofQ=; b=eqesMNpNrumv6j
	Qc45ghLzuUk/wV9vdosFxc9KsgnFmJs3TaLsKW6tNi0SIKfjdYGZ42ZFFlcxLtqyV46939MqXKTBj
	mewWont23ru6FkKTV/mcCh/F2sK1DB/6t4u74m0UZ2LNFb7956PDzDdglkpi3RBBflORwE7Vs1mQ1
	2v/6xCWBUQ0YtGfPIY+IamDTN/JMcodQgQuiVYPiDExgOpIsE2jiY/ctPr5JGuNMeX4bPD3cmQvPU
	RhkcdE/LeicteUn1qCxIuZO1GDnE5GpdFRyuQ+D3dJKSISCdAs4Rkhw0kkA23xJ+RjSJOeg7KGjjo
	y/W9cix8wHayiYuqsdSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGC0J-000RNZ-Sy; Fri, 13 Jan 2023 04:49:23 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGC0E-000RLI-Sg
	for linux-um@lists.infradead.org; Fri, 13 Jan 2023 04:49:21 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id qb7so14149671qvb.5
        for <linux-um@lists.infradead.org>; Thu, 12 Jan 2023 20:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RK7kwtLoTwXiQFYRKLpCqcerUjpCY+ogtPq7BCj8+Hc=;
        b=qIlrOw+9p5xPgPCq1YNGHwqIEgQIf/DgPOyvmzsar4YJ9G5sfVEvxYZKfHNF4TQlXi
         jWiFvLk1mUXDR7jV+h6izxD02BdDrxm3+JykT+7Mhvl6Wo9cwfp1LSd2RkT34oA/GtpR
         IQbRWWBtBLVpDj2uVEac5zh4zg2u2X3i/XBLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RK7kwtLoTwXiQFYRKLpCqcerUjpCY+ogtPq7BCj8+Hc=;
        b=hIkLJ6ojWpSGNi10ZDEavLhnOuNXwJ+eO1D1WOY+rsF8Nqfd08qyGoXubzlyQOLoQn
         IJD/nuysfnIW5cmUgCzrdSHiPsXBSOj9Qb2N+shKhmg+8oVFcgI2d83ZZVqsCIuMPbi8
         xX7Gn05N05ETHOvmRR7Ah3C2VVWRfE78rfDhYC9DXm2U/+scPUi8+hNpGbxf8uiGwdhi
         gttdGsJfxvU7n34rOAK9rEh62q/C2vQ9RiRlvrA08eskG29ScgX7+8RfdI/+tIIVQuOF
         6cklPW9CTn/JFxq2GYGZ9n/JBV3YyvVirKMc+zuzExEsX7Ygon+JHhIblAhVxzyIRnMO
         ek8w==
X-Gm-Message-State: AFqh2koVjsrnOUa+xP9P1zKMhFRJGPtbCiFtSGbuYMSqlJs4PnRzzIJ+
	2BhYlZCSkqBGw/IzHwZGtoNp0A==
X-Google-Smtp-Source: AMrXdXvhcCBymtegmA0hJJTKnIFA4a0V7g7Xo1HJuf4+3ZsSmCtYNvt3OYiufYaE9/3b9c4dUtNBWQ==
X-Received: by 2002:a05:6214:5811:b0:532:2daa:eb0b with SMTP id mk17-20020a056214581100b005322daaeb0bmr24788992qvb.41.1673585356388;
        Thu, 12 Jan 2023 20:49:16 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b00704a9942708sm12099472qki.73.2023.01.12.20.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:49:16 -0800 (PST)
From: Peter Foley <pefoley2@pefoley.com>
Date: Thu, 12 Jan 2023 23:49:09 -0500
Subject:  [PATCH 3/4] um: Prevent building modules incompatible with MODVERSIONS
MIME-Version: 1.0
Message-Id: <20230112-um-v1-3-6bec9e97ad13@pefoley.com>
References: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
In-Reply-To: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
To: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673585354; l=1046;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=FK3QdJgb2KG4YuegWgxOs5tSOgx0C0ibecAQpmjyv/4=;
 b=IGNaz9VC2rw8NP2KkkaEAY4fe7KpAqDmWHvDImkLzXWrJl+aSMWsOUVNlSoMzxdCgVnz5Ydz8wb3
 0g4oXSsQAU8n9zrUnEZHnK3Wm14IJuXioSKD8EoQjn0crlRzH+Pu
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_204918_951899_BD1FF758 
X-CRM114-Status: UNSURE (   9.36  )
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

The manual ld invocation in arch/um/drivers doesn't play nicely with
genksyms. Given the problematic modules are deprecated anyway, just
prevent building them when using MODVERSIONS.

e.g.
MODPOST Module.symvers
arch/um/drivers/.pcap.o.cmd: No such file or directory
---
 arch/um/drivers/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index a4f0a19fbe14..36911b1fddcf 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -261,6 +261,7 @@ config UML_NET_VECTOR
 config UML_NET_VDE
 	bool "VDE transport (obsolete)"
 	depends on UML_NET
+	depends on !MODVERSIONS
 	select MAY_HAVE_RUNTIME_DEPS
 	help
 	  This User-Mode Linux network transport allows one or more running
@@ -309,6 +310,7 @@ config UML_NET_MCAST
 config UML_NET_PCAP
 	bool "pcap transport (obsolete)"
 	depends on UML_NET
+	depends on !MODVERSIONS
 	select MAY_HAVE_RUNTIME_DEPS
 	help
 	  The pcap transport makes a pcap packet stream on the host look

-- 
2.39.0

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
