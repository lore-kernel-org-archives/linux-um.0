Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96792CE8E84
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=klL1ZgjZxIjtqjW3xwH+I3qTIyPhe6x0FsOJ1N0m5N4=; b=rEBUFztzP3gNpURo2THcvIHFuE
	29I9M3Zqk7K5InSuX5isK6PPSfWd3a+oSFIqBB7V38E9FYxQECkNvkeF12094oKL2A0hYHrrtHpR2
	EW+TGxganD9VHxC+fJUQJ2bFvLUjlbsGcb/Hl3dqEoAfU02DkF8Ipasoq55/2jw2OiqvemHFKTXxH
	Pn0ZEHgh6VSfpcxz7qpqvyZTCnvhNpb1Ma1CDjlUHRu9Oz2AhmRYFahy1KROZTdgASXbsmxrZmJee
	iuumDDWdZog5GmDC329fhhuoefF60u2YtBPpMWi1d/sY3FBcH9ZvPy8i9QdleAuoGrfAM0KOouR0z
	jEZyDJqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3z1A-00000000mK0-17kF;
	Thu, 24 Oct 2024 14:40:52 +0000
Received: from out0-207.mail.aliyun.com ([140.205.0.207])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3ypO-00000000jV6-3brc
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 14:28:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1729780116; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=klL1ZgjZxIjtqjW3xwH+I3qTIyPhe6x0FsOJ1N0m5N4=;
	b=l7ehQW6rNqL6+Q+AWeyrvaSmnBXLOJDuVom8+SiPFCxZ3xJlDPe70IVFSnsMqr13d9Nl7M9Gqeo4t01X79TusnojIzixxD03TNv4JCX0ZguzGvdJ1jNCd6BXfsYei2D6MpBzjz31s8y2txhkfau/Ij8e1aTo9XvEbudYpvwfg5E=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZreBszI_1729780109 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 22:28:34 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/4] um: Set parent-death signal for sub-processes
Date: Thu, 24 Oct 2024 22:28:24 +0800
Message-Id: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_072843_423898_CD907FD7 
X-CRM114-Status: UNSURE (   5.15  )
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

The ubd io and write_sigio threads/processes may leak e.g. when
the main process is killed by "kill -9". Fix it by setting the
parent-death signal for them.

Tiwei Bie (4):
  um: Add os_set_pdeathsig helper function
  um: Set parent-death signal for ubd io thread/process
  um: Set parent-death signal for write_sigio thread/process
  um: Use os_set_pdeathsig helper in winch thread/process

 arch/um/drivers/chan_user.c | 3 +--
 arch/um/drivers/ubd_kern.c  | 1 +
 arch/um/include/shared/os.h | 2 ++
 arch/um/os-Linux/process.c  | 6 ++++++
 arch/um/os-Linux/sigio.c    | 1 +
 5 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.34.1


