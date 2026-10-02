Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33BBCA5FE0
	for <linux-um@archiver.kernel.org>; Fri,  2 Oct 2026 10:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RIokIstseU3qlTqApqCIaq0uc2euVYuC0mKhMpIcK/o=; b=sELS6i1dD4NUqXDqdUc4qOPLd8
	7p4HNa+CLPdyFV0jrHc42mMAn4PW8S0XG0ON5Pv6wExE7AeFgLtB9IN65F0gbW3o70MDBlUkf3daM
	H366FfuqYRLWgDtPV4fxhoZa3dLYMlyJ2qvmtUcTqRsPH78hqP64jKhkkECO+1kL80Cos5eUy2pkJ
	SXaE35rDQ4OUPffkzQgSTW2EcFajwG/Atx6YRsyJBzSkyvvLa2/aSvV518tstGV/d5SSmPas0VUp2
	5UB/YDHOVAuHoITWICUSQt0PwwDNEwKXoJFqnscXa6aHrlb6THkClNU1WNOwCUlnYDYH2Z/NcGzNv
	s/w0qiIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCamF-0000000BMyd-154p;
	Fri, 02 Oct 2026 10:46:07 +0000
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCamB-0000000BMxL-3gPi
	for linux-um@lists.infradead.org;
	Fri, 02 Oct 2026 10:46:05 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AA1F5EC02E1
	for <linux-um@lists.infradead.org>; Fri,  2 Oct 2026 06:46:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 02 Oct 2026 06:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1790937962; x=1791024362; bh=RIokIstseU3qlTqApqCIa
	q0uc2euVYuC0mKhMpIcK/o=; b=lmNFoztBKtV8IWoSPpsysRJ8+o0kGqn0b0gJM
	KduWlznBO7uvKMjbRQ9aMDgQUoV5eolSONDJyKWa64td2VUEhwgcegnNpa8okH92
	6hq5uUNhzTrnkl9cdqq8gh0aJUbYRliC7RyBEw5TRusL3yPnIi0xYZ/2hzCFYEg5
	q1q1ujc8AC1hZbY+5T+Rzzx0GdtS9wyHCLC2m5DJqNL8CmLS5Vw0uCa1B/fygg3r
	G+tkXwypgCLQutKJODpKfI58UK5rYfrb3C1M2xc4+VvDFEhinpSAQLw7OPfPrkCy
	gHi4cau49Eri6t00EmarE2KHMtCsrH2eCYiV81mS1Rnu5FERw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790937962; x=1791024362; bh=RIokIstseU3qlTqApqCIaq0uc2euVYuC0mK
	hMpIcK/o=; b=VuPtjCzOi5KweNdwA+Dq98KD/C4z6put4AmIMCTE0fXCDHdoJBd
	MXtiPHk3cyDSppNKuhHncz/3XC1QARBXbFZB6Utu5adKHwqDUgbdn2RfSPG+JQfl
	qfIVefX1f0iSx6XXknpkupMdVj9CB+cIFAgq/mnJGu8UNfwXcQw6c6adnx8F9r38
	P+XpFAEz35d+HsCfWFbMidNjk+xGfmj9NdAz6cEWo4cv+HOg3GD2UWeUjK/2O8wP
	Z9G6mFhobGo1OC2o+hcttX9hLOIo51vlnL/GMhDPo6T48EORC699fKm2GzW+ukL6
	RXOxpSfOF4l/gtfIaO9/vLaL3SOCy1+8sEA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790937962; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:MkpgK/Gjfgbb2BbRI62Az28NY8gieqCF5fheaivQJWuEjeU
	lUvWNaWRIHF3BY6qqf4n+Z4gQ6mPEOYLc/mBzyFD1Ivz5N4xRpLKW86zPFLhssXm
	YZKZSsj+CrbA0cRkrAFnKS2U8mqm/hRuGSyc2/w2XU0XESgvcvJ5ZjeG+sOcEixz
	u2yxbcNG+7iR+1R7fg5DvXyAGrOyO4/MLPI2DPGuFYm3ErmhO5O7ow6sxT9Cf7Ck
	Gj2uhdHg6koZHhDtYIUyoAhG7++jeB+jJvuBxv0J8zGlQby7qD2ahOJZHadnEl5+
	DRjUeZzwLe39Jf1BoLQfZiMAYOhH/jt5OOjo6nA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:rgG6nPcY77FCBs19uCS+DRtlSQ7+7N3gNljyLG7JmSU=:FmccytxxLv3MwtwRsmTyRfWkMIoiSDuUUTeDKyZmvuQ=;
X-ME-Sender: <xms:aYu_anZdJ52kWf2JsoSjSnM8-KPrGMn_njHHCeXRQFar_iDFkfsnzQ>
    <xme:aYu_aloHOekl54TNDOLJbyg_GqhOZjEFnJ0Xq_PNy-EoQ4um5CvpEqYugg5THtqiN
    l2JGIR--_ws7OpL9mugf9DbFDFyqzSi5ld--yop8C3zCw5S2IijOchE>
X-ME-Received: <xmr:aYu_aszxOXebAUuInwHlXEBdb_m0rKe722NEEl0ZSDSVC0USkopS3niLlXLpTTewg7-2kZXPNRHwajX9lSs>
X-ME-Proxy-Cause: dmFkZTGlTvXXihZEq17d47kzGWVs9xGC8pgNgRNpwHFxAHfUqhv+xNSmNFIl7QHoiuOWPE
    8rk5ZMvnbozFmK7YYfgegecl8TUWzFGO0jEJ2g3/mcZurEfFLI/+ZGvlH7qY/tlm+2nugj
    zrz2QwKuvoqcgDW7tXeQtPDube6e/5aNuC2oKqai50ZluTE+F0RbqlHZdaao6HlXqaT0H8
    H9dqPyQPCpz3A0kpWS2LRFj9ETkBS20SN/CcSpjBAVbQLTET2aCTK8OKuNnNBpFFVBWRd5
    xJdo7SNjM27Nw2aY/WS6zRCegBXuATzAxnB5XXSbjXYhuBdtf4xfYKFJzK2BefiYwsFOGk
    MzTr8aObjOYwsh+xaAdKeWXircbw3EkHA7CM4R6IVpy/m7RPf6PBkjSuWWpEjBVvl56Kqx
    PVymFLLZf5gEOKI65OPJEsP4iV1I28W31GdOTIzwMksNdv8jmyJel4APgnKDMQ89Ne0iA/
    zsV+Nk+p4vZ8LQ7dyDSOafV4xBkChM/dRjL6ziD0e2or32MzqSouFV1Z2FofmO0so8hkvj
    krm9N0UilClcsBYn+6aAhYvEttWBgiLPwX2stnObXQkEuM1vNHOtcBj7p34nynH6eLgPmC
    PHY+lGyVhj9TB5KV2v3MNYFpNDis6ZWs8d2jZ+I2rbHnFxRbLToZRf3GgRkg
X-ME-Proxy: <xmx:aYu_alITyx_dGSdQxDweCaEEIPq7TSBo_qbBqz1VHkrh2pTA3GlNXg>
    <xmx:aYu_am4utxuX61SLuoLWXIyXucNj1LoqKEup0bG3ZTK3XP_9yb--wQ>
    <xmx:aYu_arznIG6C4h3OMYO0xexCju6VQYqGTRfMBcjICdvcrSkW2JSTxg>
    <xmx:aYu_ag96mSZubxA7idi0H_r1skqXEWy4OXlgLpvYGJmxpuRbot74Ug>
    <xmx:aou_au_aQzh_fvxlDEqfm1il6mR2reSbpmKP0bvzrYhkz1o4PQHOu-a9>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 06:45:57 -0400 (EDT)
From: FUJITA Tomonori <tomo@flapping.org>
To: ojeda@kernel.org
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	anton.ivanov@cambridgegreys.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	david@davidgow.net,
	gary@garyguo.net,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	lossin@kernel.org,
	richard@nod.at,
	tamird@kernel.org,
	tmgross@umich.edu,
	work@onurozkan.dev,
	rust-for-linux@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH v1] rust: bug: update the SAFETY comment for warn_slowpath_fmt() on UML
Date: Fri,  2 Oct 2026 19:45:50 +0900
Message-ID: <20261002104550.2877930-1-tomo@flapping.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261002_034604_109610_A2298C87 
X-CRM114-Status: UNSURE (   8.41  )
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

The SAFETY comment says that it is always safe to call
`warn_slowpath_fmt()` with a valid null-terminated string. This is not
true. The taint argument must also be a valid taint number.
Commit 951d09ca450c ("rust: bug: pass TAINT_WARN to warn_slowpath_fmt()
on UML") fixed a bug where it was not.

List each condition that the call meets: the file name, the taint
number, and the null `fmt`.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/bug.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index 6abed2c055b1..3b40b0bd37b5 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -88,8 +88,10 @@ macro_rules! warn_flags {
             _ = $flags;
         }
 
-        // SAFETY: It is always safe to call `warn_slowpath_fmt()`
-        // with a valid null-terminated string.
+        // SAFETY:
+        // - The file name is a null-terminated string with `'static` lifetime.
+        // - `TAINT_WARN` is a valid taint number.
+        // - `fmt` can be NULL, and NULL is passed.
         unsafe {
             $crate::bindings::warn_slowpath_fmt(
                 $crate::str::CStrExt::as_char_ptr($crate::c_str!(::core::file!())),

base-commit: 948440b3f429f84680db58b4bf529b1ed2a20e15
-- 
2.43.0


