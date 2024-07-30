Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720FBC3DA70
	for <linux-um@archiver.kernel.org>; Tue, 30 Jul 2024 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x4jsGhQ/bKVLX1/BcBVM/P40s1UljBUwhBH91KgCjSg=; b=a75fD8ayUSqy9xG+j6Fb29WFXd
	ObcvgODrZMgn3JPWv4ZV96JSH+Q0cTZ0a9SUXEP69mPrNyGoNEsp9nstrcghNnAnHg+keAereE0hI
	ESBovwx3ZUzWm3fTMxof71kAFUhPOr3pbpYB8ynIhgaNi9K+dV0LYSEAXBx1zLg2rLUym2/yNe6XH
	TmTnlkNuQ8gmBEVzX37qzfU/wccoUc5qsEDXLOzXmEL6evoLWoU/egIaknL8CxbuNsVYWXWG0IZAV
	BArKYHtAJhzd12blOSzZQdh5z88Mjv34dETFbgvdR7ljzA+W/dVyr3uRsjlqAp0h8xEqNF9RJ7F1q
	WwzXcwKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYnJl-0000000FMGT-0hRJ;
	Tue, 30 Jul 2024 13:55:09 +0000
Received: from mail.virtlab.unibo.it ([130.136.161.50])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYnJi-0000000FMDP-2hX8
	for linux-um@lists.infradead.org;
	Tue, 30 Jul 2024 13:55:08 +0000
Received: from cs.unibo.it (94-33-52-139.static.clienti.tiscali.it [94.33.52.139])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id 131771C024C;
	Tue, 30 Jul 2024 15:54:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1722347696;
	bh=BowfdBUDAzkBCzViX8N7v93JGjPDNfdLL7IFOvZsjcc=;
	h=Date:From:To:Cc:Subject:From;
	b=x7WW34CRqUBsYJeZGGkSz/1EKMN3bTBgkANcYM/5mPhjPxZD6zD9adm7ELpZblV6j
	 BpvJIqPAtlTCUDeLD+to9QMrTQcgm7GL+Q+DNuc53yWLOhv8hMBzZXK1r2r8HDblVH
	 utvg6fdGf07kTrZoHFgUhfgXCZrJd66mypNYN4KQ=
Date: Tue, 30 Jul 2024 15:54:54 +0200
From: Renzo Davoli <renzo@cs.unibo.it>
To: linux-um@lists.infradead.org
Cc: luca.bassi14@studio.unibo.it, davide.berardi@unimercatorum.it
Subject: [PATCH 1/2] vector_user: add VDE support
Message-ID: <ZqjwriuvnqgDmwJM@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_065506_960358_644E4A0D 
X-CRM114-Status: GOOD (  11.33  )
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

This is the actual implementation of VDE support as a vector transport.

Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
---
 arch/um/drivers/vector_user.c | 83 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index b16a5e5619d3..2ea67e6fd067 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -46,6 +46,9 @@
 #define TRANS_FD "fd"
 #define TRANS_FD_LEN strlen(TRANS_FD)
 
+#define TRANS_VDE "vde"
+#define TRANS_VDE_LEN strlen(TRANS_VDE)
+
 #define VNET_HDR_FAIL "could not enable vnet headers on fd %d"
 #define TUN_GET_F_FAIL "tapraw: TUNGETFEATURES failed: %s"
 #define L2TPV3_BIND_FAIL "l2tpv3_open : could not bind socket err=%i"
@@ -434,6 +437,84 @@ static struct vector_fds *user_init_fd_fds(struct arglist *ifspec)
 	return NULL;
 }
 
+/* enough char to store an int type */
+#define ENOUGH(type) ((CHAR_BIT * sizeof(type) - 1) / 3 + 2)
+#define ENOUGH_OCTAL(type) ((CHAR_BIT * sizeof(type) + 2) / 3)
+/* vde_plug --descr xx --port2 xx --mod2 xx --group2 xx seqpacket://NN vnl (NULL) */
+#define VDE_MAX_ARGC 12
+#define VDE_SEQPACKET_HEAD "seqpacket://"
+#define VDE_SEQPACKET_HEAD_LEN (sizeof(VDE_SEQPACKET_HEAD) - 1)
+#define VDE_DEFAULT_DESCRIPTION "UML"
+
+static struct vector_fds *user_init_vde_fds(struct arglist *ifspec)
+{
+	char seqpacketvnl[VDE_SEQPACKET_HEAD_LEN + ENOUGH(int) + 1];
+	char *argv[VDE_MAX_ARGC] = {"vde_plug"};
+	int argc = 1;
+	int rv;
+	int sv[2];
+	struct vector_fds *result = NULL;
+
+	char *vnl = uml_vector_fetch_arg(ifspec,"vnl");
+	char *descr = uml_vector_fetch_arg(ifspec,"descr");
+	char *port = uml_vector_fetch_arg(ifspec,"port");
+	char *mode = uml_vector_fetch_arg(ifspec,"mode");
+	char *group = uml_vector_fetch_arg(ifspec,"group");
+	if (descr == NULL) descr = VDE_DEFAULT_DESCRIPTION;
+
+	argv[argc++] = "--descr";
+	argv[argc++] = descr;
+	if (port != NULL) {
+		argv[argc++] = "--port2";
+		argv[argc++] = port;
+	}
+	if (mode != NULL) {
+		argv[argc++] = "--mod2";
+		argv[argc++] = mode;
+	}
+	if (group != NULL) {
+		argv[argc++] = "--group2";
+		argv[argc++] = group;
+	}
+	argv[argc++] = seqpacketvnl;
+	argv[argc++] = vnl;
+	argv[argc++] = NULL;
+
+	rv = socketpair(AF_UNIX, SOCK_SEQPACKET, 0, sv);
+	if (rv  < 0) {
+		printk(UM_KERN_ERR "vde: seqpacket socketpair err %d", -errno);
+		return NULL;
+	}
+	rv = os_set_exec_close(sv[0]);
+	if (rv  < 0) {
+		printk(UM_KERN_ERR "vde: seqpacket socketpair cloexec err %d", -errno);
+		goto vde_cleanup_sv;
+	}
+	snprintf(seqpacketvnl, sizeof(seqpacketvnl), VDE_SEQPACKET_HEAD "%d", sv[1]);
+
+	run_helper(NULL, NULL, argv);
+
+	close(sv[1]);
+
+	result = uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
+	if (result == NULL) {
+		printk(UM_KERN_ERR "fd open: allocation failed");
+		goto vde_cleanup;
+	}
+
+	result->rx_fd = sv[0];
+	result->tx_fd = sv[0];
+	result->remote_addr_size = 0;
+	result->remote_addr = NULL;
+	return result;
+
+vde_cleanup_sv:
+	close(sv[1]);
+vde_cleanup:
+	close(sv[0]);
+	return NULL;
+}
+
 static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 {
 	int rxfd = -1, txfd = -1;
@@ -673,6 +754,8 @@ struct vector_fds *uml_vector_user_open(
 		return user_init_unix_fds(parsed, ID_BESS);
 	if (strncmp(transport, TRANS_FD, TRANS_FD_LEN) == 0)
 		return user_init_fd_fds(parsed);
+	if (strncmp(transport, TRANS_VDE, TRANS_VDE_LEN) == 0)
+		return user_init_vde_fds(parsed);
 	return NULL;
 }
 



