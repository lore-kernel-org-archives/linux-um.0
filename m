Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F74DC55171
	for <linux-um@archiver.kernel.org>; Sat,  1 Aug 2026 02:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2NkahgXZy6YDg1lPmebO5GP6GO2GHrUW6hHkjH7vCl4=; b=2XNblejaabHPry0O9Bog5FyBs+
	rrM+2Ay1g3cE2zy3uM7+tc070wg/nGvnycgiAoj4G7QEgUKbJ68D1BjBb5xx/9fh/uco+0apymZvg
	UIuM77tr/dp46t66/2ULvgkltARZcHY923ILSXIdgXb/+M6eGV4aOxq2tst+kOUEguUgZBKC1yR7i
	j/ikcn5QbkbwDOT54+95jIYhZPDIATKbD1sVdkvtY5mQc9L4tMoHTrpk2Pa3F2VDUoVjRwaSJK8r9
	BhAHOg5QV3WsmzvZ2CMEXFXtcXF6hFNPcY3e8CwCLB4naPPA64KaIrA6qBv1s/afkNi6UtnyBWVUc
	+j0u9q/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpzPi-0000000Dplv-2QIm;
	Sat, 01 Aug 2026 02:25:26 +0000
Received: from flow-b7-smtp.messagingengine.com ([202.12.124.142])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpzPf-0000000DplZ-0MGw
	for linux-um@lists.infradead.org;
	Sat, 01 Aug 2026 02:25:24 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id A1A0713000FB;
	Fri, 31 Jul 2026 22:25:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 31 Jul 2026 22:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1785551119; x=1785554719; bh=2NkahgXZy6YDg1lPmebO5
	GP6GO2GHrUW6hHkjH7vCl4=; b=WbWcBIaVUqNumIAMbyD/lb9w7tepm/swKiEuv
	haGd60AtRfw0zsktjoub6OxuivcVg/49ZVFrHRnnEXkAjuzl1SQoeelyxZNSnoW3
	6coo0dCYNGxXczh4iRJEkJKlZ1P9aRibKIqDyycbTncQeuhbLPYLT3ORbmXkD5aT
	UxM9v7aGhgshvFZKF8ZOgBeuSQeokBsx51sr/xjNyOiHD3BaOSa1v/IKOJ2myYzk
	LhD9J4DbrQiIjFXW6MEGKDPUnJA/PvrMBCSLHJ4DFZ84esrJtdKzCxc9iQRvseKl
	vzvJRsi5qLpbNZcDc0amwB6k3IwNpn7OIDQnh3vtpgvCQooYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785551119; x=1785554719; bh=2NkahgXZy6YDg1lPmebO5GP6GO2GHrUW6hH
	kjH7vCl4=; b=M5d+pvAC+vSztueDF0HPaAcxAkCDZXM40xWoT8TPF0j6kwWpOja
	gMuJ4rulnI5clpFPyAwT5DIy/6+blQl+91iaNu4uj0FD8+55IJvh36mycW8/nAmY
	9eJ1UytGjAM5mCXRodFWN5wU4h2P3F459RizY3gk2Fze3lh7jw36HUhcbsi1+oj9
	bnHJtrDbrIrE9kodYKnNarPw79Hf09FOYYfUm6ON7moysYXfq3g+enNwReFn3Wc9
	AagaomjoMJeQzJvNBStpBYMXntAuZq3OaoDi9Eu5jq2hhlYMOJ+S/HEhRQXW8qjp
	xl2U7AfLGIRcjOpx4lKz6AkZsY6EkYHIX3A==
X-ME-Sender: <xms:Dlltam6w00lsomeB3oZOly55xZ4soLWNMk7CRnck7LW7oERsvGz4vQ>
    <xme:DlltahSKJwv81NtWn2Huf8K1XVRADpzpVRzAENmu726YEHeEUGfp_75pzWwwsvQef
    xCGB_cA6kzVmBUQFYY0BynkRQOkNWyK9jqptyc5UdRbIBTuSq8hu6DS>
X-ME-Received: <xmr:DlltauuBCoTvlc4tWRLhKEEBgZv0S4Et9IQtz9TsUoZLnwLqSuBno7FvQeR35-ugTf5mFJycZU_abhbI_KQ>
X-ME-Proxy-Cause: dmFkZTFL5J+P3pBhS0sKQbc/ZRVTPm4LUnoO0xtwI75u0TJ+UrrGHSt1EOQOXsM5/8z5v8
    RmiJ3Ze86Cmxr84EVGJU+ip7PJMLS7+/aDPAuYvkjYYrjMdSZpydaKSYBGMjie0qOf2T5V
    7lU5SCzo14e+4dAovEVadn9kZcZeDwJHDbZNnCLBT0wynVzw/5vlsHsCUj4W6Y/4l7qJj2
    q/o6I56dHl0HkTSbLaz5sqN896VMumBGPzvYtBY4N7E0rQrH70J7eY6svBvfo+T0ELbmMn
    7UHE4dH5RU3HrrgITESCwZT9ncgOf+A5DiIvolGM8vlB6wZm5TP/ZyxAG5+is1iWbaFHUw
    f+Lwxtsz25XMCmL4X7rzUh+kE/LCUXXUecbEfS0jBLjQVqcxfF2e4+LQvqw5lJMTcNKM+9
    ZEIlFiLFzjurVFVMvAtF1mFXVKjiqKxLFy5weM2Q/pq91xixMFi5axowRHPRcyfK7aEk4d
    a1VuhQN4ieCe7tenixgSbqi0r5nKfqJbrG5snrs0Hbx/eqJXemT/jt/ZbRN2natNVZM6uG
    4lPzSBSG34K30Gdry+MmLu2uYaLJmoVLGhPt7CbM4xwhxKLOqYWbucxNTKpO+vZoyV/dCK
    8iAwQ1CgeJThd5ghXnRiSBs8gkth0/WEL5TsSEJv9RA1X0+I/N3YAUF+dWrA
X-ME-Proxy: <xmx:DlltarYpzTsSBbcCSuqzrs5gCvJu5phpVhupDjGBW7gOmzd11BcItw>
    <xmx:Dlltag9QQif9fch7Bz7czA9sjYSOI05470kQ5QLCl3Bdf78hsq8krQ>
    <xmx:Dlltavrt4C-ERPoo-jMNB2aawzBooRnUBKtvb5hYe0LsR5aBRCMzlg>
    <xmx:DlltarFB-1j9yL74dR-VPbOlgpcthvqXWwdAOXiAux-sEZXhStrzzg>
    <xmx:D1ltalXlFq1a-AQwYXfQ1CpY5iGWkAcYeSLHA0g72jEvbqJ6fFO7mkIB>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 22:25:14 -0400 (EDT)
From: FUJITA Tomonori <tomo@flapping.org>
To: ojeda@kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
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
	linux-um@lists.infradead.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH v1] rust: bug: fix warn_on macro build error on UML
Date: Sat,  1 Aug 2026 11:25:01 +0900
Message-ID: <20260801022501.722493-1-tomo@flapping.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_192523_496117_86C477A0 
X-CRM114-Status: GOOD (  13.36  )
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

Callers that go through `kernel::prelude` have `CStrExt` in scope, but
code inside the `kernel` crate imports explicitly and may not. Using
`warn_on!` from such a module fails to build on UML, which is the only
configuration where `warn_flags!` needs a C string pointer rather than an
inline asm bug entry:

error[E0599]: no method named `as_char_ptr` found for reference `&ffi::CStr` in the current scope
   --> linux/rust/kernel/bug.rs:83:49
    |
 83 |                 $crate::c_str!(::core::file!()).as_char_ptr(),
    |                                                 ^^^^^^^^^^^
    |
   ::: linux/rust/kernel/time.rs:427:9
    |
427 |         warn_on!(self.nanos < 0);
    |         ------------------------ in this macro invocation
    |
    = help: items from traits can only be used if the trait is in scope
    = note: this error originates in the macro `$crate::warn_flags` which comes from the expansion of the macro `warn_on` (in Nightly builds, run with -Z mac)
help: trait `CStrExt` which provides `as_char_ptr` is implemented but not in scope; perhaps you want to import it
   --> linux/rust/kernel/time.rs:27:1
    |
 27 + use crate::str::CStrExt;

Use the free function `as_char_ptr_in_const_context()` instead, as other exported macros already do.

Fixes: dff64b072708 ("rust: Add warn_on macro")
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/bug.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index ed943960f851..ca1ab69c977b 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -80,7 +80,7 @@ macro_rules! warn_flags {
         // with a valid null-terminated string.
         unsafe {
             $crate::bindings::warn_slowpath_fmt(
-                $crate::c_str!(::core::file!()).as_char_ptr(),
+                $crate::str::as_char_ptr_in_const_context($crate::c_str!(::core::file!())),
                 line!() as $crate::ffi::c_int,
                 $flags as $crate::ffi::c_uint,
                 ::core::ptr::null(),

base-commit: 11028ab62899e4191e074ee364c712b77823a9c4
-- 
2.43.0


