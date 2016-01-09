Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1aHkqL-0001nu-NA
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Jan 2016 04:09:33 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aHkqK-0004oA-Ja
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Jan 2016 04:09:33 +0000
Date: Sat, 9 Jan 2016 04:09:25 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20160109040925.GC17997@ZenIV.linux.org.uk>
References: <1447836703-32594-1-git-send-email-richard@nod.at>
	<20160109035125.GA365@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160109035125.GA365@ZenIV.linux.org.uk>
Subject: Re: [uml-devel] [PATCH] um: Fix get_signal() usage
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard@nod.at>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Jan 09, 2016 at 03:51:25AM +0000, Al Viro wrote:
> On Wed, Nov 18, 2015 at 09:51:43AM +0100, Richard Weinberger wrote:
> > If get_signal() returns us a signal to post
> > we must not call it again, otherwise the already
> > posted signal will be overridden.
> > Before commit a610d6e672d this was the case as we stopped
> > the while after a successful handle_signal().
> 
> Old behaviour had been wrong.  If you have several pending signals,
> more than one sigframe should be built, as if the second, etc. had
> been delivered right on the entry into the handler.
> 
> Stopping after the first one is obviously wrong - consider the case
> when attempt to deliver it has raised SIGSEGV.

Note that subsequent signals do *not* override the register values set by
the first one - copy_sc_to_user() will store them in the corresponding
sigframes, so that after you reach the end of the handler for your second
signal {rt_,}sigreturn() will land you in the beginning of the first one.

Check how native x86 behaves - set a couple of handlers, block them with
sigprocmask(), raise both signals and unblock them.  Then have the
handlers examine and dump their struct ucontext (pointed to by the third
argument of handler).  You'll see that the first one to be executed will
have uc->uc_mcontext.ip pointing to the other handler and uc->uc_mcontext.ax
containing the other signal number.

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

