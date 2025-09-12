Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AAFCA101F
	for <linux-um@archiver.kernel.org>; Fri, 12 Sep 2025 23:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wj2EzCDO/uH/NVYiO2SSDOzQUMFnuWGG6J5ju6LXtrM=; b=XgjZXen/DoyoXl2YEXGeQQXLqt
	QkJlPmeanEh6FkpuwFDD9+yB1vWzzsG82/X7wZSv2SiSSN6G63U3xeUgLsWsvvNYY0tVcr2u0HAwj
	QFjks+ZOs+FKQiuhWekWEIdgm/cY+jCTcxVXUJhHFILZQUwVFpFGtDLwanYXjTt6DoEqMyJLvCj5V
	JoWJz7BFEn8giL9Am+ubQL8+anGHcUCrF4FvC2sdwWBfpdr/8VZLoaSrFqwP+6JnX5uyccX2oIOx6
	kv0Co5rRMcn3sHIpxOzQ+TN2D0yhRgejMWTuN6j1qIpx7POycuIpgAFLjJeFMyYdjtp6qojIlvQGK
	3He5y1Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCtv-0000000C0pf-23B6;
	Fri, 12 Sep 2025 23:09:55 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCtt-0000000C0oD-0aEO
	for linux-um@lists.infradead.org;
	Fri, 12 Sep 2025 23:09:54 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso2418520b3a.1
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 16:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718592; x=1758323392; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wj2EzCDO/uH/NVYiO2SSDOzQUMFnuWGG6J5ju6LXtrM=;
        b=E0HZgStcRpQLwGIyleqCz31ZEqppbWtulO6o4uuuF1d4E+VQ+0n3lEQ6Qxtvu33jtM
         8rS/wccNMuFwzDrzF8QHV+JFPnKBTWnY6KzWRRnBb7Ga0CBN4GS3VK1PXQkHiMGe8yxY
         JkIpuJk5xHrxxtAD/yd4c4g29HKl8gpBF4K88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718592; x=1758323392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wj2EzCDO/uH/NVYiO2SSDOzQUMFnuWGG6J5ju6LXtrM=;
        b=TnXCisikM0sNeF9uprq0nyyqShJwAsRt2W6ZbrJj14NvHSamLL7PjlZBFfL5OCk3eQ
         /9MIEu2r4sc2qBEeKChqK+stOLNZJohHZz8uQFAkFOgdRAxPukfn7rE8CFaA9DfHJDiF
         bQVAVzrD0FIdbz31spAbewzvaKhWXiAhkJTYTOQTiFrFKXmSpKNxdQ066DJUab0Dtj/Y
         KqtbUZUKd2UfDmjZM3TzYZkq714OJXSJxicDoqQ6JVGKBEalyQonyyv0CDwcUgpDNCyE
         jL/+Cdt2e0maX7KfqfTb4tMOw3phwi2Ljpq8Id9nx0HKouMMPSMT/ySz3Np5EgSsFKF9
         +d5g==
X-Forwarded-Encrypted: i=1; AJvYcCXMrkcnT0D8asi5whqVWou6EsdEIrZC0tQIsUY2FLeRvL2gSsAwSeF3QBR/kVYaTTQq6i83x+ubtQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxAMSH05zxG1Im/4ZRUCJ9e2I0eeMchWrPJIlPGZdD3VvHWeU18
	tHXp0tJoyBxnYq8EL91rNvm/8Da1NG5Ds+FyN0bBvbmFBLrK+rsoSr2boW44xaz4kA==
X-Gm-Gg: ASbGncv9oighO+CCj2nOOWqRuZhC4GLCUrwdUMDdK+1NJ2Oa7jIDgyp0rNHS1Xed8X6
	qBie8VGds+EfdWOxb6Svsxo2ZKwIyD/q2ZZbIGLh9zwMVi2vT9dyNPBPA2oekflu43U5116OZ6i
	KrnBvynR8ZgD2LSguororzKH26gejSVsCFunLKR/UifGZWi6KG7tFOSRGmQECtA6CHx4su/EY3l
	00wZmBlvF2ME+DgLMzUAezibKvFDyIFUHFEv4D19a+vRbBA4N4a5NxMBeX9vjLabvaaqxlANc80
	fgSkccMPJO+4/dQg7pAqmWYtpNFYsHAb38/SQIWTNJHsxT9dPvVGJ8bxrlPb6kcOSo5egOsr91z
	STyWVtueEblk2B7PdfOyHoxoFE30VFGGcFrC6ziz4WhId3s8wKVsDYSCpQ48=
X-Google-Smtp-Source: AGHT+IE5DR0gvGWUro9z10EvotDyakdL5SHVeYZ/tNuNggcehVsLSaHVKcMNLMyAhxmQVoCyYfqTvQ==
X-Received: by 2002:a05:6a20:9147:b0:251:9f29:454b with SMTP id adf61e73a8af0-2602bb59347mr5854185637.39.1757718592010;
        Fri, 12 Sep 2025 16:09:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32df97c3b9csm1227762a91.11.2025.09.12.16.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:51 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>,
	Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/4] PCI: Add support and tests for FIXUP quirks in modules
Date: Fri, 12 Sep 2025 15:59:31 -0700
Message-ID: <20250912230208.967129-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_160953_213427_8A8FCD94 
X-CRM114-Status: GOOD (  12.02  )
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

This series primarily adds support for DECLARE_PCI_FIXUP_*() in modules.
There are a few drivers that already use this, and so they are
presumably broken when built as modules.

While at it, I wrote some unit tests that emulate a fake PCI device, and
let the PCI framework match/not-match its vendor/device IDs. This test
can be built into the kernel or built as a module.

I also include some infrastructure changes (patch 3 and 4), so that
ARCH=um (the default for kunit.py), ARCH=arm, and ARCH=arm64 will run
these tests by default. These patches have different maintainers and are
independent, so they can probably be picked up separately. I included
them because otherwise the tests in patch 2 aren't so easy to run.


Brian Norris (4):
  PCI: Support FIXUP quirks in modules
  PCI: Add KUnit tests for FIXUP quirks
  um: Select PCI_DOMAINS_GENERIC
  kunit: qemu_configs: Add PCI to arm, arm64

 arch/um/Kconfig                           |   1 +
 drivers/pci/Kconfig                       |  11 ++
 drivers/pci/Makefile                      |   1 +
 drivers/pci/fixup-test.c                  | 197 ++++++++++++++++++++++
 drivers/pci/quirks.c                      |  62 +++++++
 include/linux/module.h                    |  18 ++
 kernel/module/main.c                      |  26 +++
 tools/testing/kunit/qemu_configs/arm.py   |   1 +
 tools/testing/kunit/qemu_configs/arm64.py |   1 +
 9 files changed, 318 insertions(+)
 create mode 100644 drivers/pci/fixup-test.c

-- 
2.51.0.384.g4c02a37b29-goog


