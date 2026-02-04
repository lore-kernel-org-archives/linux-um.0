Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACA4E8B38A
	for <linux-um@archiver.kernel.org>; Wed,  4 Feb 2026 02:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MnR/gEo9MGuCBEtorpEkbpSgfKcb44tNNZClRV3Eflw=; b=HFQTVAG7unHfSdwDo8YRVANepi
	cnEGFMByaC/DUdf3v6A4gBu6xns1/E2ZWc/0lCItfB/HUDM1IOEvHY/CeC2rGpU+EhVK5EUR+pd7Q
	Mat54xYHvkPIkWjzjgzJl/YjNQSp0B3RNW2VmkkiQiBccVvU5lrma0Rexrl+Qn8YnLDUF1G1gQ6A3
	IdTGfPdoK8OiI+GD/TdB6n/Ff2Sk7UqpU2z5yP3DDB8oTiGQbEcy0oka4gIoVd1MAyKTpOfE1Dvkd
	2HsViTiaNT4q3WiAAF4YpGlnuFDw93nXvcogFiiEGjSoSm//wqLZIZDlLfEeY4c3fi2GnDhvhG0C4
	nvmG5gAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSdC-00000007mFw-0frP;
	Wed, 04 Feb 2026 02:28:38 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSd8-00000007mCY-1RXT
	for linux-um@lists.infradead.org;
	Wed, 04 Feb 2026 02:28:35 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2a78e381fc1so1394865ad.3
        for <linux-um@lists.infradead.org>; Tue, 03 Feb 2026 18:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770172113; x=1770776913; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnR/gEo9MGuCBEtorpEkbpSgfKcb44tNNZClRV3Eflw=;
        b=H+ADOeI96UTZs9FCjQUn5qPQhw2EdsLsWRwiU3YZ+j/o1EeQNTz8KlwkBzDhBcIl6D
         b4drf0jhpNNZv2dwDdyKrDZ3SVpL29PjXWycdo0mwOD4vyV6KVqylsrtyXiP8Y6b2W8F
         tFWpu4ypuYXEgIigCCJuDwYrEEZ+3UyRU0qBUq/nM4Qq1bmTOEK5qdeNBIDSze1z9Zr/
         UhHvZgAF9HKm97A5oRO8/DuKRlL3YE8xP4h7KGiaxTjNpyYNxScHZCidPe3KcqRm97Eo
         zIJEZfRTmshRDCpAWrEhez528sVy2X4q9fQePbLc6kyAAJbPVpFtNGkaYi33hq9X8Z98
         RoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172113; x=1770776913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MnR/gEo9MGuCBEtorpEkbpSgfKcb44tNNZClRV3Eflw=;
        b=YZMu0gBc3WoZRjsb52H5OMoAHVj/1uSc2sBwIbXJa6Y6AYOP0j0Vb58RV3jRtX9Ynd
         68HNoKjy+DzIzTdMadmVW3IfnPURUHxnxA3LSWoYsveo9lI/LQU5g1Uk7n0hmOmvJFd3
         ZeRb/3UlSmjPeh2zGrJRjT4PfoLAFZYcP40DYXDEuvpEamuw6IulWtLGRVJN7COtvPT9
         AwAz4UkCOwr95GYFsjfpHIINawZnJ52Z86Ne7a8zNdt1xS3NQr53SSpcis5B84+COfZY
         XK80qzltmHdj31XBcT7lJ5ZvsGi17TiRXTcjt+43pQ85wvDb9PcK5XAZD1QJ7ZGjmAQ1
         jjKg==
X-Gm-Message-State: AOJu0YzL1zuLdaovEZ1tQar9toqXPDaa5V2JnSlfwFpLVDrmrtc58bRM
	rJrupNgbX9y2ZXMkP3d1RBeFyNFXGJfOLuHsT9e98urtfSA0xELyFYOu
X-Gm-Gg: AZuq6aIV7w0cta96u77IB77eFhgj91YShtSriAmvdduDJ+hHGzBCKHuPbn2stJjyGG9
	Gq8jFQxte3S4zNpXvPJVDkdeyDHeXFz2YjprpYjd2wfOsUOkLSpp21/2gOLyJ9AFtwiw51y3OvQ
	edI7x+sjNJ+mAhbPi6iMDe6SB/0AtSvFSuuIQsvRbxqP3abt3EFG+KFqXWANs9cQoioBDXLAx3y
	yf4PwendHa6uRJf8RhllEPIBDyRgvkLwTqp3blSTvJFMUKxX746EF67p/fK5f7qSQK29Y9HV9Ki
	FH/4sKNDKn8yE/5ec1XuF6Jn/Bv06vRnhCqr8Yj+MDslRbRni0MxB60pvIfJ44L+MfwDU6Q1Yu2
	xvLhOL5ujKv+/on5tDmY/tkDLHFg6pGDja+amyGMOjXeN7Eii+K7NbSJD73C2N13N7XGexPZr/t
	6A1D4fmW97EeUwTVxGlfnzWm6/tMT59nUSCy1a/9sQyxDNF0YK5AJsQ41T7wyfuw6FDLSCV/sr2
	tj8rycMZ2n9lye3
X-Received: by 2002:a17:902:d546:b0:2a7:6cd5:b48 with SMTP id d9443c01a7336-2a933e68d37mr16320995ad.29.1770172113431;
        Tue, 03 Feb 2026 18:28:33 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93394e387sm6829065ad.48.2026.02.03.18.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:28:32 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id BB5B31200C43; Wed,  4 Feb 2026 11:28:30 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 10/13] um: change machine name for uname output
Date: Wed,  4 Feb 2026 11:28:08 +0900
Message-ID: <62314a61fd98febda7aafaa746f00eb0b16d1180.1770170302.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770170302.git.thehajime@gmail.com>
References: <cover.1770170302.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_182834_385609_78420925 
X-CRM114-Status: GOOD (  10.63  )
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
index 5e9bf2a8aa6d..3393e0262888 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -151,6 +151,12 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
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
index e3ad71a0d13c..5fb26f5dfcb6 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -64,7 +64,8 @@ void setup_machinename(char *machine_out)
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


