Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5E5C61CE8
	for <linux-um@archiver.kernel.org>; Sat,  7 Jun 2025 02:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=d8AB0D5JOvGYjX2dpcO3lbaRK+7xpSkRk0OO2w6sGwk=; b=ng0cu925OwOxv6
	aQZl0ATF8pys7J28K9qMevEhmqBzI0Cp60nEPnTULhO2u4qokGsEJ5plq16saO890bStjtjdMx4h/
	NOZvK0NzR5kJRx6DKTP6jYkHXjJ94YkRwI78WfBvPllgftAkUKwQeUbRIPrf57X894NsjOlIuVE+J
	mfgCV1zdWU3ko5FNz4ChkbyHDTwVRUV2Y6qsspeEMIAshqQXQtnk75/tyOVd126egcgSpmqA37VYA
	KjDBV/aVx/Pm49KJXOQFNuIMkjKMxTr5DRIKikCU/H5/1Y2+/RssBP2dd2fgHO7/IHXBoUedAPKLB
	XiWh5UpfFhqwEOA1/maQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjh4-00000001GYc-1i3C;
	Sat, 07 Jun 2025 02:54:02 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjh2-00000001GYG-0vTs
	for linux-um@lists.infradead.org;
	Sat, 07 Jun 2025 02:54:01 +0000
Received: by mail-wr1-x441.google.com with SMTP id ffacd0b85a97d-3a5257748e1so1869890f8f.2
        for <linux-um@lists.infradead.org>; Fri, 06 Jun 2025 19:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749264838; x=1749869638; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d8AB0D5JOvGYjX2dpcO3lbaRK+7xpSkRk0OO2w6sGwk=;
        b=AIF3YRROBK33gY0Jj+UKtMfnDFJWWgRTaPgOUVeSLb1MwqGReBjUGVqdAXxJufhgFu
         luy2lEljuRfJyJ/XplMgKDDKytCdthGPkH9xafayj9s3sc1pV1yPWr746dpz5ngA09AN
         INRh+5IL4T203qsTRQko5ED4uS3/H8aa/Ot+PZ/VYbw6wExi/2p7X34pav2lHu6SOtXg
         zNNqJPE9cS60pj1L9RRY6lPxCfCJV77g9ddaJFdn6EoIJJCybMmEruTiJuZJ4T+d///e
         0DDPq3P5aoELFVwPxdtx+UEJ26OjaSG0pwxZ8t0454eTtJ1+WDGpz6egOoPQOAdITKBc
         jMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749264838; x=1749869638;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8AB0D5JOvGYjX2dpcO3lbaRK+7xpSkRk0OO2w6sGwk=;
        b=ZC2V62Korm40QtPmBHA3lUvZHUWK70byBmAPPRB5RITtyRJssVHGc0H0ov7aEy/wK9
         zoE5KUZGaFSWYpNOpx6K9u0XZxRP44iaDsnPizlfsHHgj5+5aKKvoiTDwL9r+dWzhjak
         vrjO577NXgpYtQaVSF0BuVvEBmNjldjb7mYELS6Ion4stSBiYEMnVo3/RuUN/JFetZCe
         QB+1mEeMhjFoBM4KoRMS4Hzy0WjiAis2r45ypE+nWq911UWbH0K2JY1WmbqYo5MeV6jN
         ohq3W0A1LuK2MqUgdMVmJIf3iNIzuERQTlByKa2via0nNbqfzhVraxexnJCW6u8zHQx5
         5waQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr07So276nnC57L1yxXve2d8L/k+4pXMYgXGcFxvBm7/vV/HwU46wQjdcqUneC9e06bWh1/kRV6Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwscN2fy3mQ8Ai6z7uWfBF9cOy7nu2tl9FddAOgNIz7zSOcUxYI
	VRUu8ozE7S7ebI+DymuB6f5cPS9Q8sLkbppIkjWZ6D8kczcoDU0jmSgbsh6lJpcL8vs=
X-Gm-Gg: ASbGncss6UgpGKsxs+ZTndCW+ZnnD5H1bfrnHAzysq4jJ49M57JUa5wsNOQ0EeF4Pjh
	QVHscKlpFqdmm4Dd+ONleBUXIDMqXN7Wdfunv1UzRgy6sGufloGn76b7XV98e2T9HW46+4nxxp1
	YB4/Arwa9AvGgDASZGOh1ThnLEnLiVeHH7+NriOiCJQjiGytVXcPlM9F4NjD4z9XvGAicTLVgoU
	LRtD/eRQOoqBmbvDklig4OeI1mBEKAhnoUD7oO1AgXsNoMJbYTcm+16MGeEuxOzxpQXwVSpRuIN
	fzOWJiYpUCTNJIzAG8Q2ZoL1fgVLuuhE7iczbuRj0YYT6MRbQgTS0LEAsDw=
X-Google-Smtp-Source: AGHT+IHShYQtnCxYffZd53hg8+hhCGTXjO/OocFI6hhZSrjjpXUQTLeXH1KRlfClVKp1b+8IXy1o1A==
X-Received: by 2002:a05:6000:144e:b0:3a4:f975:30f7 with SMTP id ffacd0b85a97d-3a5319b4e68mr4801932f8f.56.1749264837970;
        Fri, 06 Jun 2025 19:53:57 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:80f:b600:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-530e6429475sm2005465e0c.45.2025.06.06.19.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 19:53:57 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 0/7] printk cleanup - part 2
Date: Fri, 06 Jun 2025 23:53:42 -0300
Message-Id: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALapQ2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwND3YKizLySbN3knNTEvNIC3YLEohIjXWOLNIsUU0MDCwNLSyWg1oK
 i1LTMCrCx0bG1tQDCWrwyZgAAAA==
X-Change-ID: 20250601-printk-cleanup-part2-38f8d5108099
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749264832; l=1540;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=DlBaewAA+ovTE7nzNZ0gfmioiWclhmgO3IlQrbrct5o=;
 b=uaTXBJLcvhgf5YKL4OJgFRYKVnwKvnF9HHj0A6a1DeNA/cKGB2zz4gtZcmbgnKD0ZnQ5jzr1u
 IL5jbxZWwPtDKhU0kF+79D2EX/S5HQyeZSKJDCeivyLlYkj/oRqQ8Gh
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_195400_274337_AAD7FABB 
X-CRM114-Status: UNSURE (   7.93  )
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

The first part can be found here[1]. The proposed changes do not
change the functionality of printk, but were suggestions made by
Petr Mladek. I already have more patches for a part 3 ,but I would like
to see these ones merged first.

I did the testing with VMs, checking suspend and resume cycles, and it worked
as expected.

Thanks for reviewing!

[1]: https://lore.kernel.org/lkml/20250226-printk-renaming-v1-0-0b878577f2e6@suse.com/

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Marcos Paulo de Souza (7):
      printk: Make console_{suspend,resume} handle CON_SUSPENDED
      printk: Use consoles_suspended flag when suspending/resuming all consoles
      drivers: tty: Check CON_SUSPENDED instead of CON_ENABLED
      drivers: serial: kgdboc: Check CON_SUSPENDED instead of CON_ENABLED
      arch: um: kmsg_dump: Don't check for CON_ENABLED
      debug: kgd_io: Don't check for CON_ENABLED
      printk: Don't check for CON_ENABLED on console_unblank

 arch/um/kernel/kmsg_dump.c  |  2 +-
 drivers/tty/serial/kgdboc.c |  3 ++-
 drivers/tty/tty_io.c        |  2 +-
 kernel/debug/kdb/kdb_io.c   |  2 +-
 kernel/printk/internal.h    |  7 ++++++-
 kernel/printk/nbcon.c       |  8 ++++----
 kernel/printk/printk.c      | 32 +++++++++++++++-----------------
 7 files changed, 30 insertions(+), 26 deletions(-)
---
base-commit: e728cdbeed0667b6261fceeddc91ef1420463ac7
change-id: 20250601-printk-cleanup-part2-38f8d5108099

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>


