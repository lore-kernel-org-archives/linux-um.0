Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Imv60-0003D5-Nk for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Oct 2007 10:41:45 -0700
Received: from dsl022.labridge.com ([206.117.136.22] helo=perches.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Imv5z-0008Km-Ak
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Oct 2007 10:41:44 -0700
From: Joe Perches <joe@perches.com>
In-Reply-To: <20071030172849.GA8367@c2.user-mode-linux.org>
References: <20071030172849.GA8367@c2.user-mode-linux.org>
Date: Tue, 30 Oct 2007 10:40:46 -0700
Message-Id: <1193766046.24844.19.camel@localhost>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 3/4] UML - Implement get_wchan
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, 2007-10-30 at 13:28 -0400, Jeff Dike wrote:
> +unsigned long get_wchan(struct task_struct *p)
> +{
> +	unsigned long stack_page, sp, ip, count = 0;

Perhaps instead of unsigned long?

bool skipped_ip;	//delayed initialization

> +
> +	if ((p == NULL) || (p == current) || (p->state == TASK_RUNNING))
> +		return 0;
> +
> +	stack_page = (unsigned long) task_stack_page(p);
> +	/* Bail if the process has no kernel stack for some reason */
> +	if (stack_page == 0)
> +		return 0;
> +
> +	sp = p->thread.switch_buf->JB_SP;
> +	/*
> +	 * Bail if the stack pointer is below the bottom of the kernel
> +	 * stack for some reason
> +	 */
> +	if (sp < stack_page)
> +		return 0;
> +

	skipped_ip = false;

> +	while (sp < stack_page + THREAD_SIZE) {
> +		ip = *((unsigned long *) sp);
> +		if (kernel_text_address(ip) && !in_sched_functions(ip)) {
> +			/*
> +			 * Skip one valid IP, which will be the low-level UML
> +			 * context switcher.
> +			 */
> +			if (count++ == 1)
> +				return ip;

			if (skipped_ip)
				return ip;
			skipped_ip = true;
> 
> +		}
> +
> +		sp += sizeof(unsigned long);
> +	}



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
