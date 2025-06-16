Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D748FC71136
	for <linux-um@archiver.kernel.org>; Mon, 16 Jun 2025 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mDsjdTiosngDCcbjk569uHEPxRmT2Rin/eFUrpVF9Nc=; b=ltA5yY52YY7oSZNuum/8bM/rb7
	F+qse4w5IOWNInaOwbtrR3GGufhqQBmjpg0aLth4loVUCZ2v6NX1FqyFZtjgvpfEfz1rPrh4sqdjt
	i0DiDIKQkgYKF7UIZ2PuotvnQuRv2+hpQJ1JVaIuj3vMYwA0ysZS/lQAR5kBWT6k6W4MZmw5USB4J
	aYq+sTfdPmgO9DvYkgFAr8Q9eamKF0gHYBIwKx6AxZbmmO4bEhvAxWkrKJzvdFeBa2xGGmv0VDOmY
	emTYuryrrNo2A76e9Ucu0L7Kwl3t/nxSmVMLGv2cgMk2yMBivnJcsgRea8Bhf7o3dK6lziHV01+7E
	Zp8k9hKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRBkE-00000004r7y-3mXr;
	Mon, 16 Jun 2025 15:27:34 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR9xs-00000004Yli-1xzF
	for linux-um@lists.infradead.org;
	Mon, 16 Jun 2025 13:33:33 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so2704726f8f.1
        for <linux-um@lists.infradead.org>; Mon, 16 Jun 2025 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750080810; x=1750685610; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mDsjdTiosngDCcbjk569uHEPxRmT2Rin/eFUrpVF9Nc=;
        b=LIvVVUVSlDwwpggBLaCp7+Ayvl+0xEW0iAJkKBbHTlDDDZeSiB/Mf6qqsbF8Ea41b2
         55WuCy6bypnZqvDShaluxJXqcljK2HH7HOnR8RH3Kvjd5c6StpuVKWXVd67IdRE36jco
         5Pv2SSEzDT4n7SMZqx1PLYvOZhq2rXOarUAFzVYJCvDEplxHmD8bsP+E8HrxTXlXFxJB
         gByk5K7mcSQtf+YNOT3+7fq5BVqIERNLsYDCVMY+RiIzKSX6Ru4a/OwaVrzeG07wDO8D
         epqHAAGcqSfQT0vsgaJTqCgrmNEkGJ2SFosKBa6Ap3+6/na6CF89g66owE9D4AnToP7s
         aS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080810; x=1750685610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDsjdTiosngDCcbjk569uHEPxRmT2Rin/eFUrpVF9Nc=;
        b=v4w56PUVgpVZLlO1ui2LGtjdAqCES+yszoqR90iAHVtuM7okhkUJGHuUhzy79s+YGg
         zkClptlIeZeR1s7A+yzPmDf+13/DOA1eB9m335fW2QUsd8MkYcVf4pKUUDCVv2duMR7S
         2ZgE9UalufF6PIFe/gEumhP0lG2cum5/2v7KxNzZgjbL1JrJX0njDrZDKdHgNOYB1l+u
         pgM66FTRrcCVLWj0ncrqhVqsHpu9SRy5HGytCE57xdYRYgDB+N7VBZCkCnVUMnleDEww
         41kaC24MqrKsTOcxnvyReuPqnyM++Kmi2XMG6HwhnVJVwT2s3ujNr9zVnmiZPPaf1qwd
         MLOg==
X-Forwarded-Encrypted: i=1; AJvYcCUYI8TgzadUmprzGAxVlfVYTXsbXmArNhNkedDpOU4B7gBA13qtsWCp5HxhBmqOg8iBRF/ddz/P6w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZDle6oy856zSkyD1DAKumaDaL0YUWQFwoii2Ho9nHzkO97Keh
	tz5lZSJRfabYz40fTUKq1XfqvKqDPVZ0UKgDxSbXjPJk+jyXlPB/pzhAGk3M4GUbPyA=
X-Gm-Gg: ASbGncsvpnv6bafOXYvT92eob7xPiCrzjr14bQzG/CK4als0yYOOXDxDGtSqYZT4iuu
	e3XfTgz3h2/OgXg/JSIaDf4fXJcIjrSJjc0ZvGR7eIZGi/3JDVCyYGCvFHD+1aSMRyKyDVxu0Uw
	Klg0Tz1X3o20gn5bLfldo1SXVkiaVsO3H12IIHEp116UTSG7GTXnBk4AWPdEgTMJIgpVYlP8WUY
	PhHS8uVRAdpEYKA+TYbL9/K+YYyuYmMetPYUzT/3JtJMIsadl+PuKctdmqiD+3e1bS3LLVTVI0l
	ejgqW/4txFhTyQknZqhlMCpQt0pI14kXRCjQh1rITrkNKD6MKZs0Ya6EQFxJaxb4
X-Google-Smtp-Source: AGHT+IHsMKMEFnK4iRSKN4yA2G25+VoXuC33JoKTL84hU+3purxVVSbR+gePOjO6tpOk2JJiHzT3Fg==
X-Received: by 2002:a5d:5887:0:b0:3a5:2dae:970c with SMTP id ffacd0b85a97d-3a572e82154mr7975991f8f.37.1750080810126;
        Mon, 16 Jun 2025 06:33:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de77605sm60637745ad.105.2025.06.16.06.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:33:29 -0700 (PDT)
Date: Mon, 16 Jun 2025 15:33:13 +0200
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
Subject: Re: [PATCH 5/7] arch: um: kmsg_dump: Don't check for CON_ENABLED
Message-ID: <aFAdGas9yGB4zhqc@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-5-f427c743dda0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606-printk-cleanup-part2-v1-5-f427c743dda0@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_063332_505790_A024A52A 
X-CRM114-Status: GOOD (  25.55  )
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

On Fri 2025-06-06 23:53:47, Marcos Paulo de Souza wrote:
> All consoles found on for_each_console are registered, meaning that all of
> them are CON_ENABLED. The code tries to find an active console, so check if the
> console is not suspended instead.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  arch/um/kernel/kmsg_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> index 4190211752726593dd2847f66efd9d3a61cea982..f3025b2a813453f479d720618c630bee135d4e08 100644
> --- a/arch/um/kernel/kmsg_dump.c
> +++ b/arch/um/kernel/kmsg_dump.c
> @@ -31,7 +31,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>  		 * expected to output the crash information.
>  		 */
>  		if (strcmp(con->name, "ttynull") != 0 &&
> -		    (console_srcu_read_flags(con) & CON_ENABLED)) {
> +		    (console_srcu_read_flags(con) & CON_SUSPENDED) == 0) {
>  			break;

I think that we should actually replace the check of the
CON_ENABLE/CON_SUSPENDED flag with

		is_console_usable(con, console_srcu_read_flags(con), true)

And it should be done at the beginning of the patchset before
changing the semantic of the flags.

Motivation:

There is the following comment at the beginning of the function:

	/*
	 * If no consoles are available to output crash information, dump
	 * the kmsg buffer to stdout.
	 */

The if-condition checks for:

  + "ttynull" because this special console does not show any messages
    by definition

  + disabled/suspended consoles; note that this patchset is replacing
    CON_ENABLED with CON_SUSPENDED flag because it the state is
    changed during suspend.

But it should check also for:

  + whether the console is NBCON_console and does not have con->write_atomic
    because such a console would not be able to show the messages
    in panic().

And it should also check the global "consoles_suspended" flag. Because
consoles won't show anything when it is set.

And all these is already done by "is_console_usable()" except for
the check of "ttynull" which is very special.

How does the sound, please?

Best Regards,
Petr

>  		}
>  	}
> 
> -- 
> 2.49.0

