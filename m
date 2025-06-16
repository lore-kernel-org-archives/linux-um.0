Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4821C71159
	for <linux-um@archiver.kernel.org>; Mon, 16 Jun 2025 15:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NezTSsyMagu8zLGwg6DhObhL/nAKADWh56tKSWG5+zE=; b=PKncxn/lbGFJpPIYxgdhjcL4LP
	NvHbItynKpAHS4FDGeLKKNKSGRmPZF2CYRJtKZZK7C0kTBzecrsjE4/bBaM75aGQWEYptI+B9L7Ev
	aNS9HMoIy7AEmCmkm7YKNZovtEOqCPW20rXKMcgFMr4Qwc8+HGdAI9EILDTCaORZ5PoiMcrud6gSf
	ouRjjCIWK0dNSTNtChLvA94o0QY/gqzTvpTGEsWK/jmlslNMac1A0ch6zkdK8ZeaytQZSaDg6W6f+
	ktOYPYBSleuWYDIDObREGEyGkumVHvMGYDMTjQD3Mhv3es0tLjADKdzcXcYQYle3rdsFmiM6H3n8Z
	oanCsvYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRBkT-00000004rVv-1RY3;
	Mon, 16 Jun 2025 15:27:49 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRAQN-00000004dYE-3gyo
	for linux-um@lists.infradead.org;
	Mon, 16 Jun 2025 14:03:01 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-6095de12d62so1517093a12.1
        for <linux-um@lists.infradead.org>; Mon, 16 Jun 2025 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750082578; x=1750687378; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NezTSsyMagu8zLGwg6DhObhL/nAKADWh56tKSWG5+zE=;
        b=bOffkqTjaEL/9sjk3UcyX3Ai88DBitQ1x6YgZE/XDu8/bqsuYKGZCO27hKcnjLl+kx
         oeI6R7U/eI94YT2oB3h2Q+CpjVPVvvV902qIDtiWUiXJuL2r6XmuSOV0nbAjLLGZUOyX
         3zUVS4a147+7x6rAwYF/hb9phM3QCNZPNZoEp+bqF8uYSkB4DYt5STssRR/9S0HReYKc
         GIVydcZSOYbNmCkbFECKUsGqmd6gRzymLGF2h9l30jaXvW6pj7hHOd+WfD/Fu5AKxNxo
         Wv/dsh6vbP/kj7YwQW5CVTjAVmjnI01mwfHh+wuZaX/xkxrplYPYBw7hSYBZ2tdmhWTm
         ralw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082578; x=1750687378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NezTSsyMagu8zLGwg6DhObhL/nAKADWh56tKSWG5+zE=;
        b=iifnphQhGXCe+sgCh8ImrHZ8NaDis95NmD6uW1IqyCRfv5Xc7hApQtYTfB6z5H3J4C
         RwipvQ9rkdz/BKOQrF1QaPRMuMrC42WTrC170CT7WPO9vvd4LZBv2Y/f6KOQ55VC9S8N
         5Uybu5en5buIG7b0xdNERrYa7Y00nMSiUa5JLLpjijNNy5AVro86/J38okYj4LP0Brzm
         Ne94ecNshAmxAI70cKfV+Id9XodyNl3TI5FDEl5s8tFJcv9SAcKYlGq6HiHbTrYjqfp2
         Ae1aEMCFsRE9n14xegSrMd+AQc0r8mKD55MOlhsnDlFx4mbAkKiB0jlu3UXrrm/ggVph
         F16w==
X-Forwarded-Encrypted: i=1; AJvYcCUYHSVnlV9Jr3UwUqeJfs1mdxxRUzXMOzUFNs/wLOvEZIOnAlttxvKtF+oOOPzRwO3d5V4S8QpbEg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzYJKfhaUH6DbmXzeflczPGIBodPZj2rXtZMqmijPveomGuAGYy
	eCUXZe+kFHrUCfEZKeOBR/+vZqP1G0U9/47Wd3oywGcGX/TdyfsG4kdWCWhCTpyZNJE=
X-Gm-Gg: ASbGncsGNgpkayBHSGOVZEf346RZuMbG8GeEKkFUCdPu+UzPQRM2ZLJDuTk5ZZNd9d8
	hiQDk7uff4m6OFM1DYLlRn45OY2l6oF9KOuSu5JJWKCBvICA7VNkITO31xsMHO0keWkf9hLetZw
	8Z43mNvhQRvPvMaSEcyXOswGSXwvZ3AJzOLGqL+79TEOekqIXGtuU2Ao5MSAzOFrv+uAT4D+pHS
	YhTXwSHcGvwY/KsuWfa8lFpZ68fOK48BmX+pFUQPobOLAyL46JxRQCCX7ps82Eu3t1S7BWfRIgS
	0dsazq49p4JOjvFgWhydaDlqqFq6Rg9IHsdYqdUj14YAXoXAmr6PvOTOCr0MtS4z
X-Google-Smtp-Source: AGHT+IGQKt/OCARGss+vM72Zy1ByQz9dfh+HKXz/EINJ++KGru6AYFAdN86jIyZYD5v+8Ya81pTKAg==
X-Received: by 2002:a17:907:3f97:b0:ade:3a1b:88b2 with SMTP id a640c23a62f3a-adf4fa9117fmr1057658266b.29.1750082577978;
        Mon, 16 Jun 2025 07:02:57 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81b8e38sm674489766b.50.2025.06.16.07.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:02:57 -0700 (PDT)
Date: Mon, 16 Jun 2025 16:02:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH 7/7] printk: Don't check for CON_ENABLED on
 console_unblank
Message-ID: <aFAkD2i0ceH6qYQz@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-7-f427c743dda0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606-printk-cleanup-part2-v1-7-f427c743dda0@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_070259_918018_F5C658A3 
X-CRM114-Status: GOOD (  16.87  )
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

On Fri 2025-06-06 23:53:49, Marcos Paulo de Souza wrote:
> All consoles found on for_each_console_srcu are registered, meaning that all of
> them are already CON_ENABLEDed.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  kernel/printk/printk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 658acf92aa3d2a3d1e294b7e17e5ee96d8169afe..8074a0f73691cfc5f637361048097ace1545c7c0 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3360,7 +3360,7 @@ void console_unblank(void)
>  		if (flags & CON_SUSPENDED)
>  			continue;
>  
> -		if ((flags & CON_ENABLED) && c->unblank) {
> +		if (c->unblank) {

It might actually make sense to check is_console_usable() here.
The reason is similar as for the 5th and 6th patch, see
https://lore.kernel.org/r/aFAdGas9yGB4zhqc@pathway.suse.cz
https://lore.kernel.org/r/aFAiq3IEic8DuATR@pathway.suse.cz


>  			found_unblank = true;
>  			break;
>  		}
> @@ -3402,7 +3402,7 @@ void console_unblank(void)
>  		if (flags & CON_SUSPENDED)
>  			continue;
>  
> -		if ((flags & CON_ENABLED) && c->unblank)
> +		if (c->unblank)
>  			c->unblank();

Same here.

>  	}
>  	console_srcu_read_unlock(cookie);
> 
> -- 
> 2.49.0

