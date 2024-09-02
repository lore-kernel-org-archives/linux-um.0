Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6F7CD13CF
	for <linux-um@archiver.kernel.org>; Mon,  2 Sep 2024 05:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dcARxruAP0vzhVrIv4mZE+MUS7Q/ymIzQKM3BTvM2Fg=; b=otOaTTNXZPRarzzvtjr0QTVmzG
	x77WYQbmkRKPI+ybhT8661hq6bkYZdv7t281qf28qQJrxwbNMpWVZe/Di+Fa2lEUYECl++LSGYiXG
	GXIzj9/wBSDCvH0454kHdTj3AmqgD16pLGEmTfACOgFwXyNfC/WVliJgArkwzWDmQYfLoM7e7wLPf
	76LDOp+qo8oxPzrVslBffeS8ZuLc1rrkLMHiGcZCzXVVs8sGQFlkvpvRaLbVeNb8SF8oQQpj83YSo
	J/zsQQYGnxaIZccM+ipWsMhmUmcYmLh5rqUEDN+88cUTY2xoaKBVgACXIM1b1/x2IPBokmWnt7jjr
	f7hD070A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1skzgk-0000000D2LO-2W8r;
	Mon, 02 Sep 2024 05:33:18 +0000
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1skzfJ-0000000D1zx-07x7
	for linux-um@lists.infradead.org;
	Mon, 02 Sep 2024 05:31:50 +0000
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-268d0979e90so148740fac.3
        for <linux-um@lists.infradead.org>; Sun, 01 Sep 2024 22:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1725255107; x=1725859907; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dcARxruAP0vzhVrIv4mZE+MUS7Q/ymIzQKM3BTvM2Fg=;
        b=CYA6ZS5JYtMAvsOaFKdh3PwR6eqMcTS/H9NJeGiJ7tSaFDeKdklJWSjGBJVh5LokVZ
         2cCLsZCywStj3SWPjWeMrxcJo2fMGpLNo0Dr40J02LGCAshoi7DzNCt17J5EAnx1wNx5
         yZMBtSncmJ/erHWinS79yTz0Y5sU/FLl1GJj4Ev+pzVXyMj8VhXczceuzsL7b6GWR6Xu
         2bZ+i2EJUjPd2gohbWcBYoqHizkb53jaECgeqf2FbWPvNs+qXWTwrkexSD6S05xEoQyK
         0oX3GUIgy3jTM2q79Mw+eEwm4wnIavR+6jLCdSu4y0jXkpGBCmaaopUH9r4ypzPrRdIX
         Dc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725255107; x=1725859907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcARxruAP0vzhVrIv4mZE+MUS7Q/ymIzQKM3BTvM2Fg=;
        b=FgKzJoN9QfFHnUG1EH080jEGqmWexN2iFFicFNApud/GRXBOW5HehXNJP/LItVxNTj
         GIEX8ME+wG14L3fJVodW7AMJlZKSPzq2jj3E4PoZGNdmKrBx4ltIjPVXyWGOvErjtviz
         YfSqjnkral7ApQS7/f8rxkIhsHLeFPExt3pOaOtEJWowEQew9gNPUNj//d8bJG7RFKsn
         UeJIfzcwSAFjqSuBHQYFZZDCrWCe1DVSPJGu55ByVvEl44g+L3rdY9V18VJosDDMakvy
         tY+MIksrvlyaOav9CGZBHBaNlokhZxR8vQ47PMOmmWBIXc4W9W9fQubxMHy1rlskAg35
         UEzA==
X-Forwarded-Encrypted: i=1; AJvYcCW93h3CXhB2nJFJeNg5xYLX1JRA6Fa2vc0ZbP9S/06uj8VVIs7v6AER0VXaNq3/HdO+kklB9B/qug==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywssv/7aaeQSI7OAlc+RmchuJzjznedcSwWvGUCXIOe/UjToypm
	Tod2STNNZu6NemAwC/k7vwQA70gDPPGHFxBbni+8jeHSvIhMqUFh9Fw8xPH1CXubkPj3cE/QpPP
	+
X-Google-Smtp-Source: AGHT+IG4O9VSEnbCHyMlef62PC66eJmk+Wcfg7k+VoUwjggysZcp2Zp81AWYRWJzYn+qz65dfh/WPA==
X-Received: by 2002:a05:6871:b09:b0:26c:78ce:b0cc with SMTP id 586e51a60fabf-277b0dd215bmr5158894fac.8.1725255107434;
        Sun, 01 Sep 2024 22:31:47 -0700 (PDT)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::901f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a692fsm6076279b3a.60.2024.09.01.22.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 22:31:46 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-um@lists.infradead.org,
	kernel-team@fb.com
Subject: [PATCH 0/2] mm: make copy_to_kernel_nofault() not fault on user addresses
Date: Sun,  1 Sep 2024 22:31:27 -0700
Message-ID: <cover.1725223574.git.osandov@fb.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240901_223149_237002_C9FF217A 
X-CRM114-Status: UNSURE (   8.77  )
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

From: Omar Sandoval <osandov@fb.com>

Hi,

I hit a case where copy_to_kernel_nofault() will fault (lol): if the
destination address is in userspace and x86 Supervisor Mode Access
Prevention is enabled. Patch 2 has the details and the fix. Patch 1
renames a helper function so that its use in patch 2 makes more sense.
If the rename is too intrusive, I can drop it.

Thanks,
Omar

Omar Sandoval (2):
  mm: rename copy_from_kernel_nofault_allowed() to
    copy_kernel_nofault_allowed()
  mm: make copy_to_kernel_nofault() not fault on user addresses

 arch/arm/mm/fault.c         |  2 +-
 arch/loongarch/mm/maccess.c |  2 +-
 arch/mips/mm/maccess.c      |  2 +-
 arch/parisc/lib/memcpy.c    |  2 +-
 arch/powerpc/mm/maccess.c   |  2 +-
 arch/um/kernel/maccess.c    |  2 +-
 arch/x86/mm/maccess.c       |  4 ++--
 include/linux/uaccess.h     |  2 +-
 mm/maccess.c                | 10 ++++++----
 9 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.46.0


