Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1F7CA5FEC
	for <linux-um@archiver.kernel.org>; Sun,  4 Oct 2026 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1ZoTvrC2BNK9y0X6wptniXwBXAUofHrlvUBugHQcQFc=; b=cuLU+stexme1biUmK7ScL3ILuY
	Z0LDM93Au8/rtshw/LpOdB3yJWPmqcY2ZQQgxOmpFaPDckYHowZQ4bXdie9svQjDAAFwj6rcC9bKe
	hZ/cWUttkrc+B8fsbLBG9TXTT8Q7a48PhtwAOKcnA2MR8xlyOdvCBvJ7xYJhMClep5ed/7H9K3Mkg
	CMWrGp3WH7WkZXBUYiWk3ZK8U+VeDvxF9WOr9mRjvpA39cKnd0Qw61tQeG0S9p3vPr5Z7vowQ7w+0
	zmeHoRVXRp2ADE5QP9urjs5q46ea5Bf9uAbgRjx/5hXCbAfenP87OnYT0r25uBSq8kNjJ9JhnBqsP
	syf0sXig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDL64-0000000EmYo-2cyF;
	Sun, 04 Oct 2026 12:13:40 +0000
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDL5h-0000000EmX6-3UPl
	for linux-um@lists.infradead.org;
	Sun, 04 Oct 2026 12:13:38 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 976781D0014B
	for <linux-um@lists.infradead.org>; Sun,  4 Oct 2026 08:13:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 04 Oct 2026 08:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1791115994; x=1791202394; bh=1ZoTvrC2BNK9y0X6wptni
	XwBXAUofHrlvUBugHQcQFc=; b=ddqMgXX8Kibiw2pP4eOHqsJTHOWHBl2KABsRN
	XE9GqgnvNhK0c3LeLiiYsg9KRHDwCE5GBJPiuwDEPhiVL0vJ04FG34eyQ8CF7OBi
	nw8CZin96d7BMIQOCVEijrDjhjMOK770vA1WrrxQWQcidQ9fxmXGN6AQSIkUkLIq
	HFFf/rulJa9iFl7Tm4QvtJSn5vN89r/wACRIGNO2avTjTITMgddqutI+/2WnZIzj
	NDXfPIC7ot4/8OeR6ZNVND3RU/ohBnOq2LY8AS7PLR/InEw/Y3afiUDla1199RfP
	RP9e2Koxz229mTYiZgVd+jZH36DRCu9tGU0ADjofxZcnUYozg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791115994; x=1791202394; bh=1ZoTvrC2BNK9y0X6wptniXwBXAUofHrlvUB
	ugHQcQFc=; b=FWhHOHp+XiWtM+JjL7EWZhjGeC8E3yrkEv4IgMwzC0g2UMyDhMB
	pJ9e2bGOlQbTX3LkedDKLzhGfXCsGnkqrZK1Un5ie7Eg9T7qeodG21CKQxPVytq2
	gnSrZgbUkYE2D1Em9jnvjj+Sh4ret2I7VGn9W+9o/GZgpKkTo1l5+EGyl1Otjldy
	RgQVTdopRuKwkeTE49pDnwX3F6OxoAAnCTJzeL4EBVVt+UK60jqcUIxXZp06BUZi
	eII7yk4BqSzNHoM1/4RABD2zJVOZUUQOldEnGV05Hff7bsVsdQG0043WCJzsashd
	VjfjxkGcWL1ze8/w7JYGVM2n3CcZs8lEjzw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791115994; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:QjVUrJWruFa2PjGO/GJvFOJnwnZShPJcQUfg8tvvoOhmQR1
	iDCOVOXRfC8jEGuJzwVHskCYQXYdslsZoIGJOh9c5Y8YZBqsdtHVn/KS/yVhx043
	14ZsQeo4nD8KPJmgEtkvHYzwiEMUruaWnthTO2/pPwAoq9IuswsMGKsCdoo9Q6b3
	OZS9ndK3YMJFJfh0AAVLtRgRwNrEhTXarDS2tjbAp8oZ6f2bRcti7vqlKUiEiqrk
	vajF53OmBXOkgcJda9YISpdiYqtoBezeBU8S2eqsM7G6QfqJTMnnhhpYkUZ28rqS
	15F0O/jwJa8AFmytORR1SdDDu0IWlmlAYTEWz1A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:sgwF9fJp3L4AUwDVUpiyd9Q4Zh0GR9FWPtAHGMc+C4k=:ITA3OVcNcMjOC4ejeIYmsiFl6yGeCi0trPklszX/v3k=;
X-ME-Sender: <xms:2ELCai2cV2__1Fxr14RP_u_1U3B_VJvhbsCK6DNeC04XqR2qWMvEHg>
    <xme:2ELCakUl0EKlaAW69hb57z6bGWZTjNnagOWRiZQhOryZgpTTEwu06BO2X2BuN0yxb
    Qi5YrJSENMzVulLLMkktzXf2ltqlejwPxm8LTHimRz28xSvRQgZWi8>
X-ME-Received: <xmr:2ELCatvQFsCLtcSHBxFqs5Wb6Z3gkDvLzzZoBQGNPGGA4ZdLyWXDwEZzl4LAVba7m0yjbvp0nDUJIxfALOw>
X-ME-Proxy-Cause: dmFkZTGEuSIb/FcWHjK3MYkrM93FyPS1RQ9Xtbd0J1NdUnSn+NhtL8G6aG4ljq0tgZmAOS
    NeiQk3VzgMLZ4cCu183M3FT7s0INEpjrCeS9qj1ViM3ovl8mdamj3YZuk+ruj4RYrmv6Tz
    Zlzt0s+vvgidwlidQxPfRCNmghtmV4onxaikaG3wnbtS6BExD+mxrSlcxs3p6i4pvb26Ba
    OnR7JKC4qghoHS+TauPbBqfkiFu0wEhPcT25R4wSei0e68xkS7mB0bdX9GZk1DJmbgKHr1
    M1qMW5m6mmjLVt9d1hwfcYkL6rtJhP+TiHlht4l2Tv/NTU6CM8dITD3U/Ea4H0ZbG/pqX9
    RD1Sn60J8E0BqIIoL9T6deRT8fNBY35qufAdNLTGdsS3DiHXnKRdNQQ/oV4UI/kfsaYx1D
    WPwlBA7c2hSCx/rvR9zaxxFEcgJ49FtNoPVgFLzukFmOxb9uhnROnfdul1b+Y3oL2AGEg4
    lCqbx1b/RIdmX8O6sA8+BBv5tFb1hiGnLcHsBD9u/wlxRG3jjpwzFn1IwAltZgfekvgoWV
    VLoXZPoelQKLsfeGr4ENKN4Rt8dghROnOMS5rmSYaq5FH/6JbUt34wWxp+b/WffrIw0cun
    4ZoNZOC3jEn7EoeLjJP0e/YHVhyJ0wacZ7+XnqoOut0/YyK3zIePLIyWP67w
X-ME-Proxy: <xmx:2ELCarWGEToPV8Qa0oAPircw3QrVgJxuYPHF5jlJ7yp0c6fig8A1TA>
    <xmx:2ELCapVBpdBD5-6GaJ1XADCc1h2SVhJ6Odne-Hc_t7ywZsDEsnVC7w>
    <xmx:2ELCalcZqNbQPVINUw2i55Twpfbb7UL076r962gjI42f8wcFxqmF6A>
    <xmx:2ELCag7bnkNG754p1UgWyiozInhyrfOflzVPwxVkHpKvArZsZLHuaA>
    <xmx:2kLCauapzFyEbfLQFxoLiIetFSAy6ZTZEEPeEtM4PfmnkLJWgXb9_27x>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 08:13:08 -0400 (EDT)
From: FUJITA Tomonori <tomo@flapping.org>
To: anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	ojeda@kernel.org,
	richard@nod.at
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	david@davidgow.net,
	gary@garyguo.net,
	linux-um@lists.infradead.org,
	lossin@kernel.org,
	tamird@kernel.org,
	tmgross@umich.edu,
	work@onurozkan.dev,
	rust-for-linux@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH v1] rust: arch/um: Fix loading Rust modules
Date: Sun,  4 Oct 2026 21:12:30 +0900
Message-ID: <20261004121230.373216-1-tomo@flapping.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261004_051322_690540_3CE54500 
X-CRM114-Status: UNSURE (   8.11  )
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

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

Rust modules fail to load on x86_64 UML:

  # insmod rnull_mod.ko
  subarch: rnull_mod: Unknown rela relocation: 9
  insmod: can't insert 'rnull_mod.ko': invalid module format

arch/um/Makefile adds -Crelocation-model=pie to KBUILD_RUSTFLAGS. This
comes after -Crelocation-model=static in the top-level Makefile, so all
Rust code on UML, both built-in code and modules, is built as PIE. In
PIE mode, rustc accesses statics in other crates through the GOT and
emits R_X86_64_GOTPCREL (9) relocations. UML uses the x86 module loader,
and it does not handle them.

Remove the flag. Rust code, both built-in code and modules, then uses
the static relocation model, the same as C code.

Modules still fail to load with a larger mem=, such as mem=512M,
because Rust code uses the small code model while C code uses
-mcmodel=large. This is a separate problem.

Tested with clang 20 and rustc 1.90: vmlinux builds and boots, and
rnull_mod.ko loads with mem=32M.

Reported-by: Zigit Zo <zig@iorw.io>
Link: https://lore.kernel.org/rust-for-linux/62F5EEA0B866E9E0+20240903130606.292935-1-zig@iorw.io/
Assisted-by: LLM
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 arch/um/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 937639edc295..c4a99073f014 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -62,8 +62,6 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
 	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr \
 	-D__close_range=kernel__close_range
 
-KBUILD_RUSTFLAGS += -Crelocation-model=pie
-
 KBUILD_AFLAGS += $(ARCH_INCLUDE)
 
 USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \

base-commit: 2dee3d3adcadcc57d62ba6608cd02f50b0c10264
-- 
2.43.0


