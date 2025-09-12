Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007C1CA101F
	for <linux-um@archiver.kernel.org>; Fri, 12 Sep 2025 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1aqQsfYpqczFMN6xd995B9cIuPxzc6IeMNO1DIuGzJc=; b=lKZqwNsJtpmjyQpjWjcNkB3BQM
	6bc3XVjGFRrOTpEE2rdvDGlf1qETLsU086+RmohfDDPynfIKTE/DnQiLlxjWrsMXyrCK3fssE8OgQ
	TXEAL/yMLFx2zGlirJXRfv4Y5XBk/q7SPYejxk4JzxIh11Dk5lwNv98Dw8TkOdTz2xDmkQX2I3aAW
	zVYh8dOTJOqFt4cPIQm+jlpVQdmNh04xOFtd0EW4Wct6J9DYtAx8C9h6VrzS/QIAy+z3clEEqCwtM
	jnuFI2b6T3Ua0vMGnRTQBE0D4Ta7MXrp2tgZ6/IhuUqS6pfY/mhYm506AvlrCG1FeXSgX3CUNb/Zg
	kFCiSPZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCu5-0000000C10C-3DbE;
	Fri, 12 Sep 2025 23:10:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCu4-0000000C0z4-1tmY
	for linux-um@bombadil.infradead.org;
	Fri, 12 Sep 2025 23:10:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1aqQsfYpqczFMN6xd995B9cIuPxzc6IeMNO1DIuGzJc=; b=Vu4VbhJ5G+et+4G03sJ+6z4c5l
	gI1UA4kiKAo+v9kZK8dBJA9NLizWhEKo+1pPzT/r2Tfpyf1R/RgB7xU/Z7paobr6xQ0CMSep8tloO
	A0JCvy/mQPaxzHQZL4Wb8l+DRXo8srFK1PfBV33/w8Yw14DKWjLscKgtmJ617JaghrzE7xWsd2SpR
	42jMMme6L5LVqp/1HKQeMNMp4cqeYFYjM1+gxM/G+dVI/rI+S3PZe8xTP0uiKV33Lmv0YF1zGWWuE
	00TrPLoTCtY7lsdvRlaNOki0YiIgmQQGdMj259BhlGQuH7PsTHvxmxrvdj2QP+V3CHfdZUE8/F4ag
	Dpx3aA+A==;
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCu1-00000006TNa-0SoN
	for linux-um@lists.infradead.org;
	Fri, 12 Sep 2025 23:10:03 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-32dd4fa054bso1995448a91.1
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718599; x=1758323399; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aqQsfYpqczFMN6xd995B9cIuPxzc6IeMNO1DIuGzJc=;
        b=OiMf/fGpdswAPy7Bi0zhw2ty4Lx95HiKVI9982fC+KP2J+UzZgrrY/pWNMS2Hjud5/
         pcjYfGQw+5jQ0yHEWC00mp09RjpO3GMrKm5JLFQaFAVz0TXNa1mOwKr5k0Z0t9LIbpws
         E+9WhMLCXcMx/LwkWMN4SW6iVIlDuZNhwPyZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718599; x=1758323399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aqQsfYpqczFMN6xd995B9cIuPxzc6IeMNO1DIuGzJc=;
        b=i6eyO6fuhbi04G0eDJ/0KCkFtf52rtvJMNu6uPoxWbYmjhitSkPSnA03i4FBiJRc0G
         TsjVXMu4lhPm7TTE8SDp4oCOODyBKMZR+rj8wZMSBELDIKdUwt1WrjuuSfDvXaYolz3Y
         loqnTiiY3RAT/PWJiix1uRy3CVtvTLZz1uyqFLLIH3L5bVrnfZjkfeh6XX6L9WRhBCzM
         zK0eV78E2CGn35ifu1vXi0M4zSZUURlwCTuLftKN6VeowDw6koX8j27REw6P1eSyRaHz
         As9qlAl2vlkNrucyKcEKDhn9ndADwen0nO1XBwFoDhFSLreXYa6QngYzhwR+qdeCinyM
         T+lw==
X-Forwarded-Encrypted: i=1; AJvYcCViTjOkbgbICHJs5g2xeW9jQ/03nV58h+dwhFnqqBKbbA0p9TbkLCVNb2L9KYEAi362lUeGR6piKA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6wMlzKz1B5pZAeCMPagf/K5ObLVnYu9Xc3vAgNMqbbcjgUE4u
	Zp7GkIO/0NVrCSN6Tw7+XywZg1enCM4QqwylMb5WAMhEo9iJRv7mmfAbAZdYqBP22Q==
X-Gm-Gg: ASbGncs2ekwA3GF9zw+Y49FlKimyktaLe1wDIdciuWRXAUcj44Gzxr8CxPxHI1ta8pu
	D2e/KXXmjX6mquvihNYjq4+jg1g651A8/jsSCk3h4DEQJPXeK8W3L3MsOFg9A2PAp3Znvn5zUgw
	JVA5FunH/v/hoJDTNE2NAP0zaDoGJP1trOFbq39lSA42a+yDSHCE0QCrA5x/wQraVXnuV2Xjqlg
	jCqdxGbCu7767OFLqx6f2bJKfYyxTmBneCsD3R+mp40TxztFjaBdE9uHtzSnnX6In2Ai60KNU71
	YRO5rNZwc1hLfySvSE+9pN730sEeDkCSCYGlXLthyNLsk0DCrWOG4Y/IfFxp53ijY7BP0pK/ARv
	ZwwotjMmbAkXpOTtQHmbi8s35ZKXSfh7wHLZquFhHYNrjzcPIB/4+m9SnfPg=
X-Google-Smtp-Source: AGHT+IHahHShoB5Ii1WzvFIbd2LUrSYt+MXYAQPhHq31+WasztFuE5rlFSFzEb7dWV7UvuA2EIiQ1Q==
X-Received: by 2002:a17:90b:4d0e:b0:327:53f0:6368 with SMTP id 98e67ed59e1d1-32de4b88595mr5567635a91.2.1757718599221;
        Fri, 12 Sep 2025 16:09:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b54a35b7e31sm5643608a12.11.2025.09.12.16.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:58 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>,
	Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 4/4] kunit: qemu_configs: Add PCI to arm, arm64
Date: Fri, 12 Sep 2025 15:59:35 -0700
Message-ID: <20250912230208.967129-5-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912230208.967129-1-briannorris@chromium.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_001001_560593_8164DF4B 
X-CRM114-Status: UNSURE (   8.93  )
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

To get some more test coverage on PCI tests.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 tools/testing/kunit/qemu_configs/arm.py   | 1 +
 tools/testing/kunit/qemu_configs/arm64.py | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/kunit/qemu_configs/arm.py b/tools/testing/kunit/qemu_configs/arm.py
index db2160200566..101d67e5157c 100644
--- a/tools/testing/kunit/qemu_configs/arm.py
+++ b/tools/testing/kunit/qemu_configs/arm.py
@@ -3,6 +3,7 @@ from ..qemu_config import QemuArchParams
 QEMU_ARCH = QemuArchParams(linux_arch='arm',
 			   kconfig='''
 CONFIG_ARCH_VIRT=y
+CONFIG_PCI=y
 CONFIG_SERIAL_AMBA_PL010=y
 CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
 CONFIG_SERIAL_AMBA_PL011=y
diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
index 5c44d3a87e6d..ba2b4e660ba7 100644
--- a/tools/testing/kunit/qemu_configs/arm64.py
+++ b/tools/testing/kunit/qemu_configs/arm64.py
@@ -2,6 +2,7 @@ from ..qemu_config import QemuArchParams
 
 QEMU_ARCH = QemuArchParams(linux_arch='arm64',
 			   kconfig='''
+CONFIG_PCI=y
 CONFIG_SERIAL_AMBA_PL010=y
 CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
 CONFIG_SERIAL_AMBA_PL011=y
-- 
2.51.0.384.g4c02a37b29-goog


