Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1332748746.16159.62.camel@twins>
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Mon, 26 Mar 2012 09:59:06 +0200
In-Reply-To: <20120325174210.GA23605@redhat.com>
References: <20120324102609.GA28356@lizard> <20120324102751.GA29067@lizard>
	 <1332593021.16159.27.camel@twins> <20120324164316.GB3640@lizard>
	 <20120325174210.GA23605@redhat.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2.1 01/10] cpu: Introduce clear_tasks_mm_cpumask()
 helper
To: Oleg Nesterov <oleg@redhat.com>
Cc: Anton Vorontsov <anton.vorontsov@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Richard Weinberger <richard@nod.at>, Paul Mundt <lethal@linux-sh.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, John Stultz <john.stultz@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-mm@kvack.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, 2012-03-25 at 19:42 +0200, Oleg Nesterov wrote:
> __cpu_disable() is called by __stop_machine(), we know that nobody
> can preempt us and other CPUs can do nothing. 

It would be very good to not rely on that though, I would love to get
rid of the stop_machine usage in cpu hotplug some day.
