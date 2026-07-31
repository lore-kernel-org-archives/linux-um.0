Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2066C55172
	for <linux-um@archiver.kernel.org>; Fri, 31 Jul 2026 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o2VHmdt8Eh1f32ArKt8xyaH3k693sx+i8Cpcrk82yxU=; b=GCFRn7Nq9+4ZPb+XhbNnntPJzz
	WaTdCnbNi7+LceCkKuHbm6gejWENQ4wnkZtYaXvd66MqBbZEMbWwNUMP1HzlEKzEs54M7SV6/WBE1
	uxihns3ZUhnmeFDcIveEq03YgMasYLBYrHOki7V8K4pviDf/Pyqn61HXNJTDNwA6RJ5xDfAxbA1lr
	S8jbRIY8GacpspgZ41IIS4lM7SfFEsrPCu1rcdmSt3lH6Hz2OGbbudPmaKX2xhfdBtVN3t2GsRaCE
	Xss5hedQnVkFhYdo2vIIT2u0J/QVi9XaOKgh5xSSYmtgnreNYSCMFP8mXwUttwn+8m6OVdgfEFT+8
	oP+PsArA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpoZv-0000000Cpz6-43Bx;
	Fri, 31 Jul 2026 14:51:15 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpoZp-0000000Cpxe-26gh
	for linux-um@lists.infradead.org;
	Fri, 31 Jul 2026 14:51:12 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-47db714766aso1313208f8f.0
        for <linux-um@lists.infradead.org>; Fri, 31 Jul 2026 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1785509467; x=1786114267; darn=lists.infradead.org;
        h=content-type:content-transfer-encoding:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o2VHmdt8Eh1f32ArKt8xyaH3k693sx+i8Cpcrk82yxU=;
        b=OTmuzjEZaTx2fscJITZtltyFcsV2Cz6wE/6HXnlN7NCqlq0or0del4wCMSF4mq22Y0
         TJu/dH9ynIUYXJapPP0iHSO9gsyyFygRWrRXO6M5+8JBion+fk3hw6qZrRlMvnEQ7R3H
         Sm5pc+uPzRrqq1Kwxu7PrxUcNmgJqZ+gnKGPCp+zSjRKc6Av8ow0729UGgmfzWiGlzjF
         j53RFO+syu0JrKQmqu4kmFt0hCxS/OeJni/2GeU0Q3DPpCDcgL6Bl2I4sN8EvGlzh8Xs
         u4rYZKtQuHKWkmH6rJNcT7bbTydf5XuaZlsqFOIA4/psR7G2tPmaxXHYCRfl/SEfeotX
         KjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785509467; x=1786114267;
        h=content-type:content-transfer-encoding:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o2VHmdt8Eh1f32ArKt8xyaH3k693sx+i8Cpcrk82yxU=;
        b=i0rSj4k589G7dDNLIHmnz8UphDoHmneeE0c3uX4lUJLiC5lB1yl5bTWwA6kfKVfD32
         3I/JR5TXfjsSKg2ZAEjfl3lm4tjLBUlKOsuUXwnoWaaBGVFk9oROu7bRXLveRu1ZIe+E
         i6sHUyo69NhQQOoLLaLrrljCg3HZLt/j1a6n162ETn3TaehdMZxDWc6aoGOKc79bvqv9
         Xv+5M3/hzy5udnpD/2rB7hlyaZJQAsgVue1l69bqcLaBn7VLByYt/7qHNhNVQGSpcU0x
         7YF/hq/HcytRgV6j8w//LsFcNACyKbkqpCXarb8dXGU7SvrNLu/zg1Ar266Jv6JwkYpf
         D/fg==
X-Gm-Message-State: AOJu0YyBlevAqcu5NNh7aK8ckZ8E4CBHXcqJy8iNoYxrqliAKEr+pEl3
	Wsfn/H+fBvXoOlJOjyTWMbs+7sFBt41VXjoCLOMVEiDBlSsjufxBz0dNTCUbkO2dgZU=
X-Gm-Gg: AR+sD13lQPDA/MsBvdI/JK2Tf60B2OYjmPW/aRFPeMsf37QPGtP259p/NOa60z5BXBu
	xV32/VxounmSmHmlrGHron2M4jf583JLcrMK1GVHAhW7iHReSYtC/bXovl4qX/vRJRLeXxX3Glf
	ncNvRKMBOiIKaOIJ0jerMOQSmK40VAO+RClGnBZTgAIQJD4qtyeGEC6eb5AjHAv14aYHu9xS4+F
	N8VLRT89ozH+yujdMQhnRfVO307Y+rFPEGTbXK6bvga0yAQ3tdsMkvw/9WiZWQIDD282w6nhI8V
	gHIuvoI1QR89OCxjXUVyZYMeMgMKc1Ns8t1150jPWjzIsreLDyQx9V109zgkiMr2VOo1lkPr9Zn
	I2Gt9WNBKaV3kRcJZExf2rlPYtHQYoqNcY89Gi4N7BrqmZ6YR5iW2pc2+17EDCwVtSG/svij4s9
	v5e3ZpxEdTWWNiSzWqI+BicTbBDrXnrCwzUr1Moxx4pqIsjUlyK8M+WJeKTFmiJtjo7ziwAHF4/
	3WUZckrOQvyY6yrQE1gg0ptVK9Buw==
X-Received: by 2002:a05:6000:2004:b0:46b:70db:2113 with SMTP id ffacd0b85a97d-47fd325ca84mr5402085f8f.0.1785509466844;
        Fri, 31 Jul 2026 07:51:06 -0700 (PDT)
Received: from somecomputer (85-127-105-26.dsl.dynamic.surfer.at. [85.127.105.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458ab61sm5589563f8f.25.2026.07.31.07.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:51:06 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] uml-for-linus-7.2-rc5
Date: Fri, 31 Jul 2026 16:51:05 +0200
Message-ID: <5798606.zjCzTo3RIR@nailgun>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_075109_869262_6B4AFD4A 
X-CRM114-Status: UNSURE (   6.17  )
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

Linus,

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-7.2-rc5

for you to fetch changes up to af421e9aed3920c7ac88c24daa48606c7112feca:

  um: vector: fix use-after-free in vector_mmsg_rx() (2026-07-23 21:31:14 +0200)

----------------------------------------------------------------
This pull request contains the following bug fixes for UML:

- UAF in UML's vector networking driver

----------------------------------------------------------------
Michael Bommarito (1):
      um: vector: fix use-after-free in vector_mmsg_rx()

 arch/um/drivers/vector_kern.c | 3 +++
 1 file changed, 3 insertions(+)




