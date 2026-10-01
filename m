Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9419ACA5FCB
	for <linux-um@archiver.kernel.org>; Thu,  1 Oct 2026 12:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Wc/XaUzu4zm/FTuCYjNq48N/EyN6DPB0fjJUcT4PstY=; b=vK5HAovxi8NnXENY8iVSA0MqxX
	+3BuTRlR4FG8bpA88unThe3oSitwxikBVCqNwGdigy0d4juV6OpXgFrJMEka+a8HMyJRrUknV8yDu
	H3bGj6okGhzFRDxGK5KT8QWgzlgw2wefbzn+iWJJCjervo5UOtdOfjA7woJ04TP+0RTooG4QLQ45I
	dFkKYaUnrPRlG+H9lReNhaY+GlJ1KdztWOE/eN6NWmU8J/y/yRPqPxmEArVKyL7KqKPvmchPFIe0c
	xZnUYTVY7PmPbZCjaR9nxY743UcyaAZlmefW84vFXWzqrF5AwNJ2vskua03SzbUE7sHM8TWUQmXXn
	oJAKW0wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCFwb-000000093oV-3YA8;
	Thu, 01 Oct 2026 12:31:25 +0000
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCFwZ-000000093ny-2ryD
	for linux-um@lists.infradead.org;
	Thu, 01 Oct 2026 12:31:25 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC3481400126
	for <linux-um@lists.infradead.org>; Thu,  1 Oct 2026 08:31:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 01 Oct 2026 08:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1790857879; x=1790944279; bh=Wc/XaUzu4zm/FTuCYjNq4
	8N/EyN6DPB0fjJUcT4PstY=; b=RltVOv+iFl019WFm9zEwIUhx3rf3AwFVQJlCW
	IazUo/S+EQesb0BLvYiYiYGLHu8xPjg4jw9F0yS7fHuvHjgSL0NEO+qQ8rJrg5Vv
	hG6wWPjhLDSwoOKvOvCb8+BKsfiPxPRKeW+xP+nPTnKwYtdX0GYJJK3lVWNgJ2Pz
	FG4AFufVVABNpN6ELLQNxvggGlFrHzkoHAFtlpQB9REYNmMjIN/mVSQlYHGN32Le
	zM8Gki/3DP3Uwie4qMKXTuqnzInXJrRBJBW6wRmInzTmbegstJ+0xCwL9r2RAfTm
	PjCVWh+wITUOGQ6j6Wv0al0Pw319/GMOmZgkK3um3t29sq7sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790857879; x=1790944279; bh=Wc/XaUzu4zm/FTuCYjNq48N/EyN6DPB0fjJ
	UcT4PstY=; b=q/YmZUJUI2/0HoWoK3pW3kEW/fMxFzaL97MVprN0fm4P136VAwJ
	L/I8DTApGqo/iMHC/DARgPuLjkgSgI7qTevUPjo2kmwOSG3SUc0cyXnMftCA3vR8
	RqLqoIsNnngf1X6O4TmLyDz78Sqdjt4p1pj7dQxqjiG2thpEVQcYawIRZXayhoqN
	QPpeUZuwrcV9C3umKVSxXm84+DNm/wAeoG9eQUdbojIN6n8IVpJEng6YN1jeEQ+F
	cI3ToRBjnJ8kpu3ekBsNZKeCLr2hNVyrr13Ve+xeKdE6JHy0rkkNkd/jw5h4QYl3
	TUCk5E6YycIpjSk2sOG9LZ5uPFISgpeNhMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790857879; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:C52xrOmkYSwnFKMTC2cmw3gHVmwTNWWSfG0HxEoymm9pJ/H
	8QhRA2ksNWzVkdUqWh/RAt2Hz5NBDVKO9fPHKW1YYV2GBvy9RyjXi+Y8D8S1jG+R
	S13HNv8NgN4L5263K5Oeysbd5q0qD25tgCiUtiRPmk+bGKpl4s3jgf+6uLclMnKR
	Nm7K7vPs9m4H+pBdgv4eh19JUwfNDuuUMeWNYvqO/mK/0vZlsK/XDWR7KKtxNfYP
	M0ubBxM0nO59HQSo46iy3W2drfTwl4dJCexIBrffqin3Kv7qd8dhfvKPd5uEv/db
	3Y3Sgj76IhnpljFi8pA+NB59i3RmZwdb3iVC7/A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:elZ88t6N8IC91EdShLwDg5uZGEGWOCpiT01GTlZ8A0k=:twM53lvJ3VhYvfBx9KT0LL7hdlFMgjTFuP5pELddS2k=;
X-ME-Sender: <xms:llK-aiF47X1ORNVVTOHiWfYl5KKkTnfhmZaiuzKR7EX-wbgyyRXthw>
    <xme:llK-aqZi0RQljVCyoTnth_rpM5vE8awnwtqLS3hBIvK04PlZH7GdJgNeHZNUqm_aR
    SsBdMJAgxBg1xsOMkFlhta2bFPw5_DX3-au-pscIhcBX9r0_KS3hqLP>
X-ME-Received: <xmr:llK-aj1Gmup7AhY5sGj6MKXhU9y60zKWXArB60JXymh9EAfoMiAkBJKl-RVqh7g1BEn_czdSp98gYMPaqtY>
X-ME-Proxy-Cause: dmFkZTFwS70LB3erJYzbaTJsyLPdABAp/zeskGV2WMC+BSrmSlE9v0pqkD/yg1RYHMkSNn
    I7wLTPwb90zziHO/mKGNl2k67luwVI4dTo6f40kR6JVbFk/T7h82hO/07U2LKJJkLwnxGZ
    KXODYm9O6Htiu9yUb5W0zYNr3iuXfKo0ACrU4QRJD2hE9SHbeV8hFTYJ4uLBQZG1ZiAgma
    iA1ybPD1zBZ5uK8zNsifAzmwSoJXmHWyiDc73S1YRr0pa0ig0R/Q4z6/40tFsaamcegK2i
    WsAq9X0kaYu4LVu+Pkd5PdnM8DBhWkf3bx7CQO+b4cegfnJF8ry2prnHQEKijVcDETzNSN
    udpUm89d9L7IrEtYQb4s8fnTbcU8P+mPrDav0dKmbl9s+Ko5ES/WcPFTyHJLKxUCQzDecx
    bKy3mwYKe8ow+bIvKkoNHlNW9L1K1KQTLYsh9BDa1K3fUgZXySstfePWJPSvdwOxPJ0Y+p
    Spf0V7Eru5YH3OfAhn8zazMmb+udVmsDSft7dga9hCMWAhBp3Wh38oIg7WNL5fHs5cgaEW
    ePEwzspA2k3wI3hKVjGE0lcAEOCRpAuEgUiJYsqOjHMwivbqzWtJaudp9lh326DlnVYLIL
    lSkhJ6zyeg08K8jYl8ErM+rXTlCBVk6js0XJ3c8TUR7dGicgGaT3Tg9onuKw
X-ME-Proxy: <xmx:llK-aidqFe_5go7kpExN4t24SlmAvaaPURI-553oUgbAakh2U-V-VA>
    <xmx:llK-alBKKza8lqcFWfs54IeuRTl5g47tNXycj1pCJPsu3xl-orTMVQ>
    <xmx:llK-ak01xHQ3m5XSmknJ1cMaKhgl7TNvyuTGoTRqbTD3WlBNFJFh5Q>
    <xmx:llK-alPkmIPC1XPPkCRXK5zjVVGZOg3y6OjpeB5VLSC0sVvdbTiZdA>
    <xmx:l1K-av4OhgThdwQQ3S42Pi8iX2B5zb5F5uRZDWmLiVp1PrlNL0Vz9viR>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 08:31:13 -0400 (EDT)
From: FUJITA Tomonori <tomo@flapping.org>
To: ojeda@kernel.org
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	gary@garyguo.net,
	lossin@kernel.org,
	tamird@kernel.org,
	tmgross@umich.edu,
	work@onurozkan.dev,
	rust-for-linux@vger.kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	david@davidgow.net,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] rust: bug: pass TAINT_WARN to warn_slowpath_fmt() on UML
Date: Thu,  1 Oct 2026 21:31:03 +0900
Message-ID: <20261001123103.2198104-1-tomo@flapping.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_053123_916742_433A0095 
X-CRM114-Status: UNSURE (   8.13  )
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

On UML, `warn_flags!` calls `warn_slowpath_fmt()` directly. Its third
argument is a taint number, but `warn_on!` passes its bug flags there.

As a result, `add_taint()` gets 2304 instead of 9 (`TAINT_WARN`). The
warning is not recorded: `/proc/sys/kernel/tainted` stays 0 after
`warn_on!` fires, where it should be 512. It also causes an
out-of-bounds write in `add_taint()`.

Pass `TAINT_WARN` directly, as C does on UML.

Cc: stable@vger.kernel.org
Fixes: dff64b072708 ("rust: Add warn_on macro")
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/bug.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index 3566f0234ca4..af8eba4563de 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -85,6 +85,7 @@ macro_rules! warn_flags {
     ($file:expr, $flags:expr) => {
         if false {
             _ = $file;
+            _ = $flags;
         }
 
         // SAFETY: It is always safe to call `warn_slowpath_fmt()`
@@ -93,7 +94,7 @@ macro_rules! warn_flags {
             $crate::bindings::warn_slowpath_fmt(
                 $crate::str::CStrExt::as_char_ptr($crate::c_str!(::core::file!())),
                 line!() as $crate::ffi::c_int,
-                $flags as $crate::ffi::c_uint,
+                $crate::bindings::TAINT_WARN,
                 ::core::ptr::null(),
             );
         }

base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.43.0


