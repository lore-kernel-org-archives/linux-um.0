Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FE4D24472
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 04:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UXivylKKVZoaavgHJDWP6Lp6p/IoGhjIDtQtnWzg12U=; b=gWQG8V//3a7+770QE51xUZKgU7
	SRVAgP39vMjGnymzNTX8e+07zEom779Q8FVfUinQh27gVs9EaKpkNhAl7O9igtaEQ5xtc96Qce4jZ
	AdAfEuGuHE5BiqdkLs3CbEXQdtr3jfUVjEYFIDKSCqs9cUQVETPWX2RIijHhTGzg11mBWQJqrJEfS
	foJZwAKEylC+nSYAr/ntQk45Vq2Ha6h2QcWrwOSczG5VqnMc9LCFHT/pEIU+/1P2JDjXMPK54yFX4
	X93i8hVykTJm5aX36OngtHYxBU+2IHnVh9yb5heedYMfByjjA8Eb2AAPKwrLnoJMnymSbpo2EdLag
	p3u145DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6tm-0000000FCJG-2oEL;
	Fri, 11 Oct 2024 04:05:06 +0000
Received: from out0-207.mail.aliyun.com ([140.205.0.207])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz6tg-0000000FCCH-0ktp
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 04:05:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619497; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UXivylKKVZoaavgHJDWP6Lp6p/IoGhjIDtQtnWzg12U=;
	b=SaZVE1mFm7j/8b9XOfqir2axbM2T7UY4SW1MLDUMOHRnSfyCNvaOjRtao1ITgQ8035aVwt2vKe6JTgmzGGhf+meCFXBnW01J/Vt0Q85lhGetHb30EvT2bgcFZzNV68192UcP784AzTRxvSNMNvhtzlEYlVEqyivUwBgoVjAVesk=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tzj_1728619496)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 8/9] um: hostaudio: Do not propagate mixer parameter to kernel
Date: Fri, 11 Oct 2024 12:04:40 +0800
Message-Id: <20241011040441.1586345-9-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
References: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_210500_422240_AA3F43E4 
X-CRM114-Status: UNSURE (   6.15  )
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

This parameter is UML specific and is unknown to kernel. It should
not be propagated to kernel, otherwise it will trigger a warning and
be passed to user space as an environment option.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/hostaudio_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index 09af903b75ae..0ac149de1ac0 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -57,6 +57,7 @@ __uml_setup("dsp=", set_dsp, "dsp=<dsp device>\n" DSP_HELP);
 
 static int set_mixer(char *name, int *add)
 {
+	*add = 0;
 	mixer = name;
 	return 0;
 }
-- 
2.34.1


