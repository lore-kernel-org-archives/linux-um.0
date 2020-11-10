Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcRoV-0005xK-8D
 for linux-um@lists.infradead.org; Tue, 10 Nov 2020 11:27:52 +0000
Message-ID: <1e0dc5977c309d777ff4155565eb4d667733256a.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Fetch registers only for signals which need them
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 10 Nov 2020 12:27:47 +0100
In-Reply-To: <20201110111137.16117-1-anton.ivanov@cambridgegreys.com>
References: <20201110111137.16117-1-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at

On Tue, 2020-11-10 at 11:11 +0000, anton.ivanov@cambridgegreys.com
wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> UML userspace fetches siginfo and passes it to signal handlers
> in UML. This is needed only for some of the signals, because
> key handlers like SIGIO make no use of this variable.

It looks like even for SIGSEGV it depends on PTRACE_FULL_FAULTINFO,
which is only set for 64-bit?


> -			ptrace(PTRACE_GETSIGINFO, pid, 0, (struct siginfo *)&si);
> +			switch (sig) {
> +			case SIGSEGV:
> +			case SIGTRAP:
> +			case SIGILL:
> +			case SIGBUS:
> +			case SIGFPE:
> +			case SIGWINCH:
> +				ptrace(PTRACE_GETSIGINFO, pid, 0, (struct siginfo *)&si);
> +				break;
> +			}
>  
>  			switch (sig) {
>  			case SIGSEGV:

So perhaps it might make sense to push it further down into that switch?
It'd end up duplicating it to three places though.

In the SIGIO case you could write it as

case SIGILL:
case SIGBUS:
case SIGFPE:
case SIGWINCH:
	ptrace(...);
	fallthrough;
case SIGIO:
	block_signals_trace();
	// etc

But I have no strong opinion either way really.


I do think a comment is needed though, because we _do_ pass the pointer
to the sigio handler ... or maybe separate that out just like
handle_trap() etc.?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

