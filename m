Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76874CAC59A
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 05:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=; b=TDdZTuPcblZMY1NZHaRhVvKp2T
	J1oaEONTFXPUgkoq5qEaPEsGqNaA22HqGpf4SvsrCJp4t4R1wFOgIDMREt5DT88Meusy/xaeDIw9A
	zGX5iHoabMplXZqp0Wq+t0QFgoV9G4QiQiVxRQ+lcoWPHV+mil5+dnSinbVMrEoFLZe/r7+d3POOt
	KAidjs29c10IFiq7gBz0o8R3ETsRRRT/wQW0YcGOQo+d16P9Q/5vZu02jc72lUSP07XJUwZj72tzK
	JMvF+UDLRPm8ASTFBdGIHv3PX98sX8Sh/v/QugApXP0rS1yAUlquGHTnYavQuTjuhFk3pvOqZzVHY
	v367iODA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70t-0000000GIS9-0xwB;
	Thu, 18 Sep 2025 05:16:59 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70n-0000000GINR-3jFR
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 05:16:58 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-b5500891f00so237353a12.0
        for <linux-um@lists.infradead.org>; Wed, 17 Sep 2025 22:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172613; x=1758777413; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=;
        b=BPcLUmZkHBuOuszpEcZVgKyYGc4xkRFTjNb+ZQ9KC7GP+EeTVGcYtzjTyAr+AQU7Er
         NgKRDoE9E7sXVhgRuB2ck0HIweDtSrrA56CYKjyA41EGMAjnFqMfnvJPxOVcBeAKaw7d
         tAggGlNosUK4IyZeqxrT+e6+uMcJKtB389CEf7r53Mgv4V1wTy10S1LoGM3kPzl5oFY6
         gyvjfTrDPKlGBwhGBccta1lxfGHOutJo8yMFTspfR8ynFM74h0Xa/0EBQxF35Tr/5fra
         BVo8rXdsXkW0H8Q91rXeIQjWkGD38HTCaDYrm/9ojpgOyJqQ8R45G/eqnp3UjqbIFkGj
         SE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172613; x=1758777413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfaLR+xtvYbSj0Yj5pLhRxT8PrYzixVb/sw/K5Eb4uM=;
        b=Ww3LpFNtlJHbwIe2r24su9/M8VA64887nA6Rai2IDb+gRFHqRZos7hlCfeUysVsd/B
         /iNTagSHvWg3AUNSYwT3dsV1s7fF4XRY9f2EGnoD9Kuof4yLEGKzn/lboYqQmenyno1J
         s6vI/XVLZwScPEVxoIC1rRbD1MiettnQ81zufjYOugIk4jWD/8L1OhuLMkMC07y2muRq
         /4eYlnqLWTAq6mLBKOWBe4qLeraL+I9C8XfB+UoEn3osj2K1usq70+2/sLvPkZ4eeTJ/
         JFFQjZk9cWe35ynRJyqUsmGmdNHSHWBtgIM8UIb/ukj2Md0JVbVbhZRCHK69rOwMdDQh
         1KyQ==
X-Gm-Message-State: AOJu0Yx59jQ0Yj2VbuGRLSORiTVXmY9RnqTPa5uvMt96H0YxuyGnpBkk
	As+gRP6hisHUwrJW3eCY/3TEb+g9LHXcK89zFdRwvF65fCH37clPECjO
X-Gm-Gg: ASbGnctrlRSCQbUzSL+51OVGoiEC7G2NiDWvfN4dz8hOUVKGDK4qxXX/oJhbRkMQRCX
	Mrbfz/6zw0T0D/FK3LdEl6JApGgZfTQXejDncG/kYhd2yOt4arXHblJnBh4THVzv8nP+UaaOILs
	JNUg9gBqjgzyTW+UccQ5DVUlNWO+UKpZQpk7orPPB9b9wCSyyoe+CERVlF+mhYL98If92X+fQd5
	EvUbibKK/3DS5Hj/LRxNuRQHNAn8M8do2i2CW90gzcPR9XfBFHaSkuG9R00YvDhAtblOlmQsyT7
	2/E43UfeJTCP+Icra6vATk1S/UrIhIWj5rj3fletLV9bmswULDTwa8EkwKMqBWcJ8plEJ1PCEmU
	JWcOYBPfk3XeZJhh0qc6OfxPdhT9S0CTmoxBKOX3YJFtkzJNjN49zlruJxEy5UaZ1TSPU4eLSqA
	OuEQnacMrRgzY=
X-Google-Smtp-Source: AGHT+IEifDbjgR7s6TwejGaq1ZSUhh2KXIkEFHyaKhNV1A4v7AfhWkkpamL+EAMom7TUh85CJvEh6g==
X-Received: by 2002:a17:903:2345:b0:269:6401:7fdb with SMTP id d9443c01a7336-26964018c43mr56230345ad.17.1758172612995;
        Wed, 17 Sep 2025 22:16:52 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306064edb8sm1208993a91.7.2025.09.17.22.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:52 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 531001061EF9; Thu, 18 Sep 2025 14:16:50 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 12/14] um: change machine name for uname output
Date: Thu, 18 Sep 2025 14:16:05 +0900
Message-ID: <8e75e4e2116d25a2bd6065ed6b53e57b0eb0a86f.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_221655_826047_B5F6D50F 
X-CRM114-Status: GOOD (  10.41  )
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

This commit tries to display MMU/!MMU mode from the output of uname(2)
so that users can distinguish which mode of UML is running right now.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/Makefile        | 6 ++++++
 arch/um/os-Linux/util.c | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 5371c9a1b11e..9bc8fc149514 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -153,6 +153,12 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
 CLEAN_FILES += linux x.i gmon.out
 MRPROPER_FILES += $(HOST_DIR)/include/generated
 
+ifeq ($(CONFIG_MMU),y)
+UTS_MACHINE := "um"
+else
+UTS_MACHINE := "um\(nommu\)"
+endif
+
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 4193e04d7e4a..20421e9f0f77 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -65,7 +65,8 @@ void setup_machinename(char *machine_out)
 	}
 # endif
 #endif
-	strcpy(machine_out, host.machine);
+	strcat(machine_out, "/");
+	strcat(machine_out, host.machine);
 }
 
 void setup_hostinfo(char *buf, int len)
-- 
2.43.0


