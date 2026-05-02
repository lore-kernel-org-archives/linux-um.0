Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA8FCD13DA
	for <linux-um@archiver.kernel.org>; Sat,  2 May 2026 11:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/P2+h0oopeGcJLkWbR2iUk4xU6TlOScWeXXKUXMCSiQ=; b=HtRtsoS8lZxSck1woWdm3qei3q
	2sB3s2ROhS9EIrjE8XGFPYSjINWFy8c9fpKZL8CyQBdkGnCWFYYxgWsUTXytqr66fVtcava608en1
	5m0gGuqL2iPCdfsisbIJ2KctI0o1TpgMfhH6tKxPy1+rz4PdIPL23P2kZCNRcboCS6Om2dpvMluca
	qcUrRbfAKMnophTKNYH5FLjjDEpeI3/MvKX41toI9CPEtsktkVxs4N02h08BlqnOcrbuZeyUX2NaE
	6d445cYq/sT5y1FMZ9XNv1aTToeKfPW+tOKwPvXnzgXlD06sYaCA0JHK+UW9pOOi+k4ScB7LpSZL1
	3v3jTQxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJ8Nj-00000008tEy-1n43;
	Sat, 02 May 2026 11:19:35 +0000
Received: from out162-62-57-137.mail.qq.com ([162.62.57.137])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJ8Ng-00000008tDz-3w2d
	for linux-um@lists.infradead.org;
	Sat, 02 May 2026 11:19:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777720761; bh=/P2+h0oopeGcJLkWbR2iUk4xU6TlOScWeXXKUXMCSiQ=;
	h=From:To:Cc:Subject:Date;
	b=f8AdAd1Yzny6M9AGdBnREOaXZxkFWW7WJ/+yycFusP7iV84+7/WzHQPvf2IRKiw69
	 TD3uQvVqPbq47spY5qpoMkkQorZa3+QCTnntWKXxvN98vqJ9W/2iKdt0Dssmf1bm+D
	 4+R4IQ+sAN8qNgmLqsq8fgiyhR81/fGM8wjHAUrw=
Received: from Lang.smartont.net ([2409:8a44:2312:14e1:56d8:1e1e:3f0b:d0f3])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 4D013C04; Sat, 02 May 2026 19:19:16 +0800
X-QQ-mid: xmsmtpt1777720756thcvqggum
Message-ID: <tencent_B1D6CBBF95486E31D04C2E1B92F5E605A307@qq.com>
X-QQ-XMAILINFO: MLMEjb5zWVcNZZuUZyxHibZ1w+zisKptqYUhi/n6boR51UmP7NHS8C4/S4TwPE
	 sGhHegepQweJhOWf0lnRWad3ibJaI33gTpKd4J2h8wubBIvPvYqgeYEJ1rA6dVNXCVNaY0UEECeZ
	 PIxOLhUlSxTboDw78cjaEmSdfcyf3Meqzkh0gyCB1y5zWNS9fYuG4qGawMYElyJRGuuVqRx8Zf4N
	 QCdXAa6S/8nRI10lTNwpLAoQA0DM9FOy0m4bVyvv3o7zThEk6V0zKMfnDPm/MhJT0LC6h8j7/2Xc
	 ULiJO1ju+7+REB9UH/FhWoYAgD2+4BYQY4nnR3jrMIKV64+I+bjBVwtWpIreuUnNNuQCGkRONe/l
	 HtxGCswDbacj6VJ+K9w33mujR7GZVReAtMqbgdwjfTUqPqtBTgKSTaPmzzkZjaOzjOuXtS1VZLDY
	 0qWZQDd1+KQT153BCfbWRXaJi1uFBddsj/UC70CnMxJCFdOWlCgNHZKxuCvSh1MSvn9i40U0o+8O
	 IJOIG5GdhXoxpv2P8asYMgp/hKKwEFpgurcH8lHeN31PqBgOmMiqJQhaG2paGFdOepXHyUE6Wd6L
	 R95zAvxRCk8nC02tP9N38FaW+KksyO5WFk/8Y2WyWv2RW6a0z2h6Wlc1YaxRCNTTh88XLs5H71qa
	 x3VWqnrgno1zRl/vYAsD+OVyqJjdhZtRQrSisa234FcWBPGivpN6K+yZiGAd1LCH8sQkrqOyKt9q
	 PA83pciw39FMxZzNWNpqmwbXBhVR8lHHbuHwndqk8gNExKhD8nvJzDL//+HSTz8gc+l0V/uuX/IF
	 sVwVU0AKPkFQaqFtO62JdWCxvB/g4wI/f1yaGNhUk+zEdWNyua5riNlkJ3TQ9qGiePSEu5KmM61a
	 1G8HkXwZZPHMOUlmYpEJkjAMBfIvSSW41+t7iqqDHTFr7rGjr32burNA1aRKJad/5Fg7yJ82qd1j
	 ypFYj/bE19aaGqh+D7EsozLIsR2tIh9BhaCj2a9PemF3/CwbkJJ+GBmu8O3+cHzFRAEWMqd3JG2e
	 y8Lk7UDixe7j5mR0mquA+eP3cGKFzG8VJUzs0NBfRdjJnHjCCNswTZhvhTwhw3h3+aKJyjatx0iX
	 9ENtrI+dKX4kUkDnMvAD+jFINbRpP1d9qbZCDp
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Wang Zihan <3772548978@qq.com>
To: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-um@lists.infradead.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	mchehab@kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	Wang Zihan <3772548978@qq.com>
Subject: [PATCH] Documentation: Fix duplicated words
Date: Sat,  2 May 2026 19:19:16 +0800
X-OQ-MSGID: <20260502111916.145238-1-3772548978@qq.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260502_041933_541843_37BF9096 
X-CRM114-Status: GOOD (  11.24  )
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

Remove duplicated words in three documentation files:
- "in in" -> "in" (switchdev.rst)
- "The the" -> "The" (dmx-reqbufs.rst)
- "on on" -> "on" (user_mode_linux_howto_v2.rst)

Signed-off-by: Wang Zihan <3772548978@qq.com>
---
 Documentation/networking/switchdev.rst                | 2 +-
 Documentation/userspace-api/media/dvb/dmx-reqbufs.rst | 2 +-
 Documentation/virt/uml/user_mode_linux_howto_v2.rst   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
index 2966b7122..948bce44c 100644
--- a/Documentation/networking/switchdev.rst
+++ b/Documentation/networking/switchdev.rst
@@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
 monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
 bond will see its upper master change.  If that bond is moved into a bridge,
 the bond's upper master will change.  And so on.  The driver will track such
-movements to know what position a port is in in the overall topology by
+movements to know what position a port is in the overall topology by
 registering for netdevice events and acting on NETDEV_CHANGEUPPER.
 
 L2 Forwarding Offload
diff --git a/Documentation/userspace-api/media/dvb/dmx-reqbufs.rst b/Documentation/userspace-api/media/dvb/dmx-reqbufs.rst
index d2bb1909e..18810f0bb 100644
--- a/Documentation/userspace-api/media/dvb/dmx-reqbufs.rst
+++ b/Documentation/userspace-api/media/dvb/dmx-reqbufs.rst
@@ -72,4 +72,4 @@ appropriately. The generic error codes are described at the
 :ref:`Generic Error Codes <gen-errors>` chapter.
 
 EOPNOTSUPP
-    The  the requested I/O method is not supported.
+    The requested I/O method is not supported.
diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index c37e8e594..7b08738c3 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -1092,7 +1092,7 @@ be formatted as plain text.
 
 Developing always goes hand in hand with debugging. First of all,
 you can always run UML under gdb and there will be a whole section
-later on on how to do that. That, however, is not the only way to
+later on how to do that. That, however, is not the only way to
 debug a Linux kernel. Quite often adding tracing statements and/or
 using UML specific approaches such as ptracing the UML kernel process
 are significantly more informative.
-- 
2.54.0


