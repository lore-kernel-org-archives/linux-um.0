Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntqSt-00B9PP-PQ
	for linux-um@lists.infradead.org; Wed, 25 May 2022 12:50:18 +0000
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 038973F1AA
	for <linux-um@lists.infradead.org>; Wed, 25 May 2022 12:50:08 +0000 (UTC)
Received: by mail-ej1-f70.google.com with SMTP id bt15-20020a170906b14f00b006fe9c3afbc2so7779730ejb.17
        for <linux-um@lists.infradead.org>; Wed, 25 May 2022 05:50:08 -0700 (PDT)
From: Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 0/2] um: Kconfig: Style cleanups
Date: Wed, 25 May 2022 14:49:59 +0200
Message-Id: <20220525125001.47009-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Juerg Haefliger <juerg.haefliger@canonical.com>

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Juerg Haefliger (2):
  um: Kconfig: Fix indentation
  um/drivers: Kconfig: Fix indentation

 arch/um/Kconfig         |  2 +-
 arch/um/drivers/Kconfig | 54 ++++++++++++++++++++---------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

-- 
2.32.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

