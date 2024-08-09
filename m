Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A617BC3DA4A
	for <linux-um@archiver.kernel.org>; Fri,  9 Aug 2024 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cXTIkBeTV85CInmsU1beDXb9H0PRJIloAkaLQMqdCGc=; b=Etq1M82Om8dQ2mqRcUSKoqdJ0B
	LApLiWDGTMJzSXo3/NVtBkhc7yj/ik+dygfd545X0BmI8X22jW4sJBGQVuM22nmr33tj7bg9qu/hJ
	rRa1NYdZ4PG/XAPh3IZZZb88EtSKcMh26z8CczbsPZnxyppCeJq4XG+wzOv8lxytTZX5sc71n1ZW7
	Jm6rckCt55qUzKx8Su7ZjlX62VECrMJxd9ete3LxGOmTVX8iXAVK78XCL59OJNxDailhyj9DKV81g
	+Rbd5xcfmm7umbLwlSwfpG9hLPRjn5WU08BWwtLjuoGyKm3iXMpB8IJnFgafAxt/qPm6PJv7m1vWN
	wX+3uRIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scPPO-0000000BHzt-3Oc2;
	Fri, 09 Aug 2024 13:11:54 +0000
Received: from mail.virtlab.unibo.it ([2001:760:2e00:f0a1::32])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scPPJ-0000000BHyV-1hg6
	for linux-um@lists.infradead.org;
	Fri, 09 Aug 2024 13:11:53 +0000
Received: from cs.unibo.it (94-33-52-139.static.clienti.tiscali.it [94.33.52.139])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id 4BD511C007A;
	Fri,  9 Aug 2024 15:11:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1723209092;
	bh=lnlh77I0VHgNXGVtjJ14f3ZmVH3RHXTbcUQfv64+4Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmgvXMi2JmHarhUiHWqqcehW1HN8S6TR8sWE9SzGHkvCi8EUE861BP/iA+OuawXzb
	 mphGa8pAezLcwql/hcy068dXuCcAMe0R76RRORP1eaMw7YFZnsBpN02TjgMQE75ghw
	 5zVvsHxWVVzCFJ0DKcsZyd5ckC1DQPGszd4/Xj4w=
Date: Fri, 9 Aug 2024 15:11:31 +0200
From: Renzo Davoli <renzo@cs.unibo.it>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-um@lists.infradead.org, luca.bassi14@studio.unibo.it,
	davide.berardi@unimercatorum.it
Subject: Re: [PATCH 2/2] user_mode_linux_howto_v2: add VDE vector support in
 doc
Message-ID: <ZrYVg8r5lhRheqoS@cs.unibo.it>
References: <ZqjwuBOlysJl8kn_@cs.unibo.it>
 <0bcb8271-4528-4833-bfdf-1ce0a3a650e2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bcb8271-4528-4833-bfdf-1ce0a3a650e2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_061150_297738_8523EAC3 
X-CRM114-Status: GOOD (  10.54  )
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

On Tue, Jul 30, 2024 at 07:18:04AM -0700, Randy Dunlap wrote:
> Missing a close/right paren ')' somewhere.
> I suppose that you meant the typo "automagically".

thank you Randy. I have fixed the typos in the emended patch here below.

Add a description of the VDE vector transport in user_mode_linux_howto_v2.rst.

Signed-off-by: Renzo Davoi <renzo@cs.unibo.it>
---
 .../virt/uml/user_mode_linux_howto_v2.rst          | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index 27942446f406..32a90baf263b 100644
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
+connect to a local area cloud: all the UML nodes using the same
+multicast address running on hosts in the same multicast domain (LAN)
+will be automatically connected together to a virtual LAN.
+
 Configuring Legacy transports
 =============================
 

