Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2AAC71141
	for <linux-um@archiver.kernel.org>; Thu, 12 Jun 2025 13:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VpdeBAczxDpMxHPi8ej3bXu0PaquJ+drDxjVDx3klZk=; b=I7+ITP4kiNSV1pQLimVOJCu+u9
	6OfLyGSzhaSQ4qa5uSWr4nHAn+0rBnGLaF6jBsdck0352/PIVsdUypdqwcfpuevdpjmt+tsLQm81e
	Sphk3kXqttdn0Iactrt7miaac/bWzdlSRnGjH5ymCQhcpgGz/9MAeAimhLcW0KIPzVaYre9QUdICo
	XKR/E3TyBXSBzutJNh2v9x1ZvcdxinZ2K0MwvfR9AgRgVkLv5ntl/3FZaavel5PyDgcYbA37RL8QK
	pQtWetcGVVWMis5dxt2F1gFE3b9f7CR2NqTNcXf99cMT2wP573ubE02jK5t22w7eXWL9xf8pXdXWu
	WMZQ25iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPhqO-0000000DO1V-17rH;
	Thu, 12 Jun 2025 13:19:48 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPgO2-0000000DBPa-34JV
	for linux-um@lists.infradead.org;
	Thu, 12 Jun 2025 11:46:28 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so550386f8f.0
        for <linux-um@lists.infradead.org>; Thu, 12 Jun 2025 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749728785; x=1750333585; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpdeBAczxDpMxHPi8ej3bXu0PaquJ+drDxjVDx3klZk=;
        b=T30TVMZruy+AAxBNgZwPp1VVv85ngT7WJSQBrDrYuNqboWci24jXbIa9j9d8t/vNEP
         40AqlFukSPD9sqnNpcWCv49opAI3Y7MyVITgW0lU92OmEv0r7r4Ao1qvk+5mTzfzaSiZ
         tkupy58WzR4qiWcZM4AyAy7av0dCrHS+0l7Z34pQ0ldS2Pe5R1MRYW9/JjaUE299bdMW
         62wKJaQFoQXiMTaK1s/UnBycEnSLz1F7Rm+tkAxWHf1m/C6rxx8UV+NLMVyr7tlx2bC4
         gHHIzeIcDc/k2w1Oe4ESIDbn3KuyhG8Jn7YDO9YuFF9nkmmPcLVwvVrj656d2/kegOGd
         axaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749728785; x=1750333585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpdeBAczxDpMxHPi8ej3bXu0PaquJ+drDxjVDx3klZk=;
        b=k2SGlUD1WhWiz3DCglL/H/5WHK9lOMARYVevBDAwHUZe4CCB8q5rtW+MX0hu4x9AqD
         8CqxHc56e524PEfV/5A3yatrymuNVhxqmPfAru6rl+STBaVyb8OaMcBarRCsToG09uzj
         pdh1NszZPiZmxwfc9r98z3biYg6y2+6z5UK7m5lOVlPOhiGA4NxJFWsL82cz8CiYf+my
         KsHzkggeSttOdM0mmqo1SZgLvbhZ6QrPTosC4ai7p3LoAW5H/BzZ4bHwiyjAzCnpMo3A
         eY4w97qDT+rWYUpXTiUd6aCsr0JlDpzY9Y8l062aGwhpu59iOBFZNTpEpgDyAbTmC+Ce
         yrIA==
X-Forwarded-Encrypted: i=1; AJvYcCWwZS9EqEJQwS/FiL4m+sWaHI1XVS1DCGnIzwWY1figPRQpiG+X7F6pT2WcdTdJss1zVKKeUb1b9w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzsbzqualv72QWfh5SW0z1YKoS7UZdQehNBckpkn1e/Hfa/Itrd
	rBS42KzrfKHMWdu2bt3hNBvwXm9ZZua/WvDIzhiCFJtW4Nfpy0cdEFhr9/uNLCNo2hw=
X-Gm-Gg: ASbGnctFbiD49pjDnCl7pi7snHk1ilC18x5otnWMdToxESuBPL0BCBvMX7HSRT5L6lH
	AKRMcImV/cOC8Y1bYsHS3Po+WxNKfYPvIBu9afko4d40UqBH/p/fB+svGNXnfTqm4EDBxSquk3L
	/yMdRUqvDEJxqiADhiWb5VB321bI9EY7deRXVm9CbPZEbbgoBvkUO8tRSoFLur3+yjKeAgbJoxB
	QvizmvjP5vJyNCQ3y2ozkWfojtRqas7NqJbA/QY2x9XlOsYg3pldO+bbpx2Ew/3h5as+alW18Il
	W6jaN2jiP5PgeLgopJftcbArEZ3hqfU5hfqEYLqbbZYBabuQ/tM2uNTpcu5QOYZw
X-Google-Smtp-Source: AGHT+IF/248Rvx3CVC08UaAQ4P3dTeJa+QHLA+I/CORpcgGm1jvrTGpa+IJI7ILEeBXIza4gfGGQkg==
X-Received: by 2002:a05:6000:288e:b0:3a5:271e:c684 with SMTP id ffacd0b85a97d-3a560814897mr2780693f8f.24.1749728784595;
        Thu, 12 Jun 2025 04:46:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19dcd05sm1406413a91.14.2025.06.12.04.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 04:46:23 -0700 (PDT)
Date: Thu, 12 Jun 2025 13:46:06 +0200
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
Subject: Re: [PATCH 1/7] printk: Make console_{suspend,resume} handle
 CON_SUSPENDED
Message-ID: <aEq9_kOoLSQwuYBq@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-1-f427c743dda0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606-printk-cleanup-part2-v1-1-f427c743dda0@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_044626_770675_87BC0926 
X-CRM114-Status: GOOD (  13.15  )
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

On Fri 2025-06-06 23:53:43, Marcos Paulo de Souza wrote:
> Since commit 9e70a5e109a4 ("printk: Add per-console suspended state") the
> CON_SUSPENDED flag was introced, and this flag was being checked on
> console_is_usable function, which returns false if the console is suspended.
> 
> No functional changes.

I double checked potential functional changes. In particular, I
checked where the CON_ENABLED and CON_SUSPENDED flags were used.

Both flags seems to have the same effect in most situations,
for example, in console_is_usable() or console_unblank().

But there seems to be two exceptions: kdb_msg_write() and
show_cons_active(). These two functions check only
the CON_ENABLED flag. And they think that the console is
usable when the flag is set.

The change in this patch would change the behavior of the two
functions during suspend. It is later fixed by the 3rd and 4th
patch. But it might cause regressions during bisections.

It is probably not a big deal because the system is not much
usable during the suspend anyway. But still, I would feel more
comfortable if we prevented the "temporary" regression.

I see two possibilities:

   1. Merge the 3rd and 4th patch into this one. It would change
      the semantic in a single patch.

   2. First update kdb_msg_write() and show_cons_active()
      to check both CON_ENABLE and CON_SUSPENDED flags.

The 1st solution probably makes more sense because we are going
to remove the CON_ENABLE flag in the end. And even the merged
patch is small enough.

Best Regards,
Petr

