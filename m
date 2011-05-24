Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Tue, 24 May 2011 22:14:20 +0200
References: <1306075716-20042-1-git-send-email-richard@nod.at> <1306075716-20042-5-git-send-email-richard@nod.at> <20110524123433.0b74f33e.akpm@linux-foundation.org>
In-Reply-To: <20110524123433.0b74f33e.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201105242214.21102.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 5/7] um: print info about fatal segfaults
To: Andrew Morton <akpm@linux-foundation.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Dienstag 24 Mai 2011, 21:34:33 schrieb Andrew Morton:
> Please see the nice comment in printk.h
> 
> /*
>  * Please don't use printk_ratelimit(), because it shares ratelimiting
> state * with all other unrelated printk_ratelimit() callsites.  Instead
> use * printk_ratelimited() or plain old __ratelimit().
>  */
> 
> I thought we had a checkpatch rule for this but apparently I dreamed
> it.

Hmm, it seems I'm not the only one who doesn't know that. :-\
rw@raccoon:/media/data1/linux-2.6 (master)> grep * -R -e "printk_ratelimit()" | wc -l
243

Anyway, will resend...

Thanks,
//richard
