Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08833606A31C
	for <linux-um@archiver.kernel.org>; Mon, 16 Nov 2026 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Xxhd84rk;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cuac3FNc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Cc:To:Message-Id:Content-Type:MIME-Version:Subject:
	Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=90J7NfY2utkKUmptN6ZK3A2BwSBVX+JEiTL57egocE4=; b=Xxhd84rku3Wko2/BQ5ljET/Crk
	uZw3KW46JCtJ2J85CrTTphF2MvHLN3Q32YIcY8ya/cTmFEovYnoKzQMXB/AiZNwapCV0O0kaqpkH+
	JDynPIFH7k4MpefILHc31I4uTK6LBC4rnsCdDJW5GdGN6TUQqKAh1wNaWTHyToKJJuw7IzE2q6Sx+
	f5q5e6k9aC9f1IaKyfQ4KGxzwDdlDoXuWfaedKTprjxZk0j85iPLiZD8w/ZQfT9QPe1hqUc/Vdp+A
	vKjlMd+qtZEJqXTwddXUKQ1tg6YCgCQEcJw1r3mwsOP9Md9dxEk1T4taZYJ8M5lixEwBL1vyiubCH
	jJDFCPwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6Lx-00000004Btk-1xvQ;
	Mon, 16 Nov 2026 23:43:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT6Lw-00000004BtS-0ONm
	for linux-um@lists.infradead.org;
	Mon, 16 Nov 2026 23:43:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7A954456B6;
	Mon, 16 Nov 2026 23:43:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794872591;
	b=3EXYEP/VHtgbs6cfQQvYLUDgup7DRQprd1NBJqdjFh2rnao/Xy2PHBvSsiJgKe9mcP97
	 CyhYoJukPfkzT+SqP4TdxkjBy09tjneCPJFasdUTcnxDrSVlX/CXPfuyap2H3akfEWTNJ
	 QcfrEXvFxkkPbnPnkKuCKCZiU2s5UmXoROtdObiQpjAdbUb+fztrSRT1+x1KVQjHWO00f
	 ihhuGnsjAopICsnkLc/Iefqggd3AfXtipObBmRUzrOxFi9oueKTslue+yeDAb+LF5NJ9P
	 A/GZkUa8kfyiBz9bcSl0cQpogYPjTUfohBL1LmLCHIE3iE5JifgQPYk2BYQ6YmJ2Lhw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794872591;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=90J7NfY2utkKUmptN6ZK3A2BwSBVX+JEiTL57egocE4=;
	b=ASXDsbgtGfa1nOkIdLZ9Mmw0T1z8J42puNaWLjw1UL2FiVWQQ8v+sTP1y/4Z0obURzsu
	 mS2+317eYbSbGMs6tqnC3q9Fny0YISsibF9tBkUPuEaBXVZTOfOzF3GF9YPnaNTX5MaLt
	 hg+UlaLBHzX+NBhakipBiEBXqcPJuXKKybP1gz1zM75gnMVCTShwky37Upx5snX3det/L
	 p1NXKpowOW4okIkuuWxJBsu83cRUBjXjke1ocQhk8QcYig9oUa7VuK/O3In5UVUZ38cCm
	 dJPStmTLTqICvUkI35rB7pZ8FWPGMc1MWnUvWrQ8Gji8mpu5tBmQgTCP/fE6pyjWO4Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C5F061F000C4;
	Mon, 16 Nov 2026 23:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794872591;
	bh=90J7NfY2utkKUmptN6ZK3A2BwSBVX+JEiTL57egocE4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=cuac3FNcQyI77ZfxSz/79kJ7LlBzaJuEuwPGmVgTm8s62G5DniyvYJgMk4ywfJBCU
	 hZ9K35l/qo7S5sElnwlx87r7/dW/BY/vYPJRAxfcTNmoxgZdOOfa2BXTql1D4EKzKS
	 K9jaWdfgF2o3enAST3FvmNdPgHrK+S00kVqHLVprRPrEAClNVH6vCpYllLnNH7KcPO
	 KXfaHyt8bQZdI7vJODEjOBnCdPOmcu+iSHsW2D+qv/J7tlndZvPH3YYyPwWmrqwoVu
	 mMsuYS0eNWkijxKD6/YDSthm8IJeLbH8BUK9j9ZYBXQkhgc2yJXvriX2RA8IocNkuv
	 5REg816NgFl7Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 537F04A62C;
	Mon, 16 Nov 2026 23:43:10 +0000 (UTC)
From: Brad Fitzpatrick via B4 Relay <devnull+bradfitz.tailscale.com@kernel.org>
Date: Mon, 16 Nov 2026 23:43:10 +0000
Subject: [PATCH] um: time-travel: don't use uninitialized fds from START
 ACK
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-bradfitz-um-tt-start-ack-fds-v1-1-c98901dfba85@tailscale.com>
X-B4-Tracking: v=1; b=H4sIAA2V+2oC/yXMSwrCMBAA0KuUWTuQFIzRq4iLfCY6ilUy0yItv
 XujLt/mLSBUmQRO3QKVJhZ+DQ1210G6heFKyLkZetM7a63DWEMurDOOT1RF0VAVQ3pgyYLROxM
 O/uj3JkMr3pUKf379+fK3jPFOSb8nrOsGKAwxxYAAAAA=
X-Change-ID: 20261116-bradfitz-um-tt-start-ack-fds-b860a789850d
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Mordechay Goodstein <mordechay.goodstein@intel.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Brad Fitzpatrick <bradfitz@tailscale.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794872590; l=3107;
 i=bradfitz@tailscale.com; s=20261011; h=from:subject:message-id;
 bh=svJ5VLX3SY7Jwr6l6XQ1OWwW8bhiwm/+jQGOHWzz8T0=;
 b=IOkJl5/z0TBUNrib7G4B/VeY4RTdfS4W6M/93O6qhhvWvl0no+N7OU0egfkK5LnBL2JdBbfBE
 4/KxOKojlN/Dz9GzqVCiDuFx7wEyva2Tm4jpJMDzkO/BdC0/LOYQcNx
X-Developer-Key: i=bradfitz@tailscale.com; a=ed25519;
 pk=RL25YdOUenVJzQaiZDrw/Aqu9ZEwUQBon30yMHGsIKY=
X-Endpoint-Received: by B4 Relay for bradfitz@tailscale.com/20261011 with
 auth_id=1152
X-Original-From: Brad Fitzpatrick <bradfitz@tailscale.com>
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: bradfitz@tailscale.com
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Brad Fitzpatrick <bradfitz@tailscale.com>

When the kernel connects to an external time-travel controller, it
expects the ACK of its UM_TIMETRAVEL_START message to carry two file
descriptors: the shared memory area and a log file. It reads them with
os_rcv_fd_msg() into an uninitialized on-stack array, and then uses
both array elements whenever the message itself was received in full.

os_rcv_fd_msg() leaves the array untouched if the message came without
an SCM_RIGHTS control message. That is what any controller that does
not implement the shared memory extension sends, which the protocol
allows: such controllers are why the kernel falls back to message
based scheduling. In that case the kernel passes stack garbage to
mmap() and then close()s both values.

With CONFIG_INIT_STACK_ALL_ZERO, the default where the compiler
supports it, the garbage is 0, so the kernel closes its own stdin. The
next file descriptor it opens, the epoll instance used for IRQs, then
becomes fd 0:

  $ ls -l /proc/$(pidof linux)/fd
  0 -> anon_inode:[eventpoll]
  1 -> /tmp/uml.log
  2 -> /tmp/uml.log
  3 -> /dev/shm/#200843
  4 -> socket:[216518625]

Without stack initialization the kernel may instead close, or map as
the scheduling area, any file descriptor at all.

Initialize the array to -1 and only use the descriptors that were
actually received. With the fix, fd 0 stays what it was and the epoll
instance gets the next free number.

Fixes: bfb80d8bc92f ("um: add shared memory optimisation for time-travel=ext")
Signed-off-by: Brad Fitzpatrick <bradfitz@tailscale.com>
---
 arch/um/kernel/time.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index d620b6d6310a5..bcb141b419722 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -141,15 +141,23 @@ static void time_travel_handle_message(struct um_timetravel_msg *msg,
 	}
 
 	if (unlikely(mode == TTMH_READ_START_ACK)) {
-		int fd[UM_TIMETRAVEL_SHARED_MAX_FDS];
+		int fd[UM_TIMETRAVEL_SHARED_MAX_FDS] = {
+			[0 ... UM_TIMETRAVEL_SHARED_MAX_FDS - 1] = -1,
+		};
 
 		ret = os_rcv_fd_msg(time_travel_ext_fd, fd,
 				    ARRAY_SIZE(fd), msg, sizeof(*msg));
 		if (ret == sizeof(*msg)) {
-			time_travel_setup_shm(fd[UM_TIMETRAVEL_SHARED_MEMFD],
-					      msg->time & UM_TIMETRAVEL_START_ACK_ID);
+			/*
+			 * A controller without shared memory support
+			 * sends no file descriptors with its ACK.
+			 */
+			if (fd[UM_TIMETRAVEL_SHARED_MEMFD] >= 0)
+				time_travel_setup_shm(fd[UM_TIMETRAVEL_SHARED_MEMFD],
+						      msg->time & UM_TIMETRAVEL_START_ACK_ID);
 			/* we don't use the logging for now */
-			os_close_file(fd[UM_TIMETRAVEL_SHARED_LOGFD]);
+			if (fd[UM_TIMETRAVEL_SHARED_LOGFD] >= 0)
+				os_close_file(fd[UM_TIMETRAVEL_SHARED_LOGFD]);
 		}
 	} else {
 		ret = os_read_file(time_travel_ext_fd, msg, sizeof(*msg));

---
base-commit: 7ea2308ccebce754fd1ac6295f26983a6878045d
change-id: 20261116-bradfitz-um-tt-start-ack-fds-b860a789850d

Best regards,
--  
Brad Fitzpatrick <bradfitz@tailscale.com>



