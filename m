Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E890FF8860
	for <linux-um@archiver.kernel.org>; Sat, 25 Apr 2026 03:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FkmQB+P02KIaQYkq0qbQCwjnAua5/GEYD9Iuj4JxTmg=; b=NTvUapR3JzzRTb7BFpXP+W7P/g
	hqmOkmLqbokN5m0brf0zrKcf86YEmbs/ZtnD+eJUX7HfQmdjQ83faWrIZ1MA8Y7SU815LNHMatxS5
	awEIVUZne8KQsMPELb2bn/Gjvqd81CPLwOwNbptBNl7Zlj9q7g0Z2URAC3GZwzwAZLzPZtCZzC2MN
	3089cPaCqSf/B+ktfLnOvmZI5LOYp9vgCp7qPOhFSZZrCLkfwHZtQU4EN7if3ERd23twfeQFtKe6V
	+7V0xoXVNOhxPaNwbEtQ0XqDE1xtq+orjPGVxWLO/bJDX0NUh/m1O0w2wkxp0yUU1TRwyfpv6aHjO
	nzQ6E9hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGTuV-0000000E3Fz-4BCP;
	Sat, 25 Apr 2026 03:42:27 +0000
Received: from sphereful.davidgow.net ([2404:9400:4:0:216:3eff:fee2:5328])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGTuT-0000000E3F9-2J3r
	for linux-um@lists.infradead.org;
	Sat, 25 Apr 2026 03:42:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1777088530;
	bh=G/zToooWqj7mh84RSSASjaLKt8CwDepv7//5sF8bZ5g=;
	h=From:To:Cc:Subject:Date:From;
	b=aM7Xm3/3KpTKZVUE7jGGuTdHqe7O4yZGn/wz9kf1LUiUXYcxxfvVjnSAPUwXpJzNa
	 ZHSs4V/XUX9fQcqzsXFp2C8ybyZAB1TANZid70cZ+T8bEX7rAYuq7gcxUH1cEuW3Av
	 +F37F4+2BhdfUPfh2uO3ovYtpkn4p04wejaMNFAH9V689J9izPeVkza4ZixMe55mlR
	 ebvOPDzq6DdXhqbUtJgkpRYEUhtOkq7VEUv05ArzA6CaLAIxuPogdO45qMU7K4rKxi
	 YGyjXS9qKFoyDsHpujnuvKT+eriNkwzf8xISlHw+0weoA5kZedoVPUYXOrXjbUrw4P
	 G7qfgGSTi5V0mJsmnu7y4WWT1jVlBhsvyXNpztNaGY+WOpQURZmP0kM5MfnECoWkSi
	 FG67iN4TbEVBsJH4GMc7JbxfO8oT5q3cGnL8UTXtVrJrkKYBePe3LYfWjO4wqcSIrd
	 9+ikaKDeKe+G/SsKBIPu8aEji15+2l/B3Cja06wMJszYNbbGJKr7cRRufPI20ulWw1
	 YDPJuH7qvdCslH2w2QXLaedoWK5rbA5rAjEGA63fCyN0dM7Tik5QR2ud6SW9O5FeZh
	 J5EFsUmSHd5dMvR2cR0QzaP0Xgjk7QX4gDi8fm0QheY/ubIIJY6LuGxZt+mYOj+HId
	 FfpYfH4PatUHRFFkPRjewYAE=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id DB8791E8F10; Sat, 25 Apr 2026 11:42:10 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1777088500;
	bh=G/zToooWqj7mh84RSSASjaLKt8CwDepv7//5sF8bZ5g=;
	h=From:To:Cc:Subject:Date:From;
	b=IYc/LXRUA4ZYsZpFGxSTgJ8dRc/Tv0FSV5+eSo3K34sP3kqR0/ems5EF05ZLQdZ7B
	 19l7IVxTsxOXJeG6Z3iVAheE27f3copYWKDvgscdute2gGNOoCw61WHdwRBTl+5Aer
	 Wx1ZggzPWP27QPZ2JSG46atuZolXwgPGlRrlMCxhwZAeHkWHmqB1PKc7kdD1chSPjk
	 ZR1I07LCwaN9+/DyuBSyzgsbPN2sP+h4hogIniP+TKi2e9o+xXeDzso4cGg5pH3wn7
	 9WzeBPT89dPNxknTMnaMOzotec8ebogCtc6oxewh8l9fANrUW8rHrmVwf0TkVx1q5l
	 2Ca2D40cE05xjP9fwTJVKurrRBNACNlIUywJVFw9AwqGSjLNuM3gD/wwZeL4JsJULc
	 xtUPyp+nv0hekBCObVy17fsayLammrUNVuGVdUJOFkD5B6b9NL/OBfVchYZSmXEN4U
	 G8/4il7B8LNWWx1Dy/TFmH/5P2x0AzTt+Dg96YCGYtwsh78MdCvrehGkk0RLioevk3
	 Qaynz74TEDEoV6wI8JO1vInvqb93dy3+YBt7TYhB4Nbk+5RzcHLVHRKbTxzzkQ0iu4
	 lQCMQo+ENCr5jzSetXokmTvCEOiiN1UZOoHUZ08Hdix0J1deqBEgPATChCI518NjKJ
	 eLX9Wf4jJo0/6oWZhM0orcLI=
Received: from localhost (pa49-196-90-201.pa.vic.optusnet.com.au [49.196.90.201])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 9DCB31E8F09;
	Sat, 25 Apr 2026 11:41:39 +0800 (AWST)
From: David Gow <david@davidgow.net>
To: Miguel Ojeda <ojeda@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: David Gow <david@davidgow.net>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	rust-for-linux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: arch:um: Fix building 32-bit UML with GCC
Date: Sat, 25 Apr 2026 11:41:23 +0800
Message-ID: <20260425034125.53866-1-david@davidgow.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_204225_849130_D4BACC99 
X-CRM114-Status: UNSURE (   9.63  )
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

32-bit UML builds can be configured either by setting CONFIG_64BIT=n or
with SUBARCH=i386. Both work with Rust-for-Linux when clang is the
compiler, but when SUBARCH=i386, we don't set a bindgen target correctly if
gcc is the compiler.

Add the appropriate bindgen target configuration for i386, as is done in
Makefile.clang.

Fixes: ab0f4cedc355 ("arch: um: rust: Add i386 support for Rust")
Signed-off-by: David Gow <david@davidgow.net>
---

This could go in via either the rust or um trees. I suspect rust is less
likely to trigger conflicts, though.

Cheers,
-- David

---
 rust/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/Makefile b/rust/Makefile
index b361bfedfdf0..b9e9f512cec3 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -403,6 +403,8 @@ BINDGEN_TARGET_x86	:= x86_64-linux-gnu
 BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
 BINDGEN_TARGET_arm	:= arm-linux-gnueabi
 BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
+# This is only for i386 UM builds, which need the 32-bit target not -m32
+BINDGEN_TARGET_i386	:= i386-linux-gnu
 BINDGEN_TARGET_um	:= $(BINDGEN_TARGET_$(SUBARCH))
 BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 
-- 
2.53.0


