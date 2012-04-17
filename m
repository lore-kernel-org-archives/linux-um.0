Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Apr 2012 22:43:56 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1334695036-19977-4-git-send-email-richard@nod.at>
Message-ID: <alpine.LFD.2.02.1204172243110.2542@ionos>
References: <1334695036-19977-1-git-send-email-richard@nod.at> <1334695036-19977-4-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 4/4] irq: Remove irq_chip->release()
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, 17 Apr 2012, Richard Weinberger wrote:

> As it's only user (UML) does no longer need it we can get
> rid of it.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

Nice work!

Please add my Reviewed-by to the series.

Thanks,

	tglx
