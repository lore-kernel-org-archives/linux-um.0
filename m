Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55656C3ABBE
	for <linux-um@archiver.kernel.org>; Tue,  6 May 2025 06:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R8kby2OSQlF1AJrr+6JXF321/m/br+TudjAu8U7GaPM=; b=IylAigtJuJ79QG30KLJFzd6dGJ
	P/F3o6qU7S9zCHyZBWcON18CNg/n4I6kA/yv80wcpqsia8T8N/8lft4pCiEUh1QYlEX0NyIJ4TpZ9
	/KS+N71xRjk64x4vBiLm1wjXETSf73aqlOzClg7Y08VRptSa2kZ78V0xywnZoN2jjvnxW3NUH7zuC
	X6m7k7k0RTeSWciksA+1xLIHdOPutikK3yiUkGNYY2uOl1/SZgvyj8J0jIxJg3tRDoEbOaa6vI7I4
	2L02mYyseUnOuvZiF3DPbD8cKjTe2Omu1FKrV3pt65AwV850PokqdkO+t6GVFvMHiYK8GYIcsbnUV
	nuV3TIVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCBYy-0000000AcbB-1DuF;
	Tue, 06 May 2025 06:13:56 +0000
Received: from out0-217.mail.aliyun.com ([140.205.0.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCAHJ-0000000AIjb-2bgI
	for linux-um@lists.infradead.org;
	Tue, 06 May 2025 04:51:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1746507093; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=R8kby2OSQlF1AJrr+6JXF321/m/br+TudjAu8U7GaPM=;
	b=gyy/VrG3LMc/0eiwu5d3fuIw8Uya/C7ZB+mZrKNmm6TVfxIOuPIXJMi2o7WCJPzZGXF4r5IulH8Vqv9lHWeoowQvf3QfwbVpFfHNiC92JiCOiB/TEQkaYNbD1vPx9pKnJFJLj3/Q2HHH3FCn4ptmD5u+Xy1fg8SJPss9KYzdHYM=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cfhx6rY_1746507084 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 06 May 2025 12:51:30 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <geert@linux-m68k.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/2] um: Misc cleanups for vector
Date: Tue, 06 May 2025 12:51:15 +0800
Message-Id: <20250506045117.1896661-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_215138_134175_900DFDC9 
X-CRM114-Status: UNSURE (   2.76  )
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

Tiwei Bie (2):
  um: vector: Clean up and modernize log messages
  um: vector: Use mac_pton() for MAC address parsing

 arch/um/drivers/vector_kern.c | 52 ++++++++++++-----------------------
 1 file changed, 18 insertions(+), 34 deletions(-)

-- 
2.34.1


