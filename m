Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2110C61DA4
	for <linux-um@archiver.kernel.org>; Tue, 14 Feb 2023 23:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IHpM/AETRR4lSkeGgO4yqHjQJWGrm2+dxorysWzn+Hc=; b=SXvFM2zT2z2S5U
	XeWWUULXWEwoa0pPU/ZXoaijPbxGXU4X0hg1ZWpm8UQWMcjGH0Z9EYKo8DZeUF+LlzQDPaP7FVayD
	+MXVMY9xD6aaMwhlhMnkBqhCZ5lM1PljoZZ+0xDX8r8V2T2g6RPjEDTFQHr5dOZmXRigTM5EuhprW
	F1723bMKuqjHIUkjhHGQIYT3UPiF+RTmhBrmufT7wBjPOsxQU9MyzoknhSziamt9deIL+9D5K7wF4
	Kn1eEEQu10GJRZHhn0MR3VwyO9Gd4VTPfdaO4ThMoTe2YMRZ805HaAsoiq+SN/xALWaZRWI/4JRt6
	20eRddLANatCAcgzeS/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS4rQ-003vEZ-JL; Tue, 14 Feb 2023 23:37:20 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS4rN-003vBd-5O
	for linux-um@lists.infradead.org; Tue, 14 Feb 2023 23:37:18 +0000
Received: by mail-qt1-x830.google.com with SMTP id 5so20115168qtp.9
        for <linux-um@lists.infradead.org>; Tue, 14 Feb 2023 15:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zg4de6XrxIOmYB/qF3280zp1SwjDzPXQhDufFUg8ay0=;
        b=sIxjQFKpuMyyY7q67C9meUp2shnPHnFhnPNB/UP6nZyT+wzJaTUxgzXuqjTktIqPrX
         5DaiXekllsVeROa/WDSVKJFxcpSqKHz5pDrVdzRph+shbVE8C3OVp/hzkHrLGXRPkiyB
         v3M4jFlU/DpQ2c6GxXW37V0I7qglTD5t3VG1IqKU4O0wbcbwjUUa0HMGakonSsS2apwC
         1Ea6OzgYP2trbvcaf2rEZZXjGKkJEX0c66+Ti0Rd0W5AJcFzp6ENag2S9b0105igZ6H2
         wd9hZSezGuA+S2tnBI1VCHazDICJgHBt1BjsNsUBWMEFxLMh6Oymi4XgLkfFtau4pY5W
         UqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zg4de6XrxIOmYB/qF3280zp1SwjDzPXQhDufFUg8ay0=;
        b=QZ/WQ/3OLIP2WsPF5KlgLBa+1m7UBaOX/dOjCzHAPmMpW92F/MydjkiU2XSeEEGdY2
         rufuEDGZdT9NA6ge3bNB/g8ocalnvBNK2ZajOhyJNRemZVF0u5jKMb4KpLYkEE6HbNGG
         YFOzQMhtNXoMOp5iYGs2WN16R9fDT10cFME1J3ih/g2uXn+gJbHpvAcZSLD/pTn/KPxt
         uXh64U+iQQTruq/Lcev6r0AP/XWyT6PYbfvGKzXkJ7hWQzSIKsu7gyR9QXeIXXlmZBdo
         eqdXOGGtzsjg7R2vFvihj7vyVNFGr650hD/3po6ZsKNFNJdlfvbcLPmjXQVtmG6cxbEB
         cFBw==
X-Gm-Message-State: AO0yUKXphVMqkrjKXmIWwi8M4xKMnrGppQ23tsXghZ8rZFDQcRQF6HmO
	Nj4AAYu5t/hzAEcaDMgV4VBhcX3XNdqY6GU3
X-Google-Smtp-Source: AK7set/aCS22y+GpJi2bhsvKHcmE6UfhR4jkg8crm2jIbUGzxFfz6s/I4pgixkZ39e8SPNeqN7FFIg==
X-Received: by 2002:ac8:5b92:0:b0:3b9:2b0:5e7e with SMTP id a18-20020ac85b92000000b003b902b05e7emr221173qta.27.1676417832392;
        Tue, 14 Feb 2023 15:37:12 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id d7-20020a05622a15c700b003b7e8c04d2esm12310262qty.64.2023.02.14.15.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:37:11 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: Glenn Washburn <development@efficientek.com>,
	linux-um <linux-um@lists.infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: [PATCH 0/2] GDB: Support getting current task struct in UML
Date: Tue, 14 Feb 2023 17:35:38 -0600
Message-Id: <cover.1676416728.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_153717_414997_58F6D64E 
X-CRM114-Status: UNSURE (   9.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi all,

I noticed that running "call $lx_current()" with the kernel GDB helper
scripts was crashing when running in UML. So, I've fixed this. I'm not
100% sure this is correct or covers all corner cases, but I've done some
minimal testing. Perhaps someone on the linux-um list can review/comment
on whether this looks good or not.

There's also a trivial indentation fix in the same area.

Glenn


Glenn Washburn (2):
  scripts/gdb: Correct indentation in get_current_task
  scripts/gdb: Support getting current task struct in UML

 scripts/gdb/linux/cpus.py | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
