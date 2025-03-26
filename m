Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCBDC36008
	for <linux-um@archiver.kernel.org>; Wed, 26 Mar 2025 07:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C4032vPe07YQfznh8ImWMwr/bLdqXUMIT49+jyr0F8c=; b=sqBVAkwG57zzw8tYJSPd+MyiFk
	c3GRl8N9TPvyHYuxpyNBPDKVV1oSeMnoQqQ5VOSO5N9snzt2bjBIuMPSCbQ72lL2S8qHFRAt9HUds
	0U7oys2tVjxkfhXzHjKUm3jllTHi5dZVtWeKwHeqI8w5ac6i5zC3MjvwYpjjlQRuFsprzFKJJSuNs
	+6i5VIqDWGVvFIu6K0mL2nEzqD4JxE6W3CpS+wBwXq68HQoos0DzfAomVWIDT6vaeaGHpas49iCwJ
	g1U7G29CEMUlYt/Dm7D7hK1lGrRVI3X5v579gjXWyIDkahTZDtWVrMDYMqkYvSGCXXwYbJq2d5Sot
	SsmfO8eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txKlU-00000007iwi-2LM1;
	Wed, 26 Mar 2025 07:01:28 +0000
Received: from out0-222.mail.aliyun.com ([140.205.0.222])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txKlR-00000007ivV-41UI
	for linux-um@lists.infradead.org;
	Wed, 26 Mar 2025 07:01:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742972482; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=C4032vPe07YQfznh8ImWMwr/bLdqXUMIT49+jyr0F8c=;
	b=lB1pb1KMSWuG/X7dR5Q/YMSIY5TyUJn0qjadrq0KmoNEOFJc+XnR/NpeGNIhGraFaarIDoQ706VuqKpIdTF4J2QfW6jqdQTv0eW4QSQpm0bSHuIbCPPq+y+seKV/jsvUqXoj8+ZGG5lMi7OIkRXZsnYcRw/pj/Gmab7on+fnQOs=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.c3eI00o_1742972477 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 26 Mar 2025 15:01:21 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/2] um: Minor cleanups to xterm
Date: Wed, 26 Mar 2025 15:01:11 +0800
Message-Id: <20250326070113.401857-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250326_000126_156945_B784B14E 
X-CRM114-Status: UNSURE (   3.05  )
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
  um: xterm: Add Wayland support
  um: xterm: Update options for gnome-terminal

 arch/um/drivers/xterm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

-- 
2.34.1


