Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F57CD3445
	for <linux-um@archiver.kernel.org>; Fri,  8 May 2026 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WT56FP1Bt4LcxLxZsWkK8+jNPLJAOL9nE1Hwe4/BncM=; b=yOdZqgYHgd1+H1+EmyRnD3lBrl
	/AJYKAvGrQwgRs4XyDswEG5wHpBlK3KRV3o220Q4E7hi3ISpaAwLbDAq8LgGa3AUB2BhfTi0ym4RL
	HPE5Xg2lQ1EjnTVzfDvkreBBq5OnX2y2BVvnciYHFUAeUra/CVxhXE8HP8AWFpWAO5GxBOrwEGPvO
	Jbb85IMQxDzbiuxMHkeLrsBJS53KVWVRJsv15RYyslsXnVq9m8a7+4TC9FaTQ1brQEFXB4Ly9j6ln
	us0/ypBlK5dPUg5X0/LuqW66cCbDqCjN1FcIgEwqtoTWTtI5FaW97qoi9QJNSStWvzw7B742TLHHR
	LR73AMJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLODL-000000070vc-1Vid;
	Fri, 08 May 2026 16:38:11 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLODJ-000000070ux-0GQW
	for linux-um@lists.infradead.org;
	Fri, 08 May 2026 16:38:10 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so15002595e9.1
        for <linux-um@lists.infradead.org>; Fri, 08 May 2026 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778258287; x=1778863087; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WT56FP1Bt4LcxLxZsWkK8+jNPLJAOL9nE1Hwe4/BncM=;
        b=Eg8MbLCAcd/M/6f6DTCY8AS79TIrqxvqnStv4tdYdntJ2ZsCpYzf1UgFpahnKqey3D
         CKouzywp3Pjdxj0xb1HU/ucr4sUWh4cQvPVkCfzHUs2v3yRgy/9iR/pYQwVJ8z8VcMO3
         JShvkOkXy/aPx7bWTkhal+ynGlBiX4lJqyPHfiNtUx25pdKAPo3kgwkViCV1nz3xpbjP
         iSMw9rbee8BSISIcVIaOAfQ3NNE/pF0BzL0Hf3E1g64HDfYI3S+HfxSdAVv4unR+HsA7
         4KvvdQ7SlOAdrQKARCVZNirxXJNepVK000VugUniw0c3TofsQElpTmxUUN5Qq12pNm+O
         29TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258287; x=1778863087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WT56FP1Bt4LcxLxZsWkK8+jNPLJAOL9nE1Hwe4/BncM=;
        b=MbtgdRaxM1Me3g14QViGBlow32vvJMr3CUcD08Egxm2ndUWeeBZKAGBYRhWZKnNeWr
         vFlLmOuqkRNkgs3dhlvT8dCOCrg28nA+qR/CwU9ddtJZpCe81+oxSavQ/g9m2sPIz84I
         6p4DiCoy5iJoOKYY0BO7MsvmEn7aT1Zj0SDVYocybPaMoSAEUACTx5N4uqnDGrjnR9zI
         irEkleKLzHTNsUBil1yqiird++UwYQTo2USeQSzEquHAv0b1FgGzUmEhSgL1b9iLBqef
         AiRPgNP/MQTlrlt9pLBmW9AD2uBELqOwlfga3OZuBirmC1GjcTajZjBqZ0mQeSuBlRgI
         IUdw==
X-Forwarded-Encrypted: i=1; AFNElJ+AV+VXmXLpFqnItr4TW5Rdqizz/y61sgu5Hst9d5M21npJ9CS4gMfGoSUsMo+UL8J80aIi+wyJgg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyEmt8+dyzy8qIQ5RHd4+me3kpi1ATjSzKv3hqV5OpviRb/y2vE
	+qGvbg845P1HTKkgs3leOPnm4Wfn2AR8L5HXnPaSe+XiJ+CxlrL/J0aW
X-Gm-Gg: AeBDietrqtjflPW/OT9ZfJOdDhaqvlrqdBTvWKYXF4APjKnQ4q2sOOE1LopCOvHXSAU
	w3WEo9+xfkl1WFcb3OfJ7CSFDlk5g5eWVgNay6nX5dlk46nBi8OmNTB/zMqYK59gpkLrtNWIzeb
	XxX0gGyHe/N4FzCA0OAJcxP/+V17YzKYHu6ko/E9wlgEsU+b4E3i4LA0ZfNI4FEdMl0RfmUD0rP
	ofhjIzyrPdol1h7161c8x6rDvfTxku2PJqf+95BLk2uf82KA3srTDS3aZzwyzyD2dxsE4iiRYXi
	fkWUArt+eIV6avc0XbGhu6uSJmCm3fpapM711njbRefaQ78+VcDBizTEYs4zghEnwq/rVAGv1U/
	pnW7gmYUHUhcLn190Eqi2ljvNCIioUbFGH/oRbCx7uTxjUV8qwCNQ70cA+hSCLfkxUoejWXMJWk
	2A/QIjNLxWNtx4PINWsfY0EtDJrv5xxleqaykjZLnV/IBxTVVN7hS00VA/fcB5cJP3kIw=
X-Received: by 2002:a05:600c:3b8f:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48e642deefamr69130145e9.7.1778258286363;
        Fri, 08 May 2026 09:38:06 -0700 (PDT)
Received: from arey-arch ([2a02:1210:7298:ec00:73f0:d2e7:188c:1f61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd32afasm6901045e9.5.2026.05.08.09.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:38:06 -0700 (PDT)
From: Adrien Reynard <reynard.adrien.08@gmail.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	kasan-dev@googlegroups.com (open list:KASAN),
	workflows@vger.kernel.org (open list:DOCUMENTATION PROCESS),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML))
Cc: Adrien Reynard <reynard.adrien.08@gmail.com>
Subject: [PATCH 4/5] docs: fix repeated prepositions across documentation
Date: Fri,  8 May 2026 18:38:03 +0200
Message-ID: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_093809_123248_3BBC9F5C 
X-CRM114-Status: GOOD (  14.53  )
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

Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
---
 Documentation/dev-tools/kasan.rst                   | 2 +-
 Documentation/networking/switchdev.rst              | 2 +-
 Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 4968b2aa60c8..3a8bd40ad905 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -392,7 +392,7 @@ reserved to tag freed memory regions.
 If the hardware does not support MTE (pre ARMv8.5), Hardware Tag-Based KASAN
 will not be enabled. In this case, all KASAN boot parameters are ignored.
 
-Note that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
+Note that enabling CONFIG_KASAN_HW_TAGS always results in-kernel TBI being
 enabled. Even when ``kasan.mode=off`` is provided or when the hardware does not
 support MTE (but supports TBI).
 
diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
index 2966b7122f05..948bce44ca9b 100644
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
diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index c37e8e594d12..7b08738c30aa 100644
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


