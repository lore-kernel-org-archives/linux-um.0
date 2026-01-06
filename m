Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363A6CDC19A
	for <linux-um@archiver.kernel.org>; Tue,  6 Jan 2026 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:From:Subject:Cc:To:
	Message-Id:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kH6gPiHojgPMq8ZXJ6RVibQ9Q36cA/iXytWSANCCBSU=; b=vQRMCE8J3ubtOFIUwhvZJQuy/u
	oO1PJJbNbyM4KUrS97ySACQSPblkNkz7oK8kp0B1jxpki21+OFZRxnWqA4Uf3N53oK4LflkCwoPR0
	N6BZ1CgfIE2S1vxrhz3UFNtneA4KMbOA9ga/+7wpKSDDwDbl4UEZsffvb5xWvotwWVqVRbaIsqRmJ
	qYijA441HwTzkdsBN+Mx7j9jo5k8c6zBRqQVr0P3DazArPTlzHViUI7dJK1g5qUIFFs+STLjMXUAu
	aRqiZCQY8TtYqQv6LhISTGR2paZfrTgSRRaevp7PlLFTJcNhX1Eo2oUidJ0exkFc6gL/Vfr5xOFNx
	4IzrvEyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd78c-0000000D6SZ-2Lcn;
	Tue, 06 Jan 2026 13:30:18 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd78a-0000000D6SG-0XGS
	for linux-um@lists.infradead.org;
	Tue, 06 Jan 2026 13:30:17 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-7ba55660769so812109b3a.1
        for <linux-um@lists.infradead.org>; Tue, 06 Jan 2026 05:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767706214; x=1768311014; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kH6gPiHojgPMq8ZXJ6RVibQ9Q36cA/iXytWSANCCBSU=;
        b=Hvik4xLXzGZSfZsUq4HJSJygL9cZVE4UYFZXBSb2jBE48XMEFWtQwjsEWGzvWTcVCK
         bWVeLIhSYXZnERt5jIsiL4FmLsESr3Y0x4xPu7l/SAX2UDzrvH3xfv+d7XND1IhRTIdY
         6VaD5+K3FjpB0pGfjasVKYfnxRzgC6eegsf424KouCGeTKZkx5j2AVQG/aC3KpAe8CIA
         xNK3gAkGMPG+m8p4AohXt1IScUHQszGhRNhI1pdcEHbQa8oiPBoY8eVsbJcP1TPqFimp
         KqeYxI2LDbFrm4e4JkzaLAPc0AFZ/sqcZ5I05bCfc7+RS5JnLTXiV7YiWZZIlaIxUk5w
         dbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767706214; x=1768311014;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH6gPiHojgPMq8ZXJ6RVibQ9Q36cA/iXytWSANCCBSU=;
        b=LrzNS4C5Ll5QX+5yESIqcwC7gcAhFkMr3nPcUnCCu6E7f2ZaaTrJzlzR55T4/rL6eM
         7IOacVkP8u8oUAcGZZI7eqm9UG9+InvtlZBeAGfVAIZLYVF2XJ5SP70L558XeX3t2mE4
         G6VQXomAvsRDrNPaVmU3pNqhv2H2Ko0Rnhv3++rikGr5HoIxM8U1s+Ez4Mk9VUcNjdIe
         7w3IAJPsr4omKuPV9DSGVuyuUcgGkIE69NoXlKlhDt/IYCqIUrHf28+MH455zWdEK0tk
         kPbmM94GiaoCTnDxx8NhQ2YSIf4pocv3Br1RRK4TIS3CndOztZAUZrW/0601Kz2jp++X
         uNRw==
X-Gm-Message-State: AOJu0YxYgqaT1HH1uaIKimv6aWxMz+zCSsfsPoTb0klWfzlXpkBDsOcR
	3s3LB864X7416jhqxVxLnLltvl9V37FnILVL/arnO5KdI3xyW52v3fy9VNxn3Q==
X-Gm-Gg: AY/fxX4Q1eTYOgwkafeuIOeurur5nxHmokP0QnrlptyWcxwlRGQlunHpUzQZrCKjeHs
	/z8E+2zgTl3qUocsAtZBZsMfUOI46YDfX/mxuqFicSc0ggIi6SNwfYA2B8nm/7rEm16WGLWoU3X
	1TTuFvJ8svgKKdNYsfYElxAoTU5WQVQ662Pb/BsSCVUnD6ogmA8Tapcdph5wpf6tp9JiwF+tGvj
	Ssq3shiBZiexnH8YuuCrQcj7BndX7jPDfKoEcmri67yAG47dFPqTceh+JAjS+8VGYpZhomc/cnQ
	YhmlzNRzKU85qZhTvD8TnjLuIz5rA3CdMvVj9A/c6U2ZVY1HiEjic2h49wiSdgfX8x1iKQrR9PS
	HDobn0kHq+PZOKidOWagtPfg7qtQTw7iNOfUANMvyRJwrBU+Dadavl7MwX+h2cK61QlHFVeOz0B
	W8LtJO0jLEXEupEHm91rWhvU7hgwUbzEwHO2GhLD6TrUhUuZ09Ok2M7ZIVG8/dlWEUU+g=
X-Google-Smtp-Source: AGHT+IFdszWb1AVWkR0MrH4I8Lr1Bt/96yPfUAuddIHA3E3KbYedZe+pkqMHENxRvXalBgPCIY+nJQ==
X-Received: by 2002:a05:6a00:1d08:b0:7ff:acc0:869f with SMTP id d2e1a72fcca58-8188038c8e2mr2895137b3a.3.1767706214282;
        Tue, 06 Jan 2026 05:30:14 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e983fsm2289349b3a.55.2026.01.06.05.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 05:30:12 -0800 (PST)
Date: Tue, 06 Jan 2026 22:30:06 +0900 (JST)
Message-Id: <20260106.223006.975482344774303287.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: linux-um@lists.infradead.org, x86@kernel.org, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, ojeda@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com
Subject: Re: [PATCH] arch: um/x86: Select ARCH_SUPPORTS_ATOMIC_RMW for
 UML_X86
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20260106034034.60074-1-boqun.feng@gmail.com>
References: <aVxcAZe6AEXEfx3G@tardis-2.local>
	<20260106034034.60074-1-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_053016_174040_42A4F9E8 
X-CRM114-Status: UNSURE (   6.59  )
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

On Tue,  6 Jan 2026 11:40:34 +0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> x86 atomic instructions are used for um on UML_X86, therefore atomics
> on UML_X86 support native atomic RmW as x86 does, hence select
> ARCH_SUPPORTS_ATOMIC_RMW.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

