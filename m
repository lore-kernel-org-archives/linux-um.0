Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4ACC7EE32
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 10:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gzuTLj0h0BP8Faa4F4QGiLAR1aawV6atkUr8dq493UA=; b=V8X3daDh2Yc3VFrLRgRtnYcEtC
	DNwa6u2lKY8l0A+WvQ9BNYbqru7c8oFYJOfTb0RjtlC0zP9aCSjRbThMeargRgVOSbL8ZrjR60ssD
	CK+UQYgBy3TjfYLOktuhEWl9xSvrwFtmKmpXu7UlWv+NzI0ICxrZTsVVKk7m/jP7sFKtFsGTOFbgQ
	nohP93NLzIlq+EkDm5q5Y6N3bfqg5UzM0TGrKC6EqOaK6ShNRe9rMFY9NFbHjSCZz88ySlMlGcrmh
	QFZVf1VMmxLsYXIh0d9FBFgXucjVs49SGa8XO/0JI58bmeQcS9W4uyqzU1RH+T/F+/ILmJ30Y64gs
	I6KiiaOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUNlD-00000008NRx-3YgA;
	Wed, 25 Jun 2025 10:53:47 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uULoX-000000081if-0HMp
	for linux-um@lists.infradead.org;
	Wed, 25 Jun 2025 08:49:06 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so3649606f8f.3
        for <linux-um@lists.infradead.org>; Wed, 25 Jun 2025 01:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750841343; x=1751446143; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gzuTLj0h0BP8Faa4F4QGiLAR1aawV6atkUr8dq493UA=;
        b=W8wMoICMD3GwWOQPje8R+DLCXJz2WfhGD152A4236/g1IAKBfWhpdmEADy1JyJ7yWV
         rD7/Ook5WzpGTWqIiMR217q6ZtT5eEv4BsKZqvhUSJEf9y9hhcQH/cuCxQ9jshoTu1K1
         WAdeVN3Astu9xuuh5e0mjtD5KKxqwOugMwq7Z6e22Cy/a1d53bxnEYNg/xODBaW9jIWR
         QTlSV3z/MZmAWvCvFImTy+GA2E2JpbwzNvTEgpUL4Lrc3z1urMHIk+fIU/Ehuc0eFeAv
         MQFjj9Gy+lODycDrV7WcV38XLrAW0UsrNr9oSPapERROOwZcHtzhksCMihtzg22sjlCZ
         7poQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841343; x=1751446143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzuTLj0h0BP8Faa4F4QGiLAR1aawV6atkUr8dq493UA=;
        b=FB5+pnOAivp0uGGkCItxBz/Joig1d1dX5ocH7UlK4ZvmXiazHy7lvSWhTN1xX6faty
         p1iQuaSOjAyBANZdUuHJV4s4tEsxC+8cvCkeyGnI/+GHLiL9fUD0HZwJ99LeyOjWmBxw
         hGH3G0kQGxdaEvofRSsAaHlcz867h0BD0MC473OunCaHjsuLWLEtlKhs0V+cF9rPhLDR
         JAaRbAypwrY1zIbPh33eFvurFjkdWztpzDIy4trm9p8kUYnnYH6ZXBcvo1kEfbCDjZBc
         w+e0FPsQYEb7a2SubVIlMmgLeDW5k/SOQrBtw/t8mpEzOn1+5X4X1FyM69vQvSrlBBuA
         9noA==
X-Forwarded-Encrypted: i=1; AJvYcCVA2gAAoA0js6wl9GxbO7rHlhxB/mLqJhRsChdmRm+Cz+H/OK2Y4PtInyR5veXKFb+fR24kUZHbxA==@lists.infradead.org
X-Gm-Message-State: AOJu0YysFLmoyp0hsCsA/p4X/DjRpcu0F6za2Vz6fEJBwq556ADvGyvn
	pQAOMhNaKVItwyY0zX5fpgIdY43rvw2L3DoUi1ZRERi7QMa1onmbmSmp2yVpWLZA+vI=
X-Gm-Gg: ASbGncsvmMLx9Ci5FaKXGQ8mPp0BsYBNvjTcxVBsFdHw+zmFtnIJfj0bTmMu8r/Rw6f
	sUFgZ3gYOGTxlqm+8v9pBSdnrGZjPJHFC/uYt0DicodOGaPWt2UKxA7uV7V1Dxy4GShFH/AJhCV
	k+32+ftggofTg86I0fGq1FmO+MmS4mtjP36H6ATpD1tE9TIaaBHQtkBisOktOXTXbUhYqTwN8M8
	smzpblBEC9ToOgoCeaern0NmcbwY5pm7Wz4WfLOCKB5NU2qn/MYDtf0rNTwMTT/LTBiwUbJAcKb
	T0vC/xL1wadrD0IUFOhijXixWcI9LHkYdtZ5E8GxeF3d8KszPXm2x3Tbep9IEbGr
X-Google-Smtp-Source: AGHT+IF1swuTytOZ/mOzx/aDJsTp0hYVrC347nQzODYODKZFAGNs/udBAXxCCv2VIRKBSD921Bw3yg==
X-Received: by 2002:a05:6000:4803:b0:3a6:d191:a835 with SMTP id ffacd0b85a97d-3a6ed646453mr1182080f8f.41.1750841342692;
        Wed, 25 Jun 2025 01:49:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83ea243sm132652565ad.72.2025.06.25.01.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 01:49:02 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:48:45 +0200
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
Message-ID: <aFu37RyHZ4wYF-ZV@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>
 <aExBo-8cVOy6GegR@pathway.suse.cz>
 <84y0tmiidg.fsf@jogness.linutronix.de>
 <aFpkQHwNCslbKSP6@pathway.suse.cz>
 <84wm919z9i.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84wm919z9i.fsf@jogness.linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_014905_106776_94CB81AC 
X-CRM114-Status: GOOD (  23.98  )
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

On Tue 2025-06-24 13:10:25, John Ogness wrote:
> On 2025-06-24, Petr Mladek <pmladek@suse.com> wrote:
> >> > Variant C:
> >> > ==========
> >> >
> >> > Remove even @flags parameter from console_is_usable() and read both
> >> > values there directly.
> >> >
> >> > Many callers read @flags only because they call console_is_usable().
> >> > The change would simplify the code.
> >> >
> >> > But there are few exceptions:
> >> >
> >> >    2. Another exception is __pr_flush() where console_is_usable() is
> >> >       called twice with @use_atomic set "true" and "false".
> >> >
> >> >       We would want to read "con->flags" only once here. A solution
> >> >       would be to add a parameter to check both con->write_atomic
> >> >       and con->write_thread in a single call.
> >> 
> >> Or it could become a bitmask of printing types to check:
> >> 
> >> #define ATOMIC_PRINTING 0x1
> >> #define NONATOMIC_PRINTING 0x2
> >> 
> >> and then __pr_flush() looks like:
> >> 
> >> if (!console_is_usable(c, flags, ATOMIC_PRINTING|NONATOMIC_PRINTING)
> >
> > I like this. It will help even in all other cases when one mode is needed.
> > I mean that, for example:
> >
> >    console_is_usable(c, flags, ATOMIC_PRINTING)
> >
> > is more self-explaining than
> >
> >    console_is_usable(c, flags, true)
> 
> After I wrote that suggestion, I decided that the naming is not
> good. There is always confusion about what "atomic printing" means. For
> that reason the parameter was changed to "use_atomic". Basically we are
> specifying which callback to use and not the purpose. It is a bit tricky
> because legacy consoles do not have an atomic callback, i.e. the
> parameter only has meaning for nbcon consoles.
> 
> Perhaps these macros would be more suitable:
> 
> #define NBCON_USE_ATOMIC 0x1
> #define NBCON_USE_THREAD 0x2

I personally prefer this variant.

> or
> 
> #define NBCON_USE_WRITE_ATOMIC 0x1
> #define NBCON_USE_WRITE_THREAD 0x2

This one sounds more precise but it very long.

> or
> 
> #define NBCON_ATOMIC_CB 0x1
> #define NBCON_THREAD_CB 0x2
> 
> or
> 
> #define NBCON_ATOMIC_FUNC 0x1
> #define NBCON_THREAD_FUNC 0x2
> 
> Hopefully that gives Petr enough ideas that he can come up with good
> naming. ;-)

I thought about better names yesterday but I somehow did not have
inspiration ;-) Thanks for coming with the variants.

Best Regards,
Petr

