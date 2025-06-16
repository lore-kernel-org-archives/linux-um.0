Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8808EC71136
	for <linux-um@archiver.kernel.org>; Mon, 16 Jun 2025 15:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E5U21iemE/c9Sz0YhEWkD1P9gtyQVcNDFZou5zB9HsA=; b=qoylJv0Hh2egk+aFtD1lEAfoe9
	w4DNpC179XAPdsOiz3bjOwQRaxrl3y9spi8O3Iq34aIMqR+FyMjb8cgr38HhT2YMoTHx2QY0VqSut
	gSJM+qHhwOUequSR5v3oMNhx/9xbkQWo2BFr2kUHBEl2hY9kEQXxaBDqRxh8MDp9PnYGWDG9DZdOD
	9jIz1YJzm0GLCNdYNwyWmyHnZZTOjaMlI9TsAezI03eYlfnbg5rSqpZBLQnyRMnX1fyNt1fZ4wiHS
	iHy05ha9RdIzyy7qsFa5M+jIF1RdAsXRNmyHtN+H4mQHG2TJKU968iC2jz5XtNbEV988iK//xxuIp
	d5XYy5Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRBkS-00000004rU1-0BUl;
	Mon, 16 Jun 2025 15:27:48 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRAKr-00000004cXJ-01xs
	for linux-um@lists.infradead.org;
	Mon, 16 Jun 2025 13:57:18 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso40553935e9.2
        for <linux-um@lists.infradead.org>; Mon, 16 Jun 2025 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750082235; x=1750687035; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5U21iemE/c9Sz0YhEWkD1P9gtyQVcNDFZou5zB9HsA=;
        b=XluYtkpVTj81M4J0pJ64Sv4nIXEjhEN7FfZB/dgWq+WuJALFOCZYvFRT1MoqnDtBF9
         vAF+GmLcmcLjb/RJa4w86ya3Olaso+kmMzHhAdrE5gcew5I1bv9FBklP5Fekkj6OQLXL
         6Zaoeabs7As7Z+pYbPSK7lu/IROg4v+w2mtG+KHEYsM/1yU9mP31NEX9zuFm3qkAF8Mr
         iscEGl2HThoIav4hyKq43/ZfhDGi6++EdxyJFZJTfkqpHFtHPB5WUvoc8a1CtBgBWJ4q
         OY45UWPikIJelwOvl8hRsM+QVxQA7sBj6Qvb+LM/XZ6+B7jqcioB8yMo5A94xOl2Yk4L
         56gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082235; x=1750687035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5U21iemE/c9Sz0YhEWkD1P9gtyQVcNDFZou5zB9HsA=;
        b=JUrJbe5mOBmzjxA8ghJakqfkGIioD8EFbQVRah33NUx7hK15oVKuO+w2N/FaIfE1nP
         RDBE0nivGy0Spl3HhVcpNAe8TROwZPi3A+S6nG3+fkYKjRqOMGqlydaOkJd0PfdNw5Wp
         7iV3ZxqzgbeDwU8TYV3c5KHGphjg0K7jwXqZPO2DJtdbXhWi07jS7pdcNM05NAHmWan7
         7ide9KM+XirToOsOS+VHRo3t71EC3ubbwbzSL11A1CHEJSO+TyMW3JfFOQCoHYqsc0Sr
         9NFSucbTnPl4w1H18taOdgyFE7Q25rdF67X0vUDeK6aJSKwpPPa5dxhIdAaX/4zkhJiG
         22BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzKYpaBSMbSiWgAGhhPiYkRw5k9W1LdRaOUSiQAwVRBroF9vn/ITnqst1/5QfB5nRfckUZIsE5fA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwdVq4X61/HeYu4MvMCc2NDYc56IzzD3t0cgE0PTu8Y6w246m6g
	vsfKUcYMI9tI686kYZlA3xYpidbeEq7YPGSt/gs/QvuDbN3L8ZZGFEtk4L4bOxjjewk=
X-Gm-Gg: ASbGncv9xsxIdIOfmZ4lzL9xOHbnhw+Ro4x4QFkmoPVpEP4asdE/1c5YRI791Ngy9ei
	1ZzvewWAmsyelZaWXKflosoAnnUuoYT1mXvB1wG9QCnhFJPZ/CQOizGFjMDuPtNhhKo470vOseD
	yVX54L0GNq1wwNJer3V1tCtt2Bts0zBwWV4JV8N+J6lApZh3txN9DcFGWpIpdJu/s8j7YgpL7TI
	ub1ZreDNjYmfrCA1WstizbMridEXbBSJyRe2AVizvIqPCmFrgq5dGOuPV/fOVS8sO2amx4Qwiw9
	2FmqcnQcWD9LwdBI2Gh42GE+eru4t/jBryOvHOA6U6TdB2dRqEcOjvL+g2aGok57
X-Google-Smtp-Source: AGHT+IG5cdNsogAjYlCwwv/Yr99wBxZ5kpKFYKtrzNVTxQPp1q35B4mAJcdg7PMSO6nM0Lz7izNcdg==
X-Received: by 2002:a05:6000:1449:b0:3a4:ed62:c7e1 with SMTP id ffacd0b85a97d-3a572367734mr6709880f8f.12.1750082235292;
        Mon, 16 Jun 2025 06:57:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea927asm61349195ad.155.2025.06.16.06.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:57:14 -0700 (PDT)
Date: Mon, 16 Jun 2025 15:56:59 +0200
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
Subject: Re: [PATCH 6/7] debug: kgd_io: Don't check for CON_ENABLED
Message-ID: <aFAiq3IEic8DuATR@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-6-f427c743dda0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606-printk-cleanup-part2-v1-6-f427c743dda0@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_065717_045546_B4EB0C63 
X-CRM114-Status: GOOD (  23.42  )
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

On Fri 2025-06-06 23:53:48, Marcos Paulo de Souza wrote:
> All consoles found on for_each_console_srcu are registered, meaning that all of
> them are CON_ENABLED. The code tries to find an active console, so check if the
> console is not suspended instead.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  kernel/debug/kdb/kdb_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 9b11b10b120cf07e451a7a4d92ce50f9a6c066b2..cdc1ee81d7332a9a00b967af719939f438f26cef 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -589,7 +589,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  	 */
>  	cookie = console_srcu_read_lock();
>  	for_each_console_srcu(c) {
> -		if (!(console_srcu_read_flags(c) & CON_ENABLED))
> +		if (console_srcu_read_flags(c) & CON_SUSPENDED)
>  			continue;

I think that this is similar to the 5th patch. We should check
here is_console_usable(con, console_srcu_read_flags(c), true)
because it checks more conditions:

     + the global console_suspended flag. The consoles drivers should
       not be used when it is set...

     + whether NBCON console driver has con->write_atomic

and we should also fix kdb_msg_write() to actually use
con->write_atomic() when it is a NBCON console driver.
There is hard-coded con->write() at the moment.

But it might get more complicated. It would be nice to do it correctly
and use con->write_atomit() only when nbcon_context_try_acquire()
succeeds. We probably should use a context with NBCON_PRIO_EMERGENCY.

And this should be fixed at the beginning of the patchset because
it actually fixes the support of the new NBCON console drivers.

Best Regards,
Petr

>  		if (c == dbg_io_ops->cons)
>  			continue;
> 
> -- 
> 2.49.0

