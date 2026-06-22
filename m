Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E9DCDB46F
	for <linux-um@archiver.kernel.org>; Mon, 22 Jun 2026 12:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GGaHlJZI0vCQSUxuwTTR6AioiUbLtcDhm8SXi6UjURE=; b=pf7e/5wEGVfhMUkk0Ar2wzthYl
	nsUP8X83HbsrZ/sCqS9n0y4XGo9or5iC52sNFUOOgh7mi2m7oGzWybdwCGEECZ6PEzkX2QhuY4FTU
	MV6MPNFhqEeeop4HfggNgHzCrhFf8AR5d0rBaUNhx+LrFqQmshrDKrNLZHTR4H3V9TXS2t/UPjkn3
	vILaBeUO1teKe99nAHozZy288lZ8KpVgUMa8sgNQl70BTqL/w06cfMv25cGmW428DusLaS8/kNEaV
	9FGYbsXAiss8Ep4jaeg4gqsy0TNOXin0v7i0YY+Gc4OM1s59zEZYP9emhzchZ1Gz2zrzsiW7kSTsN
	XYXQw1cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbe3n-00000004yfc-1GBw;
	Mon, 22 Jun 2026 12:47:31 +0000
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbe3l-00000004yf2-1iPQ
	for linux-um@lists.infradead.org;
	Mon, 22 Jun 2026 12:47:30 +0000
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-922e181f199so134323185a.3
        for <linux-um@lists.infradead.org>; Mon, 22 Jun 2026 05:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782132447; x=1782737247; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GGaHlJZI0vCQSUxuwTTR6AioiUbLtcDhm8SXi6UjURE=;
        b=PnnQYzXGWkoMXlfSFM0dxzglfszQk/Pql/4rMBaR0t0ynJ0/CDZpYGbolM3SH18L3b
         ywP8Ouwpjj6CDEyEQ8na0QMw5xQCvsV1ZYxZNiKjsfGXjW4hwGSoz2acl8WEsTAHrWgI
         WTKQq3GWCvLrl2gZMUZOQpmV+cvuiu0QwpmdK4zT96lr0Kfx0Jito3kRTWnC+Zfe65Nl
         XIPjjqLgrZGgGvsXZr9nVN7HOobUIsE+bLovzeDxzKZcVAC+nlF2hpKrbkPM1GPCxNdM
         bQRQ28k8Ay6fH+WlS7eKy2DlSN7GO9xqbusr8n+hsEZ2FgDton9OQ3+1loMNQgMCebRC
         8oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782132447; x=1782737247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGaHlJZI0vCQSUxuwTTR6AioiUbLtcDhm8SXi6UjURE=;
        b=gxFlMbWt57JKBv4UXi3v7A/QqTedYzZlAx3zu/uaesteUOew8KbV/Oh0PCI4lEz+Lr
         FsL5OenLeg0hBw60pC/4jU2fA/XA8R7zwlXv7cQMILRuCmQ1KoIxc6D6T+hFlfOum1DC
         Jcdjr1f+l7txN05BWCU5lWD3gPK2xRFmPH+XF1MiEmPy/kmHDsWdGjxYYv/K82stveNt
         V4PpsTQcVNBqcLjaHul811a2l11rhQiW/eNKNzYkgPWQmUXmIHjcfDP3PP6J3FRpcFU3
         KiqUKYhBzy0Ig9AeVwQELQh0aKx98RsjbtQ/wQJtm92mPjAug+iGQ7hNWnzSk3tmMLCU
         Oq1g==
X-Gm-Message-State: AOJu0Yyq3Z2e9cDGlWnlju0zEwOLwaVfDNivBe+0e64lsNgFvdQL/ujZ
	fAx5w744e8BSP1LjZXkWBhSpNKiKavh/kRlG7l+uW3FwUwGRcZdPy1qT
X-Gm-Gg: AfdE7ckqx8wWMF3EkOIUqJerLNB6eStzkx/2Hwk5TIpK9eQI3knucz0QmIH7p7pWQBN
	NB6at2jM+ahUnnGB8pWinYIYKppwLq1QAyUS/flykrVdwxR5+y5HWnETYs/tejY3ppZsdd9WS3E
	AKWUI2loeUbc0wI3JZRiLXnPu6x7Q5TlfFQoeRYKoVbR41gLRMgFK3HsRCZLxReWxh2ZnfqI6pR
	FYDk2w6fcV247HRgqS/OLVkM7+FBJ556EJ6hE8jY6V2cxb2o8Z2tI7lS3Ilqj0rKoQvwCIHs1m5
	P8gotX0kFyh7RkbndKPd8AP1jb7QrJ033ef57nv3HiHE48z/2dZxYJNVgsGDDMMa5enHTT3Iiuo
	R8ezZDX9R08H6yJuG44PCuiBDfEC3WzHELvHS7ObR4col4gkJtmwqZWSAqD3v8dAxZ7F7L2z7yx
	E0Gs6Mtz5Lg9Hdg00jhDPUfcmjVvXddhPpiKyQS6R56HBiPszAwRlp0+7HbmU5QYxSvFRmeElCu
	lRbqZx/AwD5Dh93apOSFp2tTS0ODYPK
X-Received: by 2002:a05:620a:258a:b0:910:bb22:d426 with SMTP id af79cd13be357-9209119b748mr2207051985a.33.1782132447374;
        Mon, 22 Jun 2026 05:47:27 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921d7f4b409sm923056985a.16.2026.06.22.05.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:47:26 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: vector: fix use-after-free in vector_mmsg_rx()
Date: Mon, 22 Jun 2026 08:47:22 -0400
Message-ID: <20260622124722.1694157-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_054729_485475_CD19FCA8 
X-CRM114-Status: GOOD (  13.54  )
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

When vector_mmsg_rx() discards a packet whose overlay header fails
verify_header(), it frees the skb and continues the loop:

	if (header_check < 0) {
		dev_kfree_skb_irq(skb);
		vp->estats.rx_encaps_errors++;
		continue;
	}

The normal and short-packet paths fall through to the bottom of the
loop body, which clears the consumed slot and advances the cursors:

	(*skbuff_vector) = NULL;
	mmsg_vector++;
	skbuff_vector++;

The verify_header() < 0 path skips that via continue, so the freed skb
is left in skbuff_vector[] and the cursors do not advance. The next
iteration reads the same slot, gets the freed skb, and frees it again,
producing a refcount underflow / use-after-free in the RX path.

Discard the slot the same way the other paths do before continuing.

Only transports whose verify_header() can return negative are affected:
GRE and L2TPv3 do so on a cookie/session-id mismatch (raw/tap do not),
so any peer on such a transport can trigger it without authentication.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Reproduced on a KASAN + refcount-full UML build: bring up a vec0
l2tpv3 device and send frames from the host with the right cookie but a
wrong session id. Stock kernel logs repeated "uml_l2tpv3: session
mismatch" then a refcount_t underflow / use-after-free in
dev_kfree_skb_irq_reason() <- vector_poll() <- vector_mmsg_rx(); with
this patch the mismatch is logged and the splat is gone (0 underflow, 0
use-after-free). Full dmesg and reproducer available on request.

 arch/um/drivers/vector_kern.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 2cc90055499a5..8a70b3a625537 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -995,6 +995,9 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 				 */
 					dev_kfree_skb_irq(skb);
 					vp->estats.rx_encaps_errors++;
+					(*skbuff_vector) = NULL;
+					mmsg_vector++;
+					skbuff_vector++;
 					continue;
 				}
 				if (header_check > 0) {

base-commit: ef0c9f75a19532d7675384708fc8621e10850104
-- 
2.53.0


