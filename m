Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903EBFA1FFA
	for <linux-um@archiver.kernel.org>; Wed, 22 Apr 2026 20:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WGmQa96Hwu5AyuQmms3tFUQ1vq0rZ84zqi0RkPO23JY=; b=vJyrjuIqh93CLAozcy665xGlmV
	ZOHAA7SheMkGbgtOEZvQZOaqkfehkINEJYj3+pDfbjIj5rt5A2DylSwoatq120ZwV1JGjCuBeUPEJ
	Kd4F1U/Dyup5+J1+IKc4p+30migKclcQPDeeNBtU4Y8G/dT5hixFzUBne8QC6yjCfnT/N+qeb6G++
	8xZ59Nds73A2n0jAQSU5eu3c+PYtd5LgYcPMGdmqEFTnJHkyIqnwZlOcRxB0X2+q+LPQHjTqdY4/f
	JV8VnIGf8ABjr5bQXeph+RfKnhxBP8h5YXkBmMKhllaCAELmT3Pj8PQ6pnD6m9+mkqTNiZH1TeODc
	TAO3+BtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFeRd-0000000AjWn-24hc;
	Wed, 22 Apr 2026 20:45:13 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFeRb-0000000AjWM-2o31
	for linux-um@lists.infradead.org;
	Wed, 22 Apr 2026 20:45:12 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so42078145e9.3
        for <linux-um@lists.infradead.org>; Wed, 22 Apr 2026 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776890709; x=1777495509; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGmQa96Hwu5AyuQmms3tFUQ1vq0rZ84zqi0RkPO23JY=;
        b=htvqLAWOjZm9BxsFdvTxbWv9KyfPCr0+zGqHLETJIovc1HO0o/t/OKVjefRNY1bJ7M
         WAH0mb97AR8Smjq4J4KU3chxG7wBxOegbKbHbtw8kdYiZ/txGdLtCiRVIEC66PZ9Q0Qw
         fHTaA8jOCHWKEpsEA9YBpqMIviciHIGGt3aSKknzODMGbaEgIUK3HDqrkApGvtj0gDL5
         OBhGkrFaJkCbJHtkSF2CQJ+nih6q9ruBjxJQ9abah2THl5uAsc3ADj3j11btCFHDl3GG
         p0wA2Rv1i8DzV62DjQtkuuOjfs58Roqev5KHxEUmWYPibXsg/cd5x7XxuIdMfDPznfLK
         2JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776890709; x=1777495509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WGmQa96Hwu5AyuQmms3tFUQ1vq0rZ84zqi0RkPO23JY=;
        b=BP5g3TaCpT1BkkV9ez0vYG1KPuZO5P0FCKZDoODqfDIox4FKslP7d+CvcS7u66MXHB
         3jVfrhhbrVz6443EC/gKoGXs35nssfrDQUxKvf3RPsc5THtUGDw6VXvQMp+tnRiSi4uR
         s/xDU1wLg8xdvFj9r9rjHGt+Bc5VVN8RIFvLsirfbQxCQQ6j7HDQmlkTRcNI61He10N4
         FSUtfzOmsNiE1V3cbw346Q3elxkTJdBP5FRP8wHCTKuCi+Pz3OsBvWd7FsujcN5z98Ss
         5m0JwmZkaX8S+eb+cQwmBkUllQu08WSRpNw/qwu6fK8FnLyx/+d4ELo6KebTMjY2Ll6v
         LTpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QJFJkUfXzXXRxdGQcypW8161jMcRdraYFtMP5jSc3rmUFan1EQMlKgNA6klq+MgXx/rypvVJp1Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxmMe2PMkkwODNFsvvyx/jdlUx3C06X5AmenhTt/KYaxtB+7cr8
	PC6l6UNm/EPEkVMlvIeeOQSJJkdjofLa1JZQ6cU2/S8q7WBTyn5Rc9hM7BWWeTZp
X-Gm-Gg: AeBDiesI86Bm5XexiZgZof30SSqiiUb1FISHSFCLdZSdvIJya0ZE5ScjkSXdmRN/2mJ
	hganJ3JslTgdglmYtKtyUpFAHhgIbMuCgK0VBgW1E2T+tw7fNStHlNPbj0DNchW114zsajNKpII
	BwThJva6PuXDB0VfGE/ouChLswSIrdpOyXe9dxzsmRLow+xaNDxbxRypourxMF3nN67Z3tkmcfl
	5IksdylKALp1xsC7CZwQnbMDUxDPjkosvmYTWOObFJuLeng9SJ2x3atNPUQhhgrA37qx2KxvQrZ
	JASdIp+sUT8cTG6+Q3/se0hqQUDTEDNGSEpdCqTOeVKYzUBCSse+48Hd3hGhSNZi86G8nXsU5e0
	IRDcHIu3iFloQqth2qIFgc7agOxm2iZ+1HldKf5QVnl1wsdpYJ678cIaLkX5upLjF8ESW16cCZ5
	QMDWwZltjHahloErkuwkn+MC+BEpeITomHF+aYwoUZTmzR7mw/6qsxNqPygEeY1I8cCPJUxOA4M
	uE=
X-Received: by 2002:a05:600c:a105:b0:486:fb69:4960 with SMTP id 5b1f17b1804b1-488fb7786e4mr248879685e9.19.1776890708999;
        Wed, 22 Apr 2026 13:45:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7c0eacsm148798195e9.35.2026.04.22.13.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 13:45:08 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:45:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: "Richard Weinberger" <richard@nod.at>, "Anton Ivanov"
 <anton.ivanov@cambridgegreys.com>, "Johannes Berg"
 <johannes@sipsolutions.net>, "Dan Carpenter" <error27@gmail.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Jeff Dike" <jdike@addtoit.com>,
 <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] um: proc/exitcode: fix simple_strtol() out-of-bounds
 read
Message-ID: <20260422214507.0078c8ba@pumpkin>
In-Reply-To: <20260423-fix_exitcode-v1-1-7e4508913d68@cherr.cc>
References: <20260423-fix_exitcode-v1-1-7e4508913d68@cherr.cc>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_134511_786182_6BC0618A 
X-CRM114-Status: GOOD (  22.39  )
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

On Thu, 23 Apr 2026 01:39:25 +0800
"Shengzhuo Wei" <me@cherr.cc> wrote:

> The stack buffer 'buf' is declared as char[sizeof("nnnnn\0")] (7 bytes)
> and the copy size is min(count, sizeof(buf)).  When a user writes 7 or
> more bytes, copy_from_user fills all 7 bytes without a NUL terminator.
> The subsequent call to simple_strtol() expects a NUL-terminated string
> and will read past the end of buf on the stack.

You should probably also mention that write(, "123", 3) will lead to
buf[3] being read - which is uninitialised stack.

	David

> 
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
>  }
>  
>  static const struct proc_ops exitcode_proc_ops = {
> 
> ---
> base-commit: 6596a02b207886e9e00bb0161c7fd59fea53c081
> change-id: 20260423-fix_exitcode-908061ece624
> 
> Best regards,


