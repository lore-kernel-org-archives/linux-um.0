Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E7FCD11DD
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 09:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mYTYdP3mOgcsMusGGChd6ekEbeBpCSRv5NcGhhE2fko=; b=slV48bxk24V2Dd2Bt7+MpoOYUO
	EaAMkPhkkSAHzDphCZPF8rmNU3MfLnQ/sLY38vOuybj3OJgjjUXYgNCPWsdclcWZ91K9FBms3gySt
	HEG5yF7fyBrtv4WpmytTE+VEX5P1uIEr4Hv+a5k29j2yKAVKrJ/I9DG85WOEDTaEcNtCKqiHD3kXi
	CrwbvOxOEX4CAIzeErO0tpH2Pf+DYXul2rLA7TRrTD5B3zwYxzAu5t/uK+pimSVZgiKlHkjdzlGBI
	3QyorMV2/ODpcW8mfJoM7a64okTNXVI+ByjdAXTBiIfvPEEBVftlCaOfW5Qk02i3GP7aX9U/AFn1E
	IguV89bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplnV-0000000DFWR-3WiP;
	Thu, 28 Mar 2024 09:11:45 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplnS-0000000DFUS-1P40
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 09:11:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mYTYdP3mOgcsMusGGChd6ekEbeBpCSRv5NcGhhE2fko=;
	t=1711617102; x=1712826702; b=YZNRTvnJsAtXdT6mvDhGpZ5hIgtiwqe+6bWVPmntq2RygzT
	s5AYyTzTAG0M2nCwp74zcRN1opeJhaqvtNZ1yH4XKOs7/+5ObvrpI+VkoLdK4mFjnY3ks1tSkafeG
	/yHI4ALWnXESy/zZ++cQIZz+qFZAZ71GvqnHa7N8ZQOwYGe7gSnycgnKr8q+OzBMwMqYLURRlJzsr
	no7THFMupTvTcu8xQG9qMY4WpGpIFv4P5HGMOGCRO/gPKIsSSjEgsHSmnS5jgrhatch8Ia+r04fWe
	btW2B0S3GwEpGHfUAdtJuAl06eaKjbsrzYo9+XrTiB7yc+h46KG4bIuW0Y1XPiRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rplnQ-00000000oe8-0j5c;
	Thu, 28 Mar 2024 10:11:40 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/5] um: vector: fix bpfflash parameter evaluation
Date: Thu, 28 Mar 2024 10:06:36 +0100
Message-ID: <20240328100640.1fe2aa1ac586.I9225b571409fd75485cacf2d9542efc630e997e9@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328100640.d3ffb37dc64b.I2e2e713d6a78ea24e6508db9d3ef2882b88861da@changeid>
References: <20240328100640.d3ffb37dc64b.I2e2e713d6a78ea24e6508db9d3ef2882b88861da@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_021142_434606_498E528C 
X-CRM114-Status: UNSURE (   9.46  )
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

With W=1 the build complains about a pointer compared to
zero, clearly the result should've been compared.

Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/vector_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index dc2feae789cb..63e5f108a6b9 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -141,7 +141,7 @@ static bool get_bpf_flash(struct arglist *def)
 
 	if (allow != NULL) {
 		if (kstrtoul(allow, 10, &result) == 0)
-			return (allow > 0);
+			return result > 0;
 	}
 	return false;
 }
-- 
2.44.0


