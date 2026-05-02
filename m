Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738BECD3423
	for <linux-um@archiver.kernel.org>; Sat,  2 May 2026 13:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EPIu1VT3+WtFaU6ycaBtpB2LTIlRXTVRY8qiprkx7Gc=; b=voArpLnyyej8o5PV8koNKI+wAV
	EN7wXOzIPTjf10u/0l9Oilc3Jdr9hVzav0/rLhEtgs3slKz7poSEszlPiVK/ckZUshI1TfkJDCe52
	f5EnZtQZ4U5ZfpgTpfu5oiOnGCTt63RqBlK78bken9k5u7R+YdMzOe3ZWOoXfP3Dq/2/+Lgct8RWG
	jU/e4hswRmg0qdEMvII9kEcnlTDKn9oaSY5BwUSA2OgZlRRn96w1AB3OCnXoAutm1RgwANdLOzBc7
	Egfqj2c2aeON+DB7dfYx6s0Erl9doLRVCPbZD4EYQSWPoQCNwyxw7FNqzVOOHSqDSIo8c4zdGk1ws
	MM+p3mPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJA1w-000000092jC-3E2n;
	Sat, 02 May 2026 13:05:12 +0000
Received: from xmbghk7.mail.qq.com ([43.163.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJA1u-000000092iV-15dW
	for linux-um@lists.infradead.org;
	Sat, 02 May 2026 13:05:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777727101; bh=EPIu1VT3+WtFaU6ycaBtpB2LTIlRXTVRY8qiprkx7Gc=;
	h=From:To:Cc:Subject:Date;
	b=SoqB0E6MG0QyyXKSzdFLK+QwrSee9JXInL9cgY1BF+kooEl1hGkCwn/OrK5bVlDhd
	 ANGmWIwS6jgMgJaFgTq7TPCyHUQV9qDx/nGfWR34WFLDHXBfpneiS7l1yXetVtNZYZ
	 oWCaGyrBxjRg5UhJhbYLA2JEQWaSMxR0yalYQVUY=
Received: from Lang.smartont.net ([2409:8a44:2312:14e1:56d8:1e1e:3f0b:d0f3])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 13835EBD; Sat, 02 May 2026 21:04:56 +0800
X-QQ-mid: xmsmtpt1777727096t2xpuewnz
Message-ID: <tencent_7B6592FA660AA38DCB8215456E0DD0032E07@qq.com>
X-QQ-XMAILINFO: NCmjBvJFq6XN9fygQfgBBr3jI/afKESixi/DV2JngKJxDNSdPNYBjFEnRA0RHC
	 23m9JD6OTQX+A9s8LPXSA4jRFNq5X/wTVjIIEafaUIB75EWkvdbrVm+cmy5+/zBRsIUjdgCkYDC3
	 Nm7/gkB7JM2GNnvIoZynZkK6Cvfy/Qv7AqqkdpkTZy/TZBLjggWl407oIRA1SZfvekrtMZQkW5hT
	 C+PXNO1UkYFz/6npEHfEk4YQ5pxOEP2gHGQVxoWSIDKu12WQMQ0cHQVr7daQm7TTAp/cBp87jcp1
	 6yFZnT4y1BMD9iU6S7UkmhGKDyI1vRJTIiEz6MKjRL8ti4jX7waqlEfmoAz9oOUAz4If4foQrw4Q
	 yq3WcNBwv+zs595ha44rSabjuXPGqSA/W6nnSbKm7JRb4Kx+Yld+c+WXCNsJPT+IOFvSogT7rc2b
	 Zc7ITyvvBUB7EvQJmAgtivpasNs4lSiH1eOlXOSEqSotbRqkCOYIa3brvOG7a+bJ8AoWmZuh/UcG
	 vtCQJIytvEM4wieqDbABuj0ceXPwh4QNW53fnLbVyvcT/O8+3e9EPohLi3r2Sh0f0sJcdQAIC5ue
	 PxqUsCMAf/XK+lTTswQ36Bc1JoJdeglQjo6FsxF3LgfSZkmgFdiD0ro6Km5La1OCmR9ZhUZp2FrK
	 9UggnM57z0GRYHQXXW9osEAq33WDDgv2NWGiukIRWWyxCkkDisI9s20Sif3c/D6a83XbZigAFJnt
	 8c+nSRS86rpMcB+2KaTSAygfiYJauTeC6BEDiwEW+z7PLyevLD3u06DsXo2dHVZb0xuZWAIEcl+q
	 iGG5LszxEAPTg0gWdDtmk4xCioIIrfnYNtbS0uewDjcSdO4lCLIRzjZxa8pxZWxRLvd4XNIs6Sqf
	 1t7z+wAlir0c8kXwhSU7+YOaMoRjR7ARA7xhuL6hbpuYUMuB8vWOxAlvCv2TzXWE2Oswn0VlURX9
	 bdyV08PStwDbYhMgF5/fLY6SqMSlik1RdGFDcalt+tnc0K8PcoHnlMc4hvNwLvJpJ/AomXCbQUFM
	 E+kn4zWqvvfRewl2PDlQTzzMg9pm4qHzy8APzf8XWu9pKqDbWd3DonqL4njgETjwOma3RExOeUIJ
	 +E9NPwHb7YR64skIk=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Wang Zihan <jiyu03@qq.com>
To: loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-um@lists.infradead.org
Cc: chenhuacai@kernel.org,
	kernel@xen0n.name,
	alexs@kernel.org,
	si.yanteng@linux.dev,
	corbet@lwn.net,
	davem@davemloft.net,
	kuba@kernel.org,
	mchehab@kernel.org,
	richard@nod.at,
	linux-kernel@vger.kernel.org,
	Wang Zihan <3772548978@qq.com>
Subject: [WITHDRAW] Documentation: Fix typo "eXtention" -> "Extension" and duplicated words
Date: Sat,  2 May 2026 21:04:56 +0800
X-OQ-MSGID: <20260502130456.585851-1-jiyu03@qq.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260502_060510_622468_1591639F 
X-CRM114-Status: UNSURE (   4.21  )
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

From: Wang Zihan <3772548978@qq.com>

I apologize for submitting incorrect patches. After review by Björn Persson,
I realized that my changes were not actually fixing errors:

1. Patch "Documentation: loongarch: Fix typo eXtention -> Extension"
   The capitalization of 'X' in 'eXtention' was intentional to highlight
   the letter, not a spelling mistake.

2. Patch "Documentation: Fix duplicated words" (the "later on on" part)
   "Later on" is an established English expression. The original text
   was not an error, just a stylistic choice.

I am withdrawing these patches:
- Message-ID: <20260502111912.143743-1-3772548978@qq.com>
- Message-ID: <20260502111916.145238-1-3772548978@qq.com>

Thank you for the correction and education. I will be more careful in the future.

Apologies for the noise.

Wang Zihan


