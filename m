Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93103C7EE31
	for <linux-um@archiver.kernel.org>; Tue, 24 Jun 2025 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=42Y2N6ebar+wiBFiVwZ+1np3R1M+VYIv1aIQkqIKk40=; b=Mbmk/I3/OhuwVFK24pdwpM+adj
	OR9NGjnbyXRa44ESg/JN1hcmPbKvdCXKmxCaw9t7IXxI0rTyqn4omx/jm/q4ozfUDsUaW8nZGZAh4
	R7IQBew1NtVojQoz8kVKfhlYadxXXPVbVe+5fek5WWXjH5PqbK+GwwOL1BMComNWHm3SEZpMFErE7
	XA9UgJYRfEDPH8ysh+1z3FlGaPP/tCpbrq4d7M8I2XH7/7MHQ2+2Gs41gG+HtchK34SjWP0aBZdRd
	K/d3xb5p0PE9rvcstJoC0QtJGoBrLUo1mZgTKOLqp6aquAtCgSe6moiSYapp9L4c9X9IAztcqHVjx
	XtF0C1nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTzVO-000000056ZU-1yHg;
	Tue, 24 Jun 2025 08:59:50 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTzDE-000000053hB-3yZ6
	for linux-um@lists.infradead.org;
	Tue, 24 Jun 2025 08:41:06 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so4302308f8f.2
        for <linux-um@lists.infradead.org>; Tue, 24 Jun 2025 01:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750754463; x=1751359263; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=42Y2N6ebar+wiBFiVwZ+1np3R1M+VYIv1aIQkqIKk40=;
        b=a9oRNuF1nDRHw2n07RoN63D+/caYV0Xgyr1NCL+BC91Wn2/Y5MUsaqx6ixX+yFZ0ke
         MaGLJeGPhfS6bV99pY+p4y9ePUUsKBoXSkw+KNeUs0zo1kaT+4u7vIVGwbnaKfjgSS2L
         YwYssGbYuiN9yMNUzEHXme7TFCsbKF/wjPkyAgK//sg3y1lt+h7emYEVvogFcpQISJcm
         CHKKDijpobHzetgHbYqRhdKVBXYfL+/CwoHxOCwDNYcDGIhmJkSUekA1ACM33Up5Sav3
         wZYCTXz0X7QdhCwcVOWvRygLzHz/a6VWaLqNqSI4m4q0qawNB4XwCM4dczc8lTMR8qYf
         EMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750754463; x=1751359263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42Y2N6ebar+wiBFiVwZ+1np3R1M+VYIv1aIQkqIKk40=;
        b=xDpLJLvARy5/zi0VN3NUKQlmzujQBnrX9IWTHIEM3dR4tou5fB2WurLiFm0feXFqB5
         n+CEOXH7MoDHutmpUc6l6dDomskLvhmlv7R/ZH4Nl2FtZ9JVRvrhmXCJLh3x25ak45fD
         0eMLoEKe8K/w7wbbVDMIiTRDsi/EARzJl5ugdvY2Ot/kFXgbTAl1G4S0oydhjyucVmHT
         whPDJW0TxEe6Ue7DUzoV/TKkBEQhNWBH/FbgtLTgXIIH/pbmIsvVJLKzZfBtxZbR0Sxz
         E+PKeguSp9084aZnv1eTABGX5JHygEmABde3s7y+gCylQ+VEgwSuRI4vN8zxwefhqsqo
         QAhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrwcOg7fYrH/wjmFWRa1+z/sRZWWtY2p8v82yjeyizV3LkpinOgwhlCRLvRAoULaG5kVt+fmdROg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzdudCemtRIZESIp0s6vZZdDe/qDRCAe2IOaXvkd6WVIHGTbIT+
	63m+RemcwpZKlrpMFFLfvejkb2hefeYROapnmRLMgprRaAYPNfBDpsQtYR9RbkaYHEE=
X-Gm-Gg: ASbGncsV6KjIXfR6zr6VxPmEHcSgHa3NpOHbwbhm7frlssyYsSOLwe0OZjhrMoIx1Cl
	rS1D+z7nFUfPBhiG8hkYdI0I3YmuwOZPa0lRUcThnnTR6zj/So5Ut3Q/qgYCCvCoftEs9235DFf
	1r8RpOY5fUuP+a735wN3WqnThob8s5XQ2NugmnYdRbXzhoLLZyGGEpFb/oaUEMqxM5kqIhYKSqu
	0G95JiET+XPuIYtc0YmBM281IIppWw7VzOwdk+bGXrP9O/Jfsv8AmlXcW10Iw6AnFBSFlT28mnE
	EgI3LYzdQDzC7iVQZaVDFvh5hc3n1BYdfgueW1IqnfBeoxEql4IPcEaG9cIUPMan
X-Google-Smtp-Source: AGHT+IHSGyDwoYjnGgDbPlFSLTlqgEue3oGk1SeNKtOch4nBjPOzzj8KWkuWYgkah6BLwc+G22XXxA==
X-Received: by 2002:a05:6000:3111:b0:3a1:fcd6:1e6b with SMTP id ffacd0b85a97d-3a6d1334011mr11624969f8f.57.1750754462679;
        Tue, 24 Jun 2025 01:41:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e08e52sm1231044b3a.9.2025.06.24.01.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 01:41:02 -0700 (PDT)
Date: Tue, 24 Jun 2025 10:40:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [PATCH 2/7] printk: Use consoles_suspended flag when
 suspending/resuming all consoles
Message-ID: <aFpkQHwNCslbKSP6@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>
 <aExBo-8cVOy6GegR@pathway.suse.cz>
 <84y0tmiidg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84y0tmiidg.fsf@jogness.linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_014104_990597_CDA445F5 
X-CRM114-Status: GOOD (  23.79  )
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

On Fri 2025-06-20 16:49:07, John Ogness wrote:
> On 2025-06-13, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> >> index fd12efcc4aeda8883773d9807bc215f6e5cdf71a..72de12396e6f1bc5234acfdf6dcc393acf88d216 100644
> >> --- a/kernel/printk/nbcon.c
> >> +++ b/kernel/printk/nbcon.c
> >> @@ -1147,7 +1147,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
> >>  	cookie = console_srcu_read_lock();
> >>  
> >>  	flags = console_srcu_read_flags(con);
> >> -	if (console_is_usable(con, flags, false)) {
> >> +	if (console_is_usable(con, flags, false, consoles_suspended)) {
> >
> > The new global console_suspended value has the be synchronized the
> > same way as the current CON_SUSPENDED per-console flag.
> > It means that the value must be:
> >
> >   + updated only under console_list_lock together with
> >     synchronize_rcu().
> >
> >   + read using READ_ONCE() under console_srcu_read_lock()
> 
> Yes.
> 
> > I am going to propose more solutions because no one is obviously
> > the best one.
> 
> [...]
> 
> > Variant C:
> > ==========
> >
> > Remove even @flags parameter from console_is_usable() and read both
> > values there directly.
> >
> > Many callers read @flags only because they call console_is_usable().
> > The change would simplify the code.
> >
> > But there are few exceptions:
> >
> >    2. Another exception is __pr_flush() where console_is_usable() is
> >       called twice with @use_atomic set "true" and "false".
> >
> >       We would want to read "con->flags" only once here. A solution
> >       would be to add a parameter to check both con->write_atomic
> >       and con->write_thread in a single call.
> 
> Or it could become a bitmask of printing types to check:
> 
> #define ATOMIC_PRINTING 0x1
> #define NONATOMIC_PRINTING 0x2
> 
> and then __pr_flush() looks like:
> 
> if (!console_is_usable(c, flags, ATOMIC_PRINTING|NONATOMIC_PRINTING)

I like this. It will help even in all other cases when one mode is needed.
I mean that, for example:

   console_is_usable(c, flags, ATOMIC_PRINTING)

is more self-explaining than

   console_is_usable(c, flags, true)

Best Regards,
Petr

