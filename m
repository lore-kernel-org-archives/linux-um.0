Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28145CA5FC1
	for <linux-um@archiver.kernel.org>; Sat,  3 Oct 2026 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DBfWUrKzyt8kwVb+P/QQs8o/mRtvdMaIp3MxER33MbU=; b=zp7Hg2nXrUKqRbiIbcc9bKvQGg
	x3o0WyMwPedSVzRXHF1ohIuqmVydDkORpjuqg00QtrtjLhCroaGPx4m32cH7RFItWPDXnSiTGgW2d
	Ghk5cHHtIkDTEzbfxbzer2cPEjpbqP3y3DkJKVJps0ka9royA4sa8FNtWfQb7h3hGwwWhWAMgTWgo
	yVmm/df0970oB8gT3LlHnhKf+RUftMrYt/CFQDg/WxpMUx6zQP1tFJ9JbehU6B7nigBH5XY+aEqkj
	hIwBQBfbLmxkbNmNU0DqAUIyPnRR0EAA92iDSEW9NwjelEiSExfEsfs3mRXqpF+lmyHlMbCG8SRh8
	mRx892xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCyj4-0000000DUDH-1Clk;
	Sat, 03 Oct 2026 12:20:26 +0000
Received: from sphereful.davidgow.net ([203.29.242.92])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCyj0-0000000DUCg-37Ys
	for linux-um@lists.infradead.org;
	Sat, 03 Oct 2026 12:20:24 +0000
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 963712003C2; Sat,  3 Oct 2026 20:20:05 +0800 (AWST)
Received: from [10.80.19.179] (unknown [103.137.210.79])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id C0A25200395;
	Sat,  3 Oct 2026 20:19:55 +0800 (AWST)
Message-ID: <baac1e91-4dd1-401c-833c-3702a90ab974@davidgow.net>
Date: Sat, 3 Oct 2026 20:19:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rust: bug: pass TAINT_WARN to warn_slowpath_fmt() on
 UML
To: FUJITA Tomonori <tomo@flapping.org>, ojeda@kernel.org
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org,
 daniel.almeida@collabora.com, gary@garyguo.net, lossin@kernel.org,
 tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev,
 rust-for-linux@vger.kernel.org, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 linux-um@lists.infradead.org, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 stable@vger.kernel.org
References: <20261001123103.2198104-1-tomo@flapping.org>
Content-Language: en-US
From: David Gow <david@davidgow.net>
In-Reply-To: <20261001123103.2198104-1-tomo@flapping.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261003_052022_979262_63C0B796 
X-CRM114-Status: GOOD (  14.08  )
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

Le 01/10/2026 à 20:31, FUJITA Tomonori a écrit :
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> On UML, `warn_flags!` calls `warn_slowpath_fmt()` directly. Its third
> argument is a taint number, but `warn_on!` passes its bug flags there.
> 
> As a result, `add_taint()` gets 2304 instead of 9 (`TAINT_WARN`). The
> warning is not recorded: `/proc/sys/kernel/tainted` stays 0 after
> `warn_on!` fires, where it should be 512. It also causes an
> out-of-bounds write in `add_taint()`.
> 
> Pass `TAINT_WARN` directly, as C does on UML.
> 
> Cc: stable@vger.kernel.org
> Fixes: dff64b072708 ("rust: Add warn_on macro")
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---

Nice catch!

Reviewed-by: David Gow <david@davidgow.net>

Cheers,
-- David

>   rust/kernel/bug.rs | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
> index 3566f0234ca4..af8eba4563de 100644
> --- a/rust/kernel/bug.rs
> +++ b/rust/kernel/bug.rs
> @@ -85,6 +85,7 @@ macro_rules! warn_flags {
>       ($file:expr, $flags:expr) => {
>           if false {
>               _ = $file;
> +            _ = $flags;
>           }
>   
>           // SAFETY: It is always safe to call `warn_slowpath_fmt()`
> @@ -93,7 +94,7 @@ macro_rules! warn_flags {
>               $crate::bindings::warn_slowpath_fmt(
>                   $crate::str::CStrExt::as_char_ptr($crate::c_str!(::core::file!())),
>                   line!() as $crate::ffi::c_int,
> -                $flags as $crate::ffi::c_uint,
> +                $crate::bindings::TAINT_WARN,
>                   ::core::ptr::null(),
>               );
>           }
> 
> base-commit: 551c722f40809618230001baccf219193e22fc5a


