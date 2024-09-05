Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A5ECD4F4D
	for <linux-um@archiver.kernel.org>; Thu,  5 Sep 2024 06:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8FxsTOqdqzOkyw6TDf9xiFqZbYhyqbcaHGo9ObkAUmg=; b=kiFwULnPWf+JVCiTPCvq2RR/2o
	7E2LADo45sx/fvgGEn5hkBAC51s/lAx7frRB4FiExW2d2ZcgOl4EiYxTqaz3mI4Iildw9eUYiXmR1
	P0CxvTeT3ch3E4KKxhKplrEdr7gsI3+fWbUNsoNeqQyAcx8lpylM1lGsDIJfowMb4VT8ORPQ/8LRK
	HaDgm1tYX3T5+wuGbOAE5gSoep3Cwo0KcCqa7kSkfnTvkn9XBa44j+ngZBCfBxzMtyXkJxdLxGmGt
	iDHn+Kmyc+AYsTYaH91S0FyFDpx9xPd2mbRBhQ/KS+u6CROQYb3dnLZnlqSgjia5qqymAl7/UpK0b
	CSEerCfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm5jQ-000000078Uu-3Wkk;
	Thu, 05 Sep 2024 06:12:36 +0000
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm5jM-000000078Tn-4C0X
	for linux-um@lists.infradead.org;
	Thu, 05 Sep 2024 06:12:34 +0000
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-6d475205628so8531837b3.0
        for <linux-um@lists.infradead.org>; Wed, 04 Sep 2024 23:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725516751; x=1726121551; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8FxsTOqdqzOkyw6TDf9xiFqZbYhyqbcaHGo9ObkAUmg=;
        b=09/fFa/31Lt+YYAUv7xWACWNZjRHgxvorElKlctOeTyldFUOL/Xt6ZqlJbDMotLR4T
         Vvu3m4WmZSVHUhXvaF7SMSldEuf1ky2fGzuyIMAqmIewL072gUI05s/Sh+0k3NZ684nH
         YjhO3jowpIOEaqEdZJa6lzVwWc7qwC33vXqTsthDd5uMml7LvkiFbuMzzrPseQ643SgV
         z0kSvaovMmBcP+I9vy/Uy2AnGPSiHz/fFJVHSOzciVHSvCwGKxQIeNVOl7edIg92cAAf
         b3r9oTsCDfci+qJXlLOrOfNKEiiX4tUf8xUnHSeJb0pwa6EKwEhfnUU2D66ytG6Flx3d
         EpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725516751; x=1726121551;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FxsTOqdqzOkyw6TDf9xiFqZbYhyqbcaHGo9ObkAUmg=;
        b=d7CrKPpXXjnbC5tPrSC1b3NlO+m6aXx+GyMTt89sqTWtJAvQEkIcM7ncO/3zLBR+FN
         xrwbU1377BJFZjanTOvKI+oOt0pwz7f3PfCpIKOik0XSDTcVMlDBNEldSs0iPt3BTwfE
         UbpxyodNxfxNuiAyEbTK/J2N0DF+ERJdfhL/AV5xGmPhD8MHuwsLTljY1nTIAPc5yjJg
         HTJIGfDKMrQ/E0SAfh6PB0jJmAbbuez89tW++HV/8kFWXLvg0ZlcZBswjQhMBBeSrRKt
         vkUD03uD6TP0AvZXKyHw5aZuWKTkgGJ9sLwhiNTwWwFhYy81GDV5RD24acy9P1/pzZPI
         KAPg==
X-Forwarded-Encrypted: i=1; AJvYcCWp7557D0+TqdMa0+jfHdc1XMFeTVww//9wsnvXW5L7IP9GDR5p0nj9ULyUrRHLjE3p6lKtg06h1A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwTA58Yfmh2wHnGAqU6leyDiADbNFeU7VMS+CAPf0eWPx1c1L5V
	spS4J7Wbl2GL0/8Xr3upqastZvMQf9q7TLhj3l3a3T73oVj26VcLcabehU0mCUz/O1gbX/73Lq7
	+LUXb1vc5RQ==
X-Google-Smtp-Source: AGHT+IFb1uyLverYDvkTYTYyFuU6LY97S1fxJcQ5+perARjw81iOZxVvfKHhENGCOXBybmboZGZK6CqTqt35rg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:ae56:0:b0:e05:6532:166 with SMTP id
 3f1490d57ef6-e1a79faf683mr114011276.1.1725516751120; Wed, 04 Sep 2024
 23:12:31 -0700 (PDT)
Date: Thu,  5 Sep 2024 14:12:14 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905061214.3954271-1-davidgow@google.com>
Subject: [RFC PATCH] rust: block: Use 32-bit atomics
From: David Gow <davidgow@google.com>
To: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: David Gow <davidgow@google.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_231233_069314_92DF9FA3 
X-CRM114-Status: GOOD (  16.91  )
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

Not all architectures have core::sync::atomic::AtomicU64 available. In
particular, 32-bit x86 doesn't support it. AtomicU32 is available
everywhere, so use that instead.

Hopefully we can add AtomicU64 to Rust-for-Linux more broadly, so this
won't be an issue, but it's not supported in core from upstream Rust:
https://doc.rust-lang.org/std/sync/atomic/#portability

This can be tested on 32-bit x86 UML via:
./tools/testing/kunit/kunit.py run --make_options LLVM=1 --kconfig_add CONFIG_RUST=y --kconfig_add CONFIG_64BIT=n --kconfig_add CONFIG_FORTIFY_SOURCE=n

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Signed-off-by: David Gow <davidgow@google.com>
---

Hi all,

I encountered this build error with Rust/UML since the kernel::block::mq
stuff landed. I'm not 100% sure just swapping AtomicU64 with AtomicU32
is correct -- please correct me if not -- but this does at least get the
Rust/UML/x86-32 builds here compiling and running again.

(And gives me more encouragement to go to the Rust atomics talk at
Plumbers.)

Cheers,
-- David

---
 rust/kernel/block/mq/operations.rs |  4 ++--
 rust/kernel/block/mq/request.rs    | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index 9ba7fdfeb4b2..c31c36af6bc4 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -11,7 +11,7 @@
     error::{from_result, Result},
     types::ARef,
 };
-use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
+use core::{marker::PhantomData, sync::atomic::AtomicU32, sync::atomic::Ordering};
 
 /// Implement this trait to interface blk-mq as block devices.
 ///
@@ -186,7 +186,7 @@ impl<T: Operations> OperationsVTable<T> {
 
             // SAFETY: The refcount field is allocated but not initialized, so
             // it is valid for writes.
-            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU64::new(0)) };
+            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU32::new(0)) };
 
             Ok(0)
         })
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index a0e22827f3f4..418256dcd45b 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -13,7 +13,7 @@
 use core::{
     marker::PhantomData,
     ptr::{addr_of_mut, NonNull},
-    sync::atomic::{AtomicU64, Ordering},
+    sync::atomic::{AtomicU32, Ordering},
 };
 
 /// A wrapper around a blk-mq `struct request`. This represents an IO request.
@@ -159,13 +159,13 @@ pub(crate) struct RequestDataWrapper {
     /// - 0: The request is owned by C block layer.
     /// - 1: The request is owned by Rust abstractions but there are no ARef references to it.
     /// - 2+: There are `ARef` references to the request.
-    refcount: AtomicU64,
+    refcount: AtomicU32,
 }
 
 impl RequestDataWrapper {
     /// Return a reference to the refcount of the request that is embedding
     /// `self`.
-    pub(crate) fn refcount(&self) -> &AtomicU64 {
+    pub(crate) fn refcount(&self) -> &AtomicU32 {
         &self.refcount
     }
 
@@ -175,7 +175,7 @@ pub(crate) fn refcount(&self) -> &AtomicU64 {
     /// # Safety
     ///
     /// - `this` must point to a live allocation of at least the size of `Self`.
-    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
+    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU32 {
         // SAFETY: Because of the safety requirements of this function, the
         // field projection is safe.
         unsafe { addr_of_mut!((*this).refcount) }
@@ -193,7 +193,7 @@ unsafe impl<T: Operations> Sync for Request<T> {}
 
 /// Store the result of `op(target.load())` in target, returning new value of
 /// target.
-fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64 {
+fn atomic_relaxed_op_return(target: &AtomicU32, op: impl Fn(u32) -> u32) -> u32 {
     let old = target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| Some(op(x)));
 
     // SAFETY: Because the operation passed to `fetch_update` above always
@@ -205,7 +205,7 @@ fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64
 
 /// Store the result of `op(target.load)` in `target` if `target.load() !=
 /// pred`, returning true if the target was updated.
-fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pred: u64) -> bool {
+fn atomic_relaxed_op_unless(target: &AtomicU32, op: impl Fn(u32) -> u32, pred: u32) -> bool {
     target
         .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
             if x == pred {
-- 
2.46.0.469.g59c65b2a67-goog


