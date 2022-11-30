Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D36DC4321E
	for <linux-um@archiver.kernel.org>; Wed, 30 Nov 2022 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hMC96Q9YRlnppT1kGra6Y225sZFqUrcp8DR0B0AyxQk=; b=yKAnAjSOsdkBJJ
	Wi7NyA7Z8Agka4viTncJmUSuN1ujTQp7+aZz4nEu7VETnOlalCTRIS6rKM3Rq8FZGryazdIl8Vy6P
	kvZnAVfZgRffnVLpuUdabIWlOIOhJ4lfW1JAfzViBVRCHEcA913fKn2sAEwczsSc4HrrYigu2ezN1
	109o/dnWNOpVDrjB9iLewQ0yhXxV6lfcRCfbZA+jPVBrVMnVzErfhy/2j3oE6Prto6UnQX54N86qQ
	gTx8MfFOa3W4I+uEqNP4roB3Np2SMXgLRCBx4maQNg1GVsG8WMVPXcX5xDqQCljHexeg+QFaxK5NB
	NyabotDNvUJUz1FWs2nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0Pkt-000MUO-2P; Wed, 30 Nov 2022 16:16:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0Pks-000MTa-1N; Wed, 30 Nov 2022 16:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=U1UGXTBuI5LcEIN1P/dpWOejfackW5xFI0KcjLxKSCI=; b=ZtRU2cro5RUk1ONUC7elbnZ/eM
	siye03T7Pw4SjTDd0piVWmIV8G9OwgjMtVeyuVvoYoO+NNby5wlzMoOZNFfMVlr3mjwqjWvjXGt4h
	VNABbDZkUS5ke0oznl1gp86o0QOTyWAR5/uMAkx9sZiDhZhIF8X9CD+c+TpwPhnJ+iSp304qdwYCn
	J+u1+AUccE1UX38xv3SKvxrpYakcWTuUbvJQt5utq8i8+130Agh7YIelTBiktQQMFnPVyusuKsxoB
	il8HXW/BdWG2gT7BxqaESwnnpNpCXRVp0Bv/iFDYL+01dLfy82J7XYwQrYLn0V7iW2c4Ff5Fqce4f
	44FAP1eg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0Pku-00F7o4-3j; Wed, 30 Nov 2022 16:16:16 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Miloslav Trmac <mitr@volny.cz>,
	linux-input@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH] input/misc: wistron_btns: disable on UML
Date: Wed, 30 Nov 2022 08:16:04 -0800
Message-Id: <20221130161604.1879-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
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

The wistron_btns driver calls rtc_cmos_read(), which isn't
available with UML builds, so disable this driver on UML.

Prevents this build error:

ld: drivers/input/misc/wistron_btns.o: in function `poll_bios':
wistron_btns.c:(.text+0x4be): undefined reference to `rtc_cmos_read'

Fixes: 0bbadafdc49d ("um: allow disabling NO_IOMEM") # v5.14+
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Miloslav Trmac <mitr@volny.cz>
Cc: linux-input@vger.kernel.org
Cc: linux-um@lists.infradead.org
---
 drivers/input/misc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -330,7 +330,7 @@ config INPUT_CPCAP_PWRBUTTON
 
 config INPUT_WISTRON_BTNS
 	tristate "x86 Wistron laptop button interface"
-	depends on X86_32
+	depends on X86_32 && !UML
 	select INPUT_SPARSEKMAP
 	select NEW_LEDS
 	select LEDS_CLASS

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
