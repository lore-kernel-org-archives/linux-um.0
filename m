Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B29D690E9
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 08:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Pyc4+wPfuBY0lZgyOeMsCQ3UXLP3QpZA+8AYCYwtR7o=; b=0jniUeE1rq7+G2dL7DJuQcJXVr
	8LxtBG+HW7gy2QxuIq3jpO4pPjsAXsxCY0u3AbQrkhur8sMRubZT+slb9LM6oZtg8bj7z1FVSJ2g2
	szNHg4UKUJMRnVIwuGcXmJsBUdyqpNvm3hk+Fqs2nK/lpmVRUSfIpYUGchQVOIv7Fnm6SwnSkLNDW
	og25JlWEe+CBjqE0sBQ+tTpO2Wz4nJIUhvK78Jt27rRl53v0x8gcskNMelHZW0RFpmTeF1jdXOkIc
	eSC7mBI0IZy1w82FuMHD++iSn+e2RBxorU0Dy6Z1eY5Res+VkZbo2YHe2dAXsN4v7/0xqZMLAuKoQ
	eKiNSGtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZlV-0000000EyXE-2mVf;
	Thu, 28 Nov 2024 08:20:45 +0000
Received: from out0-212.mail.aliyun.com ([140.205.0.212])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZkg-0000000EyIB-00wG
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 08:19:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1732781988; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Pyc4+wPfuBY0lZgyOeMsCQ3UXLP3QpZA+8AYCYwtR7o=;
	b=iakY2SWuc+q2TGgI4mjziD7/kElyYj6ISAUM7ia+/wbVxSy1f+One27Q7DCguEGBHYV06t0pIll89uvDRESFl76O7BZo5m41rCiJ3T+GZu62dF748SmNYO1S7yQg0Kon+Qz8MscosHGjef+yy+BxaoP+U+8Xy8QT/vSRcoixVmc=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.aP-8fjx_1732781982 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 16:19:47 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/3] um: Some mem cleanups
Date: Thu, 28 Nov 2024 16:19:36 +0800
Message-Id: <20241128081939.2216246-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_001954_543892_14B1EF52 
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

Tiwei Bie (3):
  um: Remove unused MODULES_LEN macro
  um: Remove obsolete fixmap support
  um: Count iomem_size only once in physmem calculation

 arch/um/include/asm/fixmap.h  | 56 -----------------------------------
 arch/um/include/asm/pgtable.h |  6 +---
 arch/um/kernel/mem.c          | 15 +++-------
 arch/um/kernel/um_arch.c      |  5 ++--
 4 files changed, 7 insertions(+), 75 deletions(-)
 delete mode 100644 arch/um/include/asm/fixmap.h

-- 
2.34.1


