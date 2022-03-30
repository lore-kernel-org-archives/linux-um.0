Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZXVu-00FkEq-SJ
 for linux-um@lists.infradead.org; Wed, 30 Mar 2022 12:33:33 +0000
Message-ID: <c1ff43de7d64831d8f40e8e11177f005b9940050.camel@sipsolutions.net>
Subject: Re: UML time-travel warning from __run_timers
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 30 Mar 2022 14:33:23 +0200
In-Reply-To: <20220330110156.GA9250@axis.com>
References: <20220330110156.GA9250@axis.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, 2022-03-30 at 13:01 +0200, Vincent Whitchurch wrote:
> Hello Johannes,
> 
> As requested in the roadtest thread[0], here is some information about
> reproducing the warnings I'm seeing from the timekeeping code with time
> travel in UML, after about 10-20 wall time seconds of idling.
> 
> [0] https://lore.kernel.org/lkml/5b39d572e619c812109af7a1b8028bfb8353efda.camel@sipsolutions.net/
> 
> The warning is the WARN_ON_ONCE(!levels && !base->next_expiry_recalc) in
> __run_timers().  The log and the config generated with savedefconfig are
> below.  The full .config is attached.
> 
> The kernel version is v5.17, but the splats are seen on older kernels
> and on latest mainline also.
> 

So interestingly, I cannot reproduce it with my config (it's already
March 2023), but I can with yours ...

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

