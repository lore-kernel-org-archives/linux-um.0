Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EDDFF885E
	for <linux-um@archiver.kernel.org>; Mon, 27 Apr 2026 13:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Mime-Version:From:
	Content-Transfer-Encoding:In-Reply-To:References:Content-Type:Cc:Message-Id:
	Date:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=baKvzSOW4QC8ZRLKPMcqjLBbH845TIhG5tsH0QB936E=; b=1PNg6sgp5u7klAZELWTt/jsSYY
	FIPULKzwqHgZQu6ki1KF3+twI7pxqrF4T8vVhB+MzWeYnsAHNc/cKLb4+D8QtHsqEh6zzwKKcaEyS
	j8KORj0AB2TxsLEq0MRizeygUfwXQDBC3+s9he3RqJQIKLg7UN5AM7WJt5Hsa+fNJLm19qZzdgh0H
	rFZdXl04Uja8Wn5jcw5ayERO10JO1cSnKkYM8Mq8RDr2icFYPEJoJrwaF8rlsWJGfd4omcgMPOpwo
	CyXxDjSTR2TYp0vmPAqYvYRs9/xhjNj5SVxwkGTCn/hyaKY9xAyUDhex5+HhnVjF1YSW43oHzllow
	zZg44uCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHM8X-0000000H0hX-14Cf;
	Mon, 27 Apr 2026 13:36:33 +0000
Received: from va-2-29.ptr.blmpb.com ([209.127.231.29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHM8T-0000000H0gW-0zKV
	for linux-um@lists.infradead.org;
	Mon, 27 Apr 2026 13:36:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1777296978; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=baKvzSOW4QC8ZRLKPMcqjLBbH845TIhG5tsH0QB936E=;
 b=DrvfqBfSwVEO1NDrQYE1Gd8NgGaBXlWcSGsjTDYDuQuTV0GBR/9AN9nONRyImUBlIrh9KM
 u2AYChcGxdF/0KpDVLIIyAYnkriTLrolAR0VOmqx60eMlPsmRAj2DEFuV25AEAqHe0kq9n
 qMHoZeCnJLbc7uWVwF1lrPDPpwtpt7qTXzFLNFhg58stMOQ43mli9VhYUalA6+VPFI7QEQ
 O5yToD/4k0vxhb5LX8HDQJN2+TnDTtVUhmoxRNxw60JTRuT/UEEP0bd2swWc9E7oN0V/XE
 65IezDuf7uc4Vzvd00uZcG96g5BfDGdS+zwJevTzsn8u+uVCzstAYGEAyilRxQ==
To: "Richard Weinberger" <richard@nod.at>, 
	"Anton Ivanov" <anton.ivanov@cambridgegreys.com>, 
	"Johannes Berg" <johannes@sipsolutions.net>, 
	"Dan Carpenter" <error27@gmail.com>, 
	"Andrew Morton" <akpm@linux-foundation.org>, 
	"Jeff Dike" <jdike@addtoit.com>, 
	"David Laight" <david.laight.linux@gmail.com>
Subject: Re: [PATCH] um: proc/exitcode: fix simple_strtol() out-of-bounds read
Date: Mon, 27 Apr 2026 21:36:13 +0800
Message-Id: <ae9mTTqp0QgL6rcL@pve.cherr>
Cc: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Content-Type: text/plain; charset=UTF-8
References: <20260423-fix_exitcode-v1-1-7e4508913d68@cherr.cc>
In-Reply-To: <20260423-fix_exitcode-v1-1-7e4508913d68@cherr.cc>
Received: from pve.cherr ([111.42.148.84]) by smtp.feishu.cn with ESMTPS; Mon, 27 Apr 2026 21:36:16 +0800
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
From: "Shengzhuo Wei" <me@cherr.cc>
Mime-Version: 1.0
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+269ef6651+ee31b0+lists.infradead.org+me@cherr.cc>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_063629_356865_392A1413 
X-CRM114-Status: GOOD (  16.21  )
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

On 2026-04-23 01:39, Shengzhuo Wei wrote:
> write(2) should report the number of bytes consumed. Returning the original
> count would claim success even when the input was truncated, so userspace
> cannot detect it.
> 
> Clamp the copy length to sizeof(buf)-1, add a terminator, and return the
> consumed length.
> 
> Fixes: 201f99f170df ("uml: check length in exitcode_proc_write()")
> Fixes: e16f5350d4cf ("uml: get declaration of simple_strtoul")
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
>  arch/um/kernel/exitcode.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/kernel/exitcode.c b/arch/um/kernel/exitcode.c
> index 43edc2aa57e4fbd4a3d24f96878c76f9f8fd4eaa..8de404ff21a213918c5351bc20a6e047bf1b93f5 100644
> --- a/arch/um/kernel/exitcode.c
> +++ b/arch/um/kernel/exitcode.c
> @@ -43,16 +43,17 @@ static ssize_t exitcode_proc_write(struct file *file,
>  	size_t size;
>  	int tmp;
>  
> -	size = min(count, sizeof(buf));
> +	size = min(count, sizeof(buf) - 1);
>  	if (copy_from_user(buf, buffer, size))
>  		return -EFAULT;
> +	buf[size] = '\0';
>  
>  	tmp = simple_strtol(buf, &end, 0);
>  	if ((*end != '\0') && !isspace(*end))
>  		return -EINVAL;
>  
>  	uml_exitcode = tmp;
> -	return count;
> +	return size;

There is another problem that have been talked about in another patch.
Not consuming the whole string passed by user may (and will) break
some programs that want to ensure "FULL WRITE" that use some function
like "while (len > 0) { len -= write(); } ".

Should we just let the return count as-is and fix the OOB problem only?

Link: https://lore.kernel.org/all/20260424063531.d1508a3c79c4b7808ed04420@linux-foundation.org/t/#u
Link: https://lore.kernel.org/all/ef2301c4-bbc5-496e-b9d2-9adcff8b8d42@p183/

Regards,
Shengzhuo Wei

>  }
>  
>  static const struct proc_ops exitcode_proc_ops = {
> 
> ---

