Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 28 Mar 2012 00:20:32 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
In-Reply-To: <1332593574.16159.31.camel@twins>
Message-ID: <alpine.DEB.2.00.1203280020100.16201@chino.kir.corp.google.com>
References: <20120324102609.GA28356@lizard> <20120324103127.GJ29067@lizard> <1332593574.16159.31.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 10/10] oom: Make find_lock_task_mm() sparse-aware
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Anton Vorontsov <anton.vorontsov@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Russell King <linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Richard Weinberger <richard@nod.at>, Paul Mundt <lethal@linux-sh.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, John Stultz <john.stultz@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-mm@kvack.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, 24 Mar 2012, Peter Zijlstra wrote:

> Yeah, so Nacked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> Also, why didn't lockdep catch it?
> 
> Fix sparse already instead of smearing ugly all over.
> 

Fully agreed, please don't add this to the oom killer.
