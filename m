Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D575CD4116C
	for <linux-um@archiver.kernel.org>; Thu, 15 Jan 2026 11:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AuZzUvIQYamq4W1YoLrzX7y0En5/TpcBTyFE7gx3A0A=; b=TBuneKFZx3ianwAklaRiyz+QF4
	V8WeBJ4hpDjFlrAuJfQCKr6iX7lpLa+M89K2EDeebj4o8IMKvNP2KftP+PP1OaJ6qe/Z+DsChsKjM
	zifzeoNqd9nBKS7dUzDhxKKmxwFujIVZ6w5oQAg4kGNPdf0GmqdMjViym37sPHFsYolrRPpYkA35I
	Oj6Saq+u2aVD8rDD/UlJpMe8+uZa05pW5weCaNn3DzfShk4w2zk3DRXYI2kSA2F3rQj+O8CDnSUeY
	DmhYTtISLil+xGYcSG0F2bwNgYYGKCb7oB7Pf3yspoDrJMrMXBUpODVWRpdCaOCrZF7fwDAul0ZKT
	s6zIx/5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgLAu-0000000CBx8-2LTz;
	Thu, 15 Jan 2026 11:06:00 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgLAq-0000000CBvp-2smi
	for linux-um@lists.infradead.org;
	Thu, 15 Jan 2026 11:05:59 +0000
Received: by mail-wr1-x444.google.com with SMTP id ffacd0b85a97d-432d2c96215so635034f8f.3
        for <linux-um@lists.infradead.org>; Thu, 15 Jan 2026 03:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768475155; x=1769079955; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AuZzUvIQYamq4W1YoLrzX7y0En5/TpcBTyFE7gx3A0A=;
        b=Qw4arvJVLoeCqhOololrbO0XwQbt9yni9tW+SVo0N9+8kOj/mzb0VvXAMEQf442QLj
         mEBPl8JxDXSYGss2Rp7hHG6CcheE4T9yXdZTSa+HDPc1G2ZBnnYJBfseXKjfNX7pQiMD
         KuvN//NdJ2D1Hj6quatThqnYPm0hzw0CHRYx/yk9mDbk4U19V/c9A24NwRMed8irqffD
         1/cSLjdgkZO4ykYxt0guciZQO2uBEq1ia+RKOZzL4v/IAoXn7BIUpNlKJR5cjVmXrSg6
         CNZyrVExq0viUTBsN/6Gia6A3ZcFaPWNFKS6fVnzhcYmtJXTWIl3Zr/Ah97iMDeC9kFD
         VArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768475155; x=1769079955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuZzUvIQYamq4W1YoLrzX7y0En5/TpcBTyFE7gx3A0A=;
        b=Yhvj4qZZlwynAYJOm7lfhl8VzkO4nkP+kJw6nNGKdXwYiX0sl0xc4XvCFMRxUUWPHp
         8q5vFeGGnI7DZmDusOrm5Y8nR9Qx8kz2QV2CG+K+Cc8XFAqn3lzfuxvpRIZVu1CjYmjc
         6tATupVLA6PBIBdIE7UE5pTK7ja+Xbvb9K94sNj/59hau95kki0Vfh6Vtj98bOKQShPf
         6jK5LlOyAPBFhaJBli8ZXMX2cjHZaxgzXgqjco7rVtrFYUW6P0hQ/kQ0u3JlGu1jgoLH
         t28yJfaPf1vqt624sFmZcKc8LeR0FMT7RfbrBlXxedD758QScVBpzqVeNH31qzR32GVR
         46rg==
X-Forwarded-Encrypted: i=1; AJvYcCU8SoB+lVc13jXUHgwguZMlGhu2T81m/NCD2CbGzp/sZYiI84FOio4nuenrualJ8haY2X50DakiMQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwWKQa58Gpl75v/qty1uDpHCy6C0l0CW3YbjwBBg9fqbEhaVZaI
	b4d366Xjwdiwhzq+GxloFreVigwQFZa3Ug1hRKQ6/E3SSo5bLalnbDJb9vmdCWUvLi0=
X-Gm-Gg: AY/fxX5t0YrfvH2Phbm06ONEWUispVV8NtQSUtQc0LE+zp3qMbIskknuV6fVpdFYdsA
	vOaR9yc+iDamjpqmGAnPp1oR1tYtkt+43xafCdwKWpCQCT5yP+UW6ZLX8j2nHMNiNK1Y9ZpqO4c
	+O7L4HyqXPPGtYk3LK9WF9VaiCGea0ZH9/Z1ff2FVudwlczUGHr766hHxxnf3orYdl/lpP6qETW
	QD0CYqkF341fDgijLP3sk9BMrIRdnDUIvLk5fMEbyoJTntPujGWkYfHKvtsj9nKeaCsokSms0ae
	6cu1KBg0+yh4Pans7m1TqO7pDO6IOJl1ScSFtnkW8RBLFKv45ymsqHDP+Njyc0pjewiFzYrGT65
	OJLdlBYlMNRGdxQS4wcb5CPawUFUhZHhdD9V6VMY+qTEBq0dBaZv/bt9UG/qAV053O/JnQ39SuQ
	O1qBhYsz76BE9aoA==
X-Received: by 2002:a05:6000:2f84:b0:430:fa9a:74d with SMTP id ffacd0b85a97d-4342d3912bcmr7103110f8f.24.1768475154515;
        Thu, 15 Jan 2026 03:05:54 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6d909fsm5297949f8f.31.2026.01.15.03.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:05:53 -0800 (PST)
Date: Thu, 15 Jan 2026 12:05:51 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/19] fs: pstore: platform: Migrate to
 register_console_force helper
Message-ID: <aWjKD4jv8CySV0Rj@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-10-21a291bcf197@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-10-21a291bcf197@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260115_030557_312125_595C368C 
X-CRM114-Status: GOOD (  17.36  )
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

On Sat 2025-12-27 09:16:17, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.

> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -418,10 +418,10 @@ static void pstore_register_console(void)
>  		sizeof(pstore_console.name));
>  	/*
>  	 * Always initialize flags here since prior unregister_console()
> -	 * calls may have changed settings (specifically CON_ENABLED).
> +	 * calls may have changed settings.
>  	 */
> -	pstore_console.flags = CON_PRINTBUFFER | CON_ENABLED | CON_ANYTIME;
> -	register_console(&pstore_console);
> +	pstore_console.flags = CON_PRINTBUFFER | CON_ANYTIME;

As the original comment suggests, this was done primary because
of CON_ENABLED flag. Otherwise, the console was not registered again.

register_console() might remove CON_PRINTBUFFER when there was
a boot console and the newly registered console will get associated
with /dev/console. But I consider this a corner case. Other console
drivers ignore this scenario.

I suggest to define the two flags statically in
struct console pstore_console definition as it is done by
other console drivers. Remove this explicit dynamic assigment.
And add the following into the commit message:

<proposal>
Define the remaining console flags statically in the structure definition
as it is done by other console drivers.

The flags were re-defined primary because of the CON_ENABLED flag.
Otherwise, the re-registration failed.

The CON_PRINTBUFFER might get cleared when a boot console was registered
and the pstrore console got associated with /dev/console. In this
case, the pstore console would not re-play the entire ring buffer
on re-registration. But it is a corner case. And it actually might
be a desired behavior.
</proposal>

Otherwise, the next generations of kernel developers might think that
the re-assigment was there because of CON_PRINTBUFFER flag.
And it might cause non-necessary headaches ;-)


> +	register_console_force(&pstore_console);
>  }
>  
>  static void pstore_unregister_console(void)

Best Regards,
Petr

