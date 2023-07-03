Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234D6EB64DD
	for <linux-um@archiver.kernel.org>; Mon,  3 Jul 2023 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pmetjv/f2VyLNyOwCbaPk9wcFRxFkriZuD5rfrd5o/U=; b=AAJxKRfdFvvGFz
	OC4R1XdcWKWKIUmVDNwCj5W/9FhjwwxKa/oe4z4h7vIGROnxF0HWgjPIDNDZ7EY6S5IxT6mQ+blf2
	gGyZZSLVnonN16whtwsjtDJYg46fen8xnGfMki4z/CCdYl5R4LqZ0MmaZ+PcJtlavZz+3xmW6faWm
	pIdM2cspe/lwMEpSmvMjlgXQT8XE6h1P2HI0ByQ2e9febonTI5w+/SfPvI0oPa5o8ISBImvffGcVT
	RUwAu+ieNK0tgXCNrfBrPV+gi0dkDMbxdcz+aZecb/k8LYKSWaRI7/Y7UIw63g8S8G/+jPHrSOsp9
	RehOYm3lZzA39JfymTpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGM4u-00AwPw-2l;
	Mon, 03 Jul 2023 16:07:04 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGM4r-00AwNR-1L
	for linux-um@lists.infradead.org;
	Mon, 03 Jul 2023 16:07:03 +0000
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7835971026fso186362439f.3
        for <linux-um@lists.infradead.org>; Mon, 03 Jul 2023 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688400419; x=1690992419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XBgsg73vfcfpxpvplcZPVuxEEYtarzD8ZTzO1oit0Y=;
        b=pZf/pW1HVY7519wBp/TXZgywkPiZqjv+/84lT/jbDTW3z+eo7zbRhZz9oIJ+XX9eky
         dH5+U3Y809G+J3F8tSRbBF8aa9jCsOF9fafygVVyF6siZhwAejXPCRPSmUwPRnfZ2EkJ
         iSkaL0h8Y4uDz68d25P/lGFJXro0bCUkt1NQ71V1mBB42FvTHLMTSuOmuuqncmxYhOD+
         DtPLxCdS4IdquAgmpl+Guy8vBEf40UoR4xSWdamXfCUI2FVsG4Ee1ny2h/68Q0xDHjV0
         kLJAKf6ewmRMG5petrdzoO2rMjRbcYIERqKFyxL8bq473DTT+qrVdsW5U22+mCQfriUY
         +txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688400419; x=1690992419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XBgsg73vfcfpxpvplcZPVuxEEYtarzD8ZTzO1oit0Y=;
        b=lfG9+96sT8DYz7aOUkcyVxYyMj8E6qHFD/BlJv3zvU6Vy1EGlFJPKVxA+Waot2W4mn
         CqU5vnSA8vm/YECeUCLdLpWZi+jtJByd/j6pm9weFJ2ewAKlDPEQXPXFqYjL2g8+xgTc
         avC0dSO8rlNGEU1bawx7iFhxBmIcVgUU9ZjjKLroOqun4srSslFmv8cDS86heQgsHji/
         me9zMGUTZr5F4c51yKp49Oz0P3GcgKH8jFSps9LBlYAUdOLJtcwt5qU4s98g5nCVrWGD
         ueKQlNqfAX9cyGC11DolpZpMb1V8u1NMyt3h/a+XAeNz04PBFRf9t54lIMzsiSfi4fbz
         Lcaw==
X-Gm-Message-State: AC+VfDy2p5/AZtFknkomQWY+EOFlaHyfpGcr6BnSRXUg3jZrrzp6sZ4w
	9hFlSMyyNzsZ7g/RXdHBivY=
X-Google-Smtp-Source: ACHHUZ4eTaCX/Uf7PO4YEGe29tb5DCx7JVB122+zEXfUxscjYX8gmyEhHlAVa0Ypb9J6vm3ETUWKYA==
X-Received: by 2002:a5e:d70c:0:b0:785:d06d:7b04 with SMTP id v12-20020a5ed70c000000b00785d06d7b04mr10641511iom.1.1688400418947;
        Mon, 03 Jul 2023 09:06:58 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id q15-20020a0566380ecf00b0039deb26853csm3760963jas.10.2023.07.03.09.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 09:06:58 -0700 (PDT)
From: Azeem Shaikh <azeemshaikh38@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-hardening@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Kees Cook <keescook@chromium.org>,
	Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] um: Remove strlcpy declaration
Date: Mon,  3 Jul 2023 16:06:41 +0000
Message-ID: <20230703160641.1790935-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_090701_453146_DD54A774 
X-CRM114-Status: GOOD (  12.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 arch/um/include/shared/user.h |    1 -
 arch/um/os-Linux/umid.c       |    6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index 0347a190429c..981e11d8e025 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -50,7 +50,6 @@ static inline int printk(const char *fmt, ...)
 #endif
 
 extern int in_aton(char *str);
-extern size_t strlcpy(char *, const char *, size_t);
 extern size_t strlcat(char *, const char *, size_t);
 extern size_t strscpy(char *, const char *, size_t);
 
diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index 7a1abb829930..288c422bfa96 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -40,7 +40,7 @@ static int __init make_uml_dir(void)
 				__func__);
 			goto err;
 		}
-		strlcpy(dir, home, sizeof(dir));
+		strscpy(dir, home, sizeof(dir));
 		uml_dir++;
 	}
 	strlcat(dir, uml_dir, sizeof(dir));
@@ -243,7 +243,7 @@ int __init set_umid(char *name)
 	if (strlen(name) > UMID_LEN - 1)
 		return -E2BIG;
 
-	strlcpy(umid, name, sizeof(umid));
+	strscpy(umid, name, sizeof(umid));
 
 	return 0;
 }
@@ -262,7 +262,7 @@ static int __init make_umid(void)
 	make_uml_dir();
 
 	if (*umid == '\0') {
-		strlcpy(tmp, uml_dir, sizeof(tmp));
+		strscpy(tmp, uml_dir, sizeof(tmp));
 		strlcat(tmp, "XXXXXX", sizeof(tmp));
 		fd = mkstemp(tmp);
 		if (fd < 0) {
-- 
2.41.0.255.g8b1d071c50-goog



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
