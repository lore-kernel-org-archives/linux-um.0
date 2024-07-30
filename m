Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E020FC3DA7E
	for <linux-um@archiver.kernel.org>; Tue, 30 Jul 2024 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bdwX+htnOfCFIFxfR06/GQ9O2jyBTUhWj5U7xmiNS8c=; b=2DsMQxJnaLoT0ssxPvlkchee/Y
	QA0U6T0cFco8B3jg5BnCTauVeb6YfC3DQIxdT/scWZawYu5TN0qzwpkUk++Cv5ln2f/Yb/IRNBvbs
	Be6zfXbr4Bl4r+pduYJC4yP09QREpgugmqsyESwKFq5gmA8HN7T+TMhX5ThOOG/i1ecz+W4W5j9DO
	E/Bnc6t+kO4gmfCMwkH++fBXUZLuQoTR+XrTS4EpWj4deVws0s03plCsrWuyYjQBa7weUIrxBDH0k
	ce4aD722pF12F/6h1Fv8OYomkMOCwkbti7gFj00XpiJseMDHPyI/WfDlha3yNVshNwcv3WTUtKbfn
	orwHStxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYnJl-0000000FMGj-1zjk;
	Tue, 30 Jul 2024 13:55:09 +0000
Received: from mail.virtlab.unibo.it ([2001:760:2e00:f0a1::32])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYnJi-0000000FMFU-3j3G
	for linux-um@lists.infradead.org;
	Tue, 30 Jul 2024 13:55:08 +0000
Received: from cs.unibo.it (94-33-52-139.static.clienti.tiscali.it [94.33.52.139])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id 0D4571C0251;
	Tue, 30 Jul 2024 15:55:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1722347706;
	bh=hZRX+moV8GtusejOteS6BnyOBaCb6nZJkJnSKyzwQXQ=;
	h=Date:From:To:Cc:Subject:From;
	b=Sb8ZowE4kTMWY69e6VCJtNrC2kLmLXnxvjAAANY+BXrNSCMW4xqxIk/tZkKwKu54V
	 X/XIG5y+v8vk+YQCc9xvUpbO7emd1xtV4/qD372cwT5fzAY/Fj0CHjChoaDjpOM024
	 vqCdxUjTLkLOyfsRJIxP16svWmVUBxOPRKpnn7ps=
Date: Tue, 30 Jul 2024 15:55:04 +0200
From: Renzo Davoli <renzo@cs.unibo.it>
To: linux-um@lists.infradead.org
Cc: luca.bassi14@studio.unibo.it, davide.berardi@unimercatorum.it
Subject: [PATCH 2/2] user_mode_linux_howto_v2: add VDE vector support in doc
Message-ID: <ZqjwuBOlysJl8kn_@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_065507_114504_3F580B28 
X-CRM114-Status: UNSURE (   7.10  )
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

Add a description of the VDE vector transport in user_mode_linux_howto_v2.rst.

Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
---
 .../virt/uml/user_mode_linux_howto_v2.rst          | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index 27942446f406..584000b743f3 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -217,6 +217,8 @@ remote UML and other VM instances.
 +-----------+--------+------------------------------------+------------+
 | fd        | vector | dependent on fd type               | varies     |
 +-----------+--------+------------------------------------+------------+
+| vde       | vector | dep. on VDE VPN: Virt.Net Locator  | varies     |
++-----------+--------+------------------------------------+------------+
 | tuntap    | legacy | none                               | ~ 500Mbit  |
 +-----------+--------+------------------------------------+------------+
 | daemon    | legacy | none                               | ~ 450Mbit  |
@@ -573,6 +575,41 @@ https://github.com/NetSys/bess/wiki/Built-In-Modules-and-Ports
 
 BESS transport does not require any special privileges.
 
+VDE vector transport
+--------------------
+
+Virtual Distributed Ethernet (VDE) is a project whose main goal is to provide a
+highly flexible support for virtual networking.
+
+http://wiki.virtualsquare.org/#/tutorials/vdebasics
+
+Common usages of VDE include fast prototyping and teaching.
+
+Examples:
+
+   ``vecX:transport=vde,vnl=tap://tap0``
+
+use tap0
+
+   ``vecX:transport=vde,vnl=slirp://``
+
+use slirp
+
+   ``vec0:transport=vde,vnl=vde:///tmp/switch``
+
+connect to a vde switch
+
+   ``vecX:transport=\"vde,vnl=cmd://ssh remote.host //tmp/sshlirp\"``
+
+connect to a remote slirp (instant VPN: convert ssh to VPN, it uses sshlirp)
+https://github.com/virtualsquare/sshlirp
+
+   ``vec0:transport=vde,vnl=vxvde://234.0.0.1``
+
+connect to a local area cloud (all the UML nodes using the same
+multicast address running on hosts in the same multicast domain (LAN)
+will be automagically connected together to a virtual LAN.
+
 Configuring Legacy transports
 =============================
 

