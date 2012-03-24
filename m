Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1332593303.16159.28.camel@twins>
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Sat, 24 Mar 2012 13:48:23 +0100
In-Reply-To: <20120324103030.GG29067@lizard>
References: <20120324102609.GA28356@lizard> <20120324103030.GG29067@lizard>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 07/10] um: Should hold tasklist_lock while traversing
 processes
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Russell King <linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Richard Weinberger <richard@nod.at>, Paul Mundt <lethal@linux-sh.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, John Stultz <john.stultz@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-mm@kvack.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, 2012-03-24 at 14:30 +0400, Anton Vorontsov wrote:
> Traversing the tasks requires holding tasklist_lock, otherwise it
> is unsafe. 

No it doesn't, it either requires tasklist_lock or rcu_read_lock().
