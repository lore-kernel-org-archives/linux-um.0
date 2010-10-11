Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Mon, 11 Oct 2010 15:14:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20101011151447.1a022f25.akpm@linux-foundation.org>
In-Reply-To: <1286832575-21474-1-git-send-email-richard@nod.at>
References: <1286832575-21474-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/1] um: Get rid of __do_IRQ()
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
Cc: user-mode-linux-devel@lists.sourceforge.net, peterz@infradead.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net, tj@kernel.org, tglx@linutronix.de, mingo@elte.hu

On Mon, 11 Oct 2010 23:29:35 +0200
Richard Weinberger <richard@nod.at> wrote:

> This patch removes __do_IRQ() from user mode linux.

I'd never actually noticed CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ.

What's the plan here?  Are all architectures supposed to me migrating
away from __do_IRQ() and over to generic_handle_irq(), or what?


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

