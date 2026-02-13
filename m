Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B5BEDF158
	for <linux-um@archiver.kernel.org>; Fri, 13 Feb 2026 12:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cyURfzZXcDJlyfiLuFT336iclIxhJDZmcMNiSLcaYew=; b=C2S5G/F+zlsu1H3qSO8ZUk05jK
	DTBNGRQ8U8yT5fFJcH1gbKGbPN3mBQTCWDXicibXZTmTGiXsW6nWAQ9IpU0yT2XH0ghgvADKpHDHc
	cIuZtIh9hkRlWHZTZW+eJLA6oVdFPMukew7X9+xBcOOpD8bsvKt9hH0ZoGUOKsieTuwH/ksDnntBG
	cRds9SPt5nPWmsYjLQMluJ7wiCcvNG7vIh8+h5j7fQ+QJv+7DXmO25er/+kvHxOEvcMbJkYl9v9ll
	pWjxVACtAujT9AQN7KAjiCcEaX5ydfkpx+fg6SkgVg+w4F2Lqp48CuunZOO0RWiHWaHRpHkeAHZgo
	P+ItndTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqsKv-00000003RoC-1RDI;
	Fri, 13 Feb 2026 12:31:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqsKm-00000003RnV-1GgX
	for linux-um@lists.infradead.org;
	Fri, 13 Feb 2026 12:31:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=cyURfzZXcDJlyfiLuFT336iclIxhJDZmcMNiSLcaYew=; t=1770985904; x=1772195504; 
	b=tNDLyya3Dzr6raS8PZYK0O1tU3AQ3qELBAdrAirSsVnYVVTZQvPGIt34VILmAZb+YDiLJL7ou6K
	tBvsOCY6hRVSOm1N529nu/bEujKTJ+7Zkoi3lpqlgdAcqLu7nGLGsw48M2W8nLJSRHBiQlte2FaEM
	MxY/kwzMrP9tybuDI2h+Qg0jIkM7EipALU3g7O9mf9n2heFV6rGg5j8IEJip8rO6caBq51HeuCWtg
	q9g9l7cmBL+QarIjGjy7RvQORt/ZE/9QwJNDLYBs4CV+KlS5lujHpETwTnHzMaNNqFd0+zfDW9ZE7
	BYoOmKA/dMBX+3Ui+2N+q3KQ3GOxsAwuOOVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vqsKh-00000007RZU-31Tj;
	Fri, 13 Feb 2026 13:31:39 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml-for-7.0-rc1
Date: Fri, 13 Feb 2026 13:31:09 +0100
Message-ID: <20260213123137.677786-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_043144_366605_49206447 
X-CRM114-Status: UNSURE (   6.71  )
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

Hi Linus,

UML was _really_ quiet, with just four small commits,
but there there are anyway.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f017632193:

  Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-7.0-rc1

for you to fetch changes up to 68e25613ed4d06c987a42b0589f54ce88c13477c:

  arch/um: remove unused varible err in remove_files_and_dir() (2026-01-13 19:43:41 +0100)

----------------------------------------------------------------
Just a very few minor things:
 - two signal handling fixes
 - dynamic addition of virtio devices
 - and a single code cleanup

----------------------------------------------------------------
Alex Shi (1):
      arch/um: remove unused varible err in remove_files_and_dir()

Tiwei Bie (3):
      um: Preserve errno within signal handler
      um: Handle SIGCHLD in seccomp mode like other IRQ signals
      um: virtio_uml: Support adding devices via mconsole

 arch/um/drivers/virtio_uml.c | 51 +++++++++++++++++++++++++++++++++++++++++++-
 arch/um/os-Linux/signal.c    |  9 +++++---
 arch/um/os-Linux/umid.c      |  3 +--
 3 files changed, 57 insertions(+), 6 deletions(-)

