Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE8BCFC29E
	for <linux-um@archiver.kernel.org>; Fri, 21 Nov 2025 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ibfn7mBD8G88qTHwmiSSUBpyhylgYk5Y/kKJqSpwQsI=; b=U2w4AT/AO3Rby3
	PkxGDHgL5A1lYYJP72VqYxpv4w3LN2pk/qAnRqoJxrBry53aJE9LmHjEB5hCK9cafAVsQVDsjuJOl
	vLaYsRCyQwi2+xI6Rtroi2EWQwXgXHP+eXuV3kcX4+smy7yY69NuMFRXuowZqEwpFBbqrY+CnXxsm
	JymAq2qpu+z+RdmuINoEqDBz9gnuG2waTCucpUCsBT2V82Z3YaxjB+nYmOdhiBlUC2RiSfaxWj7/b
	6nWDP9U0QZUm6TQ7b7/jiwS6aKV2WRAvTVgAkZm3LtP4ijjm0ORB5mzKKz18op6SNzwgI2x2C1WIn
	GTg4h7BlBPEeTPZGMzVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMWDk-00000008s31-0wmX;
	Fri, 21 Nov 2025 18:51:00 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMWDi-00000008s2b-0NxW
	for linux-um@lists.infradead.org;
	Fri, 21 Nov 2025 18:50:59 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-429c7869704so1992057f8f.2
        for <linux-um@lists.infradead.org>; Fri, 21 Nov 2025 10:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763751055; x=1764355855; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ibfn7mBD8G88qTHwmiSSUBpyhylgYk5Y/kKJqSpwQsI=;
        b=KtxjQMCFw+Hf9BN8N+6isLLOg0IK2BBgV+L1coetBAGgMWbAunUreC2nNZ0tr2MkG6
         znoZspwStf/F4Uir1ut5a8U4PRIvKT0AP3R2MeUSQRphkaabFSojILtv4rzGfPucV0ji
         D8WCikGrgehWPfSsUppcm4T4QUrwypwQV5irP4vaMKN3M+bedtv9SdM7v77jq+rfV+5J
         qkKGVBIIQFI9bmSbqVCQck7Hz4OSUkFgtsvdGIhAS10lcoB9dBQH25oSgJfbLMLbVAxq
         H+NbAEiI6v7oqlgJEW/LuUAzSMHi2OSzmbmHTdPf2URngCQZxjdGif+BsYhHIrYmEgsr
         UZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751055; x=1764355855;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibfn7mBD8G88qTHwmiSSUBpyhylgYk5Y/kKJqSpwQsI=;
        b=Obbjs9gs6xAv1PFnmCCVElN7iQrjY5gn1MUQklNlr42pyybLBAE+rTuDXlSRujhV/g
         UQcV+hqrwJWKnr1r5FlW/HhtzYANorhyMG6zZaVkeC5ZtahbJomcxVfYFMJxQXq4ladX
         mUxLB1bNf4R05ABYrOO99gTcoJ6SmPMJKmXEOtL5P42x/Z9BR/d5HfT1hgvgludD2DWy
         eLovyhM+7RR0xwUm6A71d9bCusj0JWvQI5mmkcLt87z3pt041en2E2DL1X2movOJt1ex
         aITo6rw3SdlUOyXqqbWKIUP508SDxON5vQuEewCPyi0JsRs0y32PlfdcUFMM728HbAqy
         fnuw==
X-Forwarded-Encrypted: i=1; AJvYcCX1hYR7LB0UixeMkddVjJJ/rxLyrIls9X2olMiWVc4p84ZnJb5GZpDEm9MOXiztNBLs6tGL6HXnQg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzsNMdgv+Ho2jH7xr3XXI1HHxlbV4FR2/el+EhSLmxX40Vfgskf
	t3Oip/65W7k+3WWYZW1XfWffxWqztj+xLLmwhVlBlWyZhQ02GGGdDpSqfSHgSXrR3oCjwBgG0xD
	yOhxvzsY=
X-Gm-Gg: ASbGncsysO1YG0dZFzPWeUvAc1Ls1X8g6u+WX56yukCNc8t+mHJwkrGDAiEo9tnaBfT
	VonencjvwWpo1RIPsB0AjM0sdBsuIiVCjyMdSKNKmt1q88aK3rWBKr4etVszz3IzY5tUAN0SZFD
	TsRRKzolISXwWqSmjK3IDkJtRMGYRbmYqCO99i8Df7AnhfSIFlZZZN+Hp0E7TKBplwVHDRbzglp
	Lnr5VnWFopLBTuGtTwfa3wRxVwCg8v8cZ6XQcePdHZWWhPiVNlE+Cf3f8nZIsNEUld+TcGzBeYi
	aHgAt0IoiQL+VC/W3lOwh6sxNTk6fj8ZtQieV60f+Garj3S6JyRLw+lTUEjuga+wW0f+umo9+F7
	JlOg5dsW56clwheLX8P1dmeLgCmZC7ZFEEyzgKJsZhK3EZD1mX5ws+S8OnJYsbfprst8yvtVI3v
	5RVBPFG61Ei9gXi/KfLVm4RF/u00TGQzKx1PE=
X-Google-Smtp-Source: AGHT+IHxEr/Yh7njaXk+mwYujoxolgcHP00SWc/UQYnx2ejCkcaeHIL00gnZEqf09doPvbBPesYlHg==
X-Received: by 2002:a05:6000:2c05:b0:42b:394a:9e0 with SMTP id ffacd0b85a97d-42cc1d27abamr3461896f8f.32.1763751055244;
        Fri, 21 Nov 2025 10:50:55 -0800 (PST)
Received: from [127.0.0.1] (99.36.160.45.gramnet.com.br. [45.160.36.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm12473639f8f.39.2025.11.21.10.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 10:50:54 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v2 0/4] printk cleanup - part 2
Date: Fri, 21 Nov 2025 15:50:32 -0300
Message-Id: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHi0IGkC/22Nyw6CMBBFf4XM2jHT8mblfxgWTTtIo5amBaIh/
 LuVxJ3Lc5J77gaRg+UIXbZB4NVGO7kE8pSBHpW7MVqTGCTJkioS6IN18x31g5VbPHoVZol5MzS
 mFNRQ20Ka+sCDfR3Za594tHGewvt4WcXX/oLV/+AqkHAoZK3rIjdG0SUukc96ekK/7/sH/Ekl9
 7cAAAA=
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
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763751050; l=2044;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=PRmdFpBAp0gKYH3/id9Pz+CPCxU1dvesvh01EHtKBRM=;
 b=BB4qSfzhItSvSkb4sdozUwQREO5JyqBCeTI4O6aM+90/NYaHuB2QnqOSN1qJltnW37QS3VMVc
 WAytuhobAlHD+BrNYQL4GhwMxYd+M7u1t6KVhQ+YfHsl6wR1PtaGGy+
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_105058_180768_9EB50395 
X-CRM114-Status: GOOD (  10.31  )
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
Changes in v2:
- Squashed patches 1 and 3 (CON_SUSPEND usage) and now is the last patch
  of the series, suggested by Petr Mladek
- Moved commit 4 as the first one in the series, and it was changed to
  use console_is_usable helper, suggested by Petr Mladek
- Moved commit 5 as the second commit in the series, and adjusted to use
  console_is_usable helper, suggested by Petr Mladek
- The patch 6 was dropped, since it was implemented in a different patchset
  (https://lore.kernel.org/lkml/20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com/)
- Patch 7 was moved as third patch, and is using the console_is_usable,
  suggested by Petr Mladek
- Patch 2 was dropped from this patchset, and will be included in the
  next cleanup patchset.
- Link to v1: https://lore.kernel.org/r/20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com

---
Marcos Paulo de Souza (4):
      drivers: serial: kgdboc: Drop checks for CON_ENABLED and CON_BOOT
      arch: um: kmsg_dump: Use console_is_usable
      printk: Use console_is_usable on console_unblank
      printk: Make console_{suspend,resume} handle CON_SUSPENDED

 arch/um/kernel/kmsg_dump.c  |  2 +-
 drivers/tty/serial/kgdboc.c |  1 -
 drivers/tty/tty_io.c        |  2 +-
 kernel/printk/printk.c      | 17 +++++++----------
 4 files changed, 9 insertions(+), 13 deletions(-)
---
base-commit: 887c7f05d40eb51ba3f38fd71d5e6b4aff4bb8a2
change-id: 20250601-printk-cleanup-part2-38f8d5108099

Best regards,
--  
Marcos Paulo de Souza <mpdesouza@suse.com>


