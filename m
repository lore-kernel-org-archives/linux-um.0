Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CCAC79FB6
	for <linux-um@archiver.kernel.org>; Wed,  9 Sep 2026 14:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=T8h/MeAVXy5CPTjg2CpsfFB5ilTJUszKTSM5Irdm990=; b=zDsB+L9sZ2r8F9xmaREm3VYdO3
	Dw8imjDqqZ/Q+5v0e9SddRso3+wn71gNcFNTp1ZlwICCGRmh4ZBC3XJ7yTPcWzcJ+tV0HBtDzbpv/
	T43AeSwnU10q6Dlbr/YdMsMt3oBvkEdF2cykMksdMeAZsq5ErsD3mOa7H2eLJycTecs+hX1RpcjcS
	o3XMfgCLg8d3MyJt2fxcujZ2HepOcyAX1L5/Va8crNkO2Tnxlrr70DbpJZ6keLqpx1uWLzK0QdxCS
	yRswBP7unCR0nztfiQhRBix75RCPM/8dqAn/i3KnBHpdBUEnbfeUk909ZxyEM8ER85vCn6syHY5sv
	flREB3Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Is6-0000000Bs0m-3Gqk;
	Wed, 09 Sep 2026 14:01:54 +0000
Received: from mout-p-101.mailbox.org ([80.241.56.151])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Irz-0000000Brx8-3EBH
	for linux-um@lists.infradead.org;
	Wed, 09 Sep 2026 14:01:52 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hg2Y32PlJz8tyG;
	Wed, 09 Sep 2026 16:01:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788962503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T8h/MeAVXy5CPTjg2CpsfFB5ilTJUszKTSM5Irdm990=;
	b=EYtbLRQHkVXmZypw+yYVTlurxjwMrC7b2un7AHOH1bMGlZ+sw7aRwkuFWKaD+prU43v/nT
	y4CCX6knMAyJRt8SY3J/r8M6Eu7EQralnVVAuy0qJja4hkPfmcSjfB0UP0tqAmiqttnLBl
	mZBQBtb9RE9NdQ4+YYEzFGryiDtv0EURTAWpxUjOFfZJURkL79IZfMGkNThnXLq4LFTpc8
	8ZJB5Sd5yPsQY+mf72Zjhk943s+vVPXHPtsmkhId97Dk1zhfDRy3tde9Y8Yahk+RxNcFK+
	hOh+VRS0EoVFyiLx0syF4oK6ES6Tmo4Wq51eobIkZX6SAe3DkrjcWIP5pDWc3A==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788962501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T8h/MeAVXy5CPTjg2CpsfFB5ilTJUszKTSM5Irdm990=;
	b=mD2ckWMlRMxNgP4SZ+W6ZIEM/1jlUyhph+qQ3ahFrZQ5AwzHjQENuZZ35EDhufv6fRZsum
	xvk2IDxvNQZtWKq6Q9eNJ9J/FuLKG286AYeYiOPzTuqBNwt90CSz6kg0UHPTPehjeTX5OB
	J5s9llH26PvB5ppRvFVt090RxUsD1o9+eJUiLD+O/nAm7g3/LuMxIWatYKxUo2/NSDgARb
	UKheCVBV3g56AwKpX7RUJ2+vltYYKnPP+IHDgm3WlBY1g5C3t4LiR1tsWCJGXw58UDETz0
	fpMnuIPqFMC/kfyB1O5LJEYV/iSOTThLQPpYOOV4Bch6ZGIHoKCnA2MmMYoKUw==
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-um@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: UML: user_mode_linux_howto_v2: Fix bracket
Date: Wed,  9 Sep 2026 16:00:50 +0200
Message-ID: <20260909140051.1365758-2-manuelebnerli@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8ah7dt5ei3ykct7czue5for3cmi9kw6a
X-MBO-RS-ID: d9c2cc3d4cfab22ef5c
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_070147_964133_79A56CCA 
X-CRM114-Status: UNSURE (   8.25  )
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

Add missing ')'.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index 9224bea5e..13acac1c1 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -580,7 +580,7 @@ https://github.com/virtualsquare/sshlirp
    ``vec0:transport=vde,vnl=vxvde://234.0.0.1``
 
 connect to a local area cloud (all the UML nodes using the same
-multicast address running on hosts in the same multicast domain (LAN)
+multicast address) running on hosts in the same multicast domain (LAN)
 will be automagically connected together to a virtual LAN.
 
 ***********
-- 
2.54.0


