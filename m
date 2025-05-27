Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0DAC54F30
	for <linux-um@archiver.kernel.org>; Tue, 27 May 2025 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5Fmt8agHYT6RbnGM8uoRnzQd9xqFGvmEIVzXJZdCcWo=; b=gSUF7nSwgzv2m5eHnzx2wEq/0E
	MKWK99uAAxSbDlQ93qubIsLyixSHEyldUNan5ruGq4bA6ixYLu6fuftn146mz99gFcPUjQOWp+Ler
	Hr7ERt/02/2u2PMcKqDqk58/qYW4sIlhslXtw6JX8XEiAdawhwsPme+Uc/FxXdCLabiCDVOrLC8AG
	4up/DqoU05dab0/EniTAosltLCDiB36mKGp1p43amJA7TOFTH47JcLfTyUC+q3ZN0mhR/5FTVZ2R2
	OBuwVpAdyMaLmpc5Of6boo2m0OF1R+5DCdUDLEmbvzKP/cbNaYAUtINKo1cSTLj27s+TgY1HCq+ZJ
	w7VIwAMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJw2s-0000000B2EA-29j2;
	Tue, 27 May 2025 15:16:50 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJvyl-0000000B1ZM-0aOB
	for linux-um@lists.infradead.org;
	Tue, 27 May 2025 15:12:36 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-23446bb8785so30120135ad.0
        for <linux-um@lists.infradead.org>; Tue, 27 May 2025 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748358754; x=1748963554; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Fmt8agHYT6RbnGM8uoRnzQd9xqFGvmEIVzXJZdCcWo=;
        b=JhfzNHnI+SwNm4lS/z/fZbzKbujKgIzwsY37OUIzjPMDPJrtPJeNChj0j9IiGrkfRT
         BWQLe2OxiXsDZhiAcmBYm+6vWYdwcd1eb/xaNytgcFZDpU6pXGI/slnMDlGF/gzzAS2S
         E6K4YbRXajV/qO2lFS8ObvHrdWDW/vNr/0s3DBth2hvJ32Lxesi+I2OJWx+gJYS+55B+
         3NhZeH4CIlCE6zBDaVwBGL5jSh7ADI2qqroo4rGyJ0DxgpRgRh/NHj06s+tei8mc5YvQ
         Dh+O82oPM0SxUlNW2tkc5VSSN2t1wcBr8ubEvyAiggM7J8+bwjaShxsHqkR4/TGN8HF4
         5vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748358754; x=1748963554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Fmt8agHYT6RbnGM8uoRnzQd9xqFGvmEIVzXJZdCcWo=;
        b=GQJ0VQYVH7A1CGT7dGmcPX8XeHhbzm2Hunuw7jiqt77RKbgEwTiEnL9HyQRXMWY1ow
         4moAeHlb6ZdI1Lo5IcjCcpOAJ3cOsPHWxu2mMy+GyiPBDP48+PSH0m6NS4IgshQCTaiM
         K3ZVLgGTBg3CWCmdbHdzv1ASyO6x+L3vscWixLTnvSXOfa4BdYCX1AxDxpv7tcHDInh1
         r+3G1sbq9nsMR9j6qsZGjRy4J+CZJuo/loYGsV4Ui7jVK7R1CbESASukE0DQD4bmAVkh
         yHN4VMFYOzAUjpoPdYwaLXKVZDCv0/1/3l7CMgsoAGKe0+shCQOcqCh3ZbN12VfAoUca
         gfyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsocYm/BEfzPeiByz5xuNtleNt4Kq+f2lS8wFHlMSrzNt2uoSF23UAjAEs/jSLKYlixeE47QbOKg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVBQ+mYRcrCR3gV12wRk7wbUEM5TZR62s9GPel1GdwQugL1SEz
	Y2aV77UFyLx3C/8yNUICusaEQNRutNxMgXV89Zf+M6T6EFoQU54WDH5n
X-Gm-Gg: ASbGncvdPwpX4qO2A3yGq2BLIYkp20/+VsNr9gMk7cuhXTkmxsDZRE6tlTOM7QABUNE
	xXiGz+30enfhuOyzicrAjqHf9+U6+kBQXdhaxf9FYPSICpPxgSZMOwuNJL6icj82LAIwTRVWoFE
	FviqY28rO8luNJS05dKFFMBgZ1ideUmraYJYs+qW7I80JIZtrkwP8NEKCVUNMsb5CzbWWtFxG+3
	uBZhBTi2RiH3f5jjsWKwyimxxK/23n5Pg1P2Pe0usWn3Jp3UhmfB1niO7cccLn7e0uFQE/YUUAK
	RjYsCaNjc+GCe+mfikRL8etu0JOeE6fhb1a9ndM7ZhwmsJ17qsuCqvT8htqKUZdsVojvDx9oy/i
	8/+saTTmbLUq/
X-Google-Smtp-Source: AGHT+IG53BzQgnPuTX7yS/ekoeG+gQeIY+BAQPv39+PEudE8cMO+ljYRQJ2b/zfrx4p8d2LSYQedGg==
X-Received: by 2002:a17:903:4291:b0:234:b44c:d3c8 with SMTP id d9443c01a7336-234b44cd695mr12284165ad.37.1748358754171;
        Tue, 27 May 2025 08:12:34 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2345c3bc990sm38181255ad.31.2025.05.27.08.12.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 May 2025 08:12:33 -0700 (PDT)
From: Yonting Lin <linyongting@gmail.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	tiwei.btw@antgroup.com,
	linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linyongting@gmail.com
Subject: [PATCH] um: Fix tgkill compile error on old host OSes
Date: Tue, 27 May 2025 23:12:22 +0800
Message-Id: <20250527151222.40371-1-linyongting@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_081235_179383_E6FAE322 
X-CRM114-Status: GOOD (  13.02  )
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

From: Yongting Lin <linyongting@gmail.com>

tgkill is a quite old syscall since kernel 2.5.75, but unfortunately glibc
doesn't support it before 2.30. Thus some systems fail to compile the
latest UserMode Linux.

Here is the compile error I encountered when I tried to compile UML in
my system shipped with glibc-2.28.

    CALL    scripts/checksyscalls.sh
    CC      arch/um/os-Linux/sigio.o
  In file included from arch/um/os-Linux/sigio.c:17:
  arch/um/os-Linux/sigio.c: In function ‘write_sigio_thread’:
  arch/um/os-Linux/sigio.c:49:19: error: implicit declaration of function ‘tgkill’; did you mean ‘kill’? [-Werror=implicit-function-declaration]
     CATCH_EINTR(r = tgkill(pid, pid, SIGIO));
                     ^~~~~~
  ./arch/um/include/shared/os.h:21:48: note: in definition of macro ‘CATCH_EINTR’
  #define CATCH_EINTR(expr) while ((errno = 0, ((expr) < 0)) && (errno == EINTR))
                                                ^~~~
  cc1: some warnings being treated as errors

Fix it by Replacing glibc call with raw syscall.

Fixes: 33c9da5dfb18 ("um: Rewrite the sigio workaround based on epoll and tgkill")
Signed-off-by: Yongting Lin <linyongting@gmail.com>
---
 arch/um/os-Linux/sigio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index a05a6ecee756..6de145f8fe3d 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -12,6 +12,7 @@
 #include <signal.h>
 #include <string.h>
 #include <sys/epoll.h>
+#include <asm/unistd.h>
 #include <kern_util.h>
 #include <init.h>
 #include <os.h>
@@ -46,7 +47,7 @@ static void *write_sigio_thread(void *unused)
 			       __func__, errno);
 		}
 
-		CATCH_EINTR(r = tgkill(pid, pid, SIGIO));
+		CATCH_EINTR(r = syscall(__NR_tgkill, pid, pid, SIGIO));
 		if (r < 0)
 			printk(UM_KERN_ERR "%s: tgkill failed, errno = %d\n",
 			       __func__, errno);
-- 
2.20.1


