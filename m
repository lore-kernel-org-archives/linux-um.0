Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194E6D2446D
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 04:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XWQ1ddR8ZcAwD91UZmRnhbCLLnJTKTAUdU8I9wrCZOA=; b=0g7y6ScagNdBj+7WhafDtR5uI1
	zewYapKigpP8K9Zh6ilTtlypLvsLNn5C1Pfg4HrELijsNLfc/4dsbyGwYs6XJLUjwoboWWJ4763VM
	BWzvZq/mfOmB/Xs1DAAImQglQ/vi+k613fLKFeAyFKjgmheZG/Zq1heIjy5xa/vsvWM+JLUwjtfdw
	WzO+Tcj9qpV1mL+hy5I9I9fRoUDihdA6RChIJT6cDDqgRTubYdO7A7QbwzU1e79BTG0UHz6SIR7Sx
	5x33dN2S80vrYh0a05NgbtJfbggwsy4sfTuMwBHxkBA2jBn816bMrZceYJrsmJMeyzMlNmSw5hKlA
	OOfACQyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6tj-0000000FCG8-2hPd;
	Fri, 11 Oct 2024 04:05:03 +0000
Received: from out0-195.mail.aliyun.com ([140.205.0.195])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6te-0000000FCBw-3rM0
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 04:05:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619496; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XWQ1ddR8ZcAwD91UZmRnhbCLLnJTKTAUdU8I9wrCZOA=;
	b=1fEsLEuf4BsbSuzhqFVygGv7f/QmLPFTPs3E/h0o19075EE0+RyWSZdz/2SMZ93zOy/uMn8E9yNcxTZZ9Iq3fvleKGpvstHOq31jGq1JiNz0Di16TDIVrXBj3IDTrcK0gjIoaoo9oaR4qMZ+THovDmGiHPKcYs13oaT2RDzoOzY=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tz8_1728619495)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 6/9] hostfs: Do not propagate hostfs parameter to kernel
Date: Fri, 11 Oct 2024 12:04:38 +0800
Message-Id: <20241011040441.1586345-7-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
References: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_210459_181815_B9960AB7 
X-CRM114-Status: UNSURE (   7.38  )
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

This parameter is UML specific and is unknown to kernel. It should not
be propagated to kernel, otherwise it will be passed to user space as
an environment option by kernel with a warning like:

Unknown kernel command line parameters "hostfs=/foo", will be passed to user space.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 fs/hostfs/hostfs_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 6d1cf2436ead..8d47c6b70c9f 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -57,6 +57,7 @@ static int __init hostfs_args(char *options, int *add)
 {
 	char *ptr;
 
+	*add = 0;
 	ptr = strchr(options, ',');
 	if (ptr != NULL)
 		*ptr++ = '\0';
-- 
2.34.1


