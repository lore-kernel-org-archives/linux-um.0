Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86910D10F4D
	for <linux-um@archiver.kernel.org>; Wed, 26 Nov 2025 13:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=azsrhZgWyYhx6NRpCHGgrx0NKRpo3MJZPtnrDvh+H7E=; b=I3F+dCHVLj5/Cb+8P80HQBiqSW
	S+iREAavXAfQUDKygy3WsCMImAidqcVlLg3YoZz+DNwoGyWrl1hkTWwSt0srzj8OGBSWleOnMHGWB
	+bNVmGC9GsH71TXCN5hjZcyHyH4w9nzfmiKF68oPdrxI7r+Hq/X1RUNVBDERAugAlWxYN2Yw8nN3I
	sj8wLl8lZ3BHF4dUdgYMCKiSKs1GCb/Qz9uVqweKqblbGpcXXO86h8d9EnIsWGZgdrgZCBKHj5VHl
	qD3Rg6HNXr2JPoOg5YAoMBDyzcZiQzjMP/PHCI26pSSGbbfHDw/x+VT05qXObWWTTwIvtky5D6QFv
	NXyKs6YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOFJs-0000000F29E-0inx;
	Wed, 26 Nov 2025 13:12:28 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOFJp-0000000F28g-1osE
	for linux-um@lists.infradead.org;
	Wed, 26 Nov 2025 13:12:27 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-47774d3536dso7253375e9.0
        for <linux-um@lists.infradead.org>; Wed, 26 Nov 2025 05:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764162743; x=1764767543; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=azsrhZgWyYhx6NRpCHGgrx0NKRpo3MJZPtnrDvh+H7E=;
        b=WzoNd3gTn84yJ60hBYEgM7eZRI7uGzZ6mdDfTN+RaLRCc0Q25/l6J+g3HEF0Mhpc4P
         xa0U8Ia50gKBeSY99p9FmE2dgJ7nogLlAP+jQZn69h4ibUyECfirCkFjRmJq5QBmW6b0
         UjrmPoy1N+lBNdGYutLkdZDhYZ208mnlD56JGcYMJt1frQVSvbdlV7KJiS6ZHkZqSW+w
         9iKdNVYlNZ2u5UJzr06F2UeeLgjLF47vLFkjTnXh6/TGl7VuzQFviPtWrmkEGHcAh/0S
         hz8WOe3ruXRjiU8SpfQOm1l0p9erBxd2duwk13GrxHkIFj/wpeNR9q0XnoWJzjHU1XL3
         X10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764162743; x=1764767543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azsrhZgWyYhx6NRpCHGgrx0NKRpo3MJZPtnrDvh+H7E=;
        b=kT9XWonyE5a4Gxr3Gsfu8jeYYpWlFxf75KDLdY7loP1fD5GIjXbmnpYoBeDN3vsaaD
         VwfJc3e5RZr2lsSUS3NFVBcl6xENw7hTbs7IRiSEX53mwORCqXSweqFWSZNXneTT44TM
         wveppqyI7/pshU+4KQ1jvGrXWz5JR2ySGSgsScw5flSBzvAHuZwOgwSWNu2+PJiLsXnJ
         YgHinlJO0e+uUfAgo3FjJEFx1eOo/fRQ2byeuQZWrL/Vpz4lS4eJBYUiRwu5jBUKxRu9
         siGauxjG3ecOZWTkiCW1r6HEfD/3EU+uJCUo8E49k32ArQvX6DYlKqJB9daRV0vdpd5p
         hDNA==
X-Forwarded-Encrypted: i=1; AJvYcCV5WaIA8cgYh2Hyl2ZBeLrJKaC2PdpZ+klEHqUFnt59ntV0c2a4LkrEIsDKNEnxiimTDzIQDstXEw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxM2qIrgjr7A3INkTlSY3dOvr450EnrKsIQNX4uSJvP+2rCUw2y
	tqzMpfgiYjkxglCFZfCQ3X51lg+5oEneiKXoqSPzJFJj2GObHwTKhpLNhNLGxZabb6HpIVPnHAF
	9Simm
X-Gm-Gg: ASbGncu8+NU9iVF2LwrMd4QbkVdsCe8ptiCt5oclo3pv5ahIvs+EBw5yY9jh6vELg+H
	pR0t5z4yE0Xz8L013IFOMJhroykh8wGCpFvhB/N/tE1bgB78NqfW/tRL2hpNdB08AIetUT2Nzlb
	f/5ivJb6S+UytzwL8F9gYizVSX9UIRQce0nMTdWwHqouYGUS5QzlzwBfl08ChAZLoKHhhB0KM0S
	L20BtDMl22RuViw8RqCr4R7rNE90vmSzWvyQXloknOFujqgsstPTahUsUyrvK4UA1/vmFIy+ZhN
	KpkVca9mkLPH4wtsdVY73GUDu/lTQBc3imSspZUHv5VlufkNgpfkP1KEZAVyKbnejZ6dF9457QE
	soEEDmMcvNviSfllPm0Vt7mGvNH8bgJIMFmoSN/W3o0NUWrKyhbaGt/5aqBcsxm8JzuUpj+T9YL
	4aI06Z9ljBjRs65Q==
X-Google-Smtp-Source: AGHT+IFEYv6UMcwGn4taVzPLuUnJBcIZRl4prj8V/wWkXOqPExh69hNsmDyiZhSbwf/siv21g/oC8w==
X-Received: by 2002:a05:600c:1e89:b0:477:a1bb:c58e with SMTP id 5b1f17b1804b1-477c04cfddcmr213170355e9.7.1764162743079;
        Wed, 26 Nov 2025 05:12:23 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34fe8sm40473140f8f.15.2025.11.26.05.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 05:12:22 -0800 (PST)
Date: Wed, 26 Nov 2025 14:12:19 +0100
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
Subject: Re: [PATCH v2 1/4] drivers: serial: kgdboc: Drop checks for
 CON_ENABLED and CON_BOOT
Message-ID: <aSb8s_N4Pc0yTk9f@pathway.suse.cz>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
 <20251121-printk-cleanup-part2-v2-1-57b8b78647f4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-printk-cleanup-part2-v2-1-57b8b78647f4@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_051225_670899_477626DE 
X-CRM114-Status: GOOD (  15.19  )
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

On Fri 2025-11-21 15:50:33, Marcos Paulo de Souza wrote:
> The original code tried to find a console that has CON_BOOT _or_
> CON_ENABLED flag set. The flag CON_ENABLED is set to all registered
> consoles, so in this case this check is always true, even for the
> CON_BOOT consoles.
> 
> The initial intent of the kgdboc_earlycon_init was to get a console
> early (CON_BOOT) or later on in the process (CON_ENABLED). The
> code was using for_each_console macro, meaning that all console structs
> were previously registered on the printk() machinery. At this point,
> any console found on for_each_console is safe for kgdboc_earlycon_init
> to use.
> 
> Dropping the check makes the code cleaner, and avoids further confusion
> by future readers of the code.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

I agree that the check is superfluous and can be removed:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

