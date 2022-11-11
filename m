Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B977C4332F
	for <linux-um@archiver.kernel.org>; Fri, 11 Nov 2022 14:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/8AxhccHGMh7VL56pdksR1py/U8h0nprAFEMqfxU3yc=; b=01o5IG5481ed/a
	5ys7ngEnJ2xUOyq7/oWdQPwktwxI4/qFI6s9YdBx9Nxvr0+81R1GfG8dT1Lvb9O4mN4hwVeoFNYBn
	uUlFJIOs/F0XFTin6KbJOAWg/BXCr+GrPlgz7omWNTxCvjQak38Pom3g62gOKYU2BIoDRrxr74I9q
	A0YnRG9vf/W/cgFiFXE+5vPebKVfL8AbCaE5RkWUvRCLyQghBzG+3Ii/FzNmd/q37k8mxNPfb9Fvz
	soCQrMryjcfRSnZ3ECNv+Vre/TwXvIMKBlKZkMAmA6OYWO/OdE/IqJIyfhkBYPn6EbzEpdxFE2NXq
	flref2O2UGdZc1MhhPXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otVG2-00GIlJ-9V; Fri, 11 Nov 2022 14:43:50 +0000
Received: from smtpout.efficios.com ([167.114.26.122])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otVFu-00GIgC-W8; Fri, 11 Nov 2022 14:43:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1668177821;
	bh=EYvFyeYoIXdpRZUrDIt9Kwnd3gAkvdIgxw1lIXG8SKY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l66N3oiBVl0WpLOT0hkLWrSBLQJsJSW4+ouPxFZH5QD5KKmXDB6CMjzwtM8VVLLpX
	 a4mvKpJXJiuV9Qw3ANDqSRII+7K5waLtTRLYZ90oeO3HFXyKJpVusI8jz1TOHWpOiX
	 dJRcqsFN0mN40E/3U0KhejsRReLLA8QsqIZLb9mPKd4oL95EyLfXlhHXXYFtuTieM/
	 mQitMOSC/OQ89QyOELCnHdOHRibH9OXvgNxVpUIxiREjJL0PTMu3jrCYcnxgmXCUU+
	 h1vYvH07RGr00OmtJNBP+zQXctnrrr738WJXcAPDjU36sTOHtCkNno5wnO/vjAKkO+
	 R+/kME1qSOXkw==
Received: from [172.16.0.153] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4N81fh5HFrzgt1;
	Fri, 11 Nov 2022 09:43:40 -0500 (EST)
Message-ID: <02cdf436-6942-89a7-98b2-bfa75ba5f301@efficios.com>
Date: Fri, 11 Nov 2022 09:43:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH printk v3 00/40] reduce console_lock scope
Content-Language: en-US
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
 rcu@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Douglas Anderson <dianders@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, kgdb-bugreport@lists.sourceforge.net,
 linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Luis Chamberlain <mcgrof@kernel.org>, Aaron Tomlin <atomlin@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Tony Lindgren <tony@atomide.com>, Lukas Wunner <lukas@wunner.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Mathias Nyman <mathias.nyman@linux.intel.com>, linux-usb@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Tom Rix <trix@redhat.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221111_064343_134715_79159272 
X-CRM114-Status: GOOD (  17.10  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 2022-11-07 09:15, John Ogness wrote:
[...]
> 
> The base commit for this series is from Paul McKenney's RCU tree
> and provides an NMI-safe SRCU implementation [1]. Without the
> NMI-safe SRCU implementation, this series is not less safe than
> mainline. But we will need the NMI-safe SRCU implementation for
> atomic consoles anyway, so we might as well get it in
> now. Especially since it _does_ increase the reliability for
> mainline in the panic path.

So, your email got me to review the SRCU nmi-safe series:

[1] https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=srcunmisafe.2022.10.21a

Especially this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=srcunmisafe.2022.10.21a&id=5d0f5953b60f5f7a278085b55ddc73e2932f4c33

I disagree with the overall approach taken there, which is to create
yet another SRCU flavor, this time with explicit "nmi-safe" read-locks.
This adds complexity to the kernel APIs and I think we can be clever
about this and make SRCU nmi-safe without requiring a whole new incompatible
API.

You can find the basic idea needed to achieve this in the libside RCU
user-space implementation. I needed to introduce a split-counter concept
to support rseq vs atomics to keep track of per-cpu grace period counters.
The "rseq" counter is the fast-path, but if rseq fails, the abort handler
uses the atomic counter instead.

https://github.com/compudj/side/blob/main/src/rcu.h#L23

struct side_rcu_percpu_count {
	uintptr_t begin;
	uintptr_t rseq_begin;
	uintptr_t end;
	uintptr_t rseq_end;
}  __attribute__((__aligned__(SIDE_CACHE_LINE_SIZE)));

The idea is to "split" each percpu counter into two counters, one for rseq,
and the other for atomics. When a grace period wants to observe the value of
a percpu counter, it simply sums the two counters:

https://github.com/compudj/side/blob/main/src/rcu.c#L112

The same idea can be applied to SRCU in the kernel: one counter for percpu ops,
and the other counter for nmi context, so basically:

srcu_read_lock()

if (likely(!in_nmi()))
   increment the percpu-ops lock counter
else
   increment the atomic lock counter

srcu_read_unlock()

if (likely(!in_nmi()))
   increment the percpu-ops unlock counter
else
   increment the atomic unlock counter

Then in the grace period sum the percpu-ops and the atomic values whenever
each counter value is read.

This would allow SRCU to be NMI-safe without requiring the callers to
explicitly state whether they need to be nmi-safe or not, and would only
take the overhead of the atomics in the NMI handlers rather than for all
users which happen to use SRCU read locks shared with nmi handlers.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
