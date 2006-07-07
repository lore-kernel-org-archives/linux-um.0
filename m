Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FyyEf-0005pq-Hx for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2006 14:51:41 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1FyyEe-00089l-9b
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2006 14:51:41 -0700
Date: Fri, 7 Jul 2006 14:55:16 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20060707145516.6df4afb3.akpm@osdl.org>
In-Reply-To: <200607070033.k670XaAg008677@ccure.user-mode-linux.org>
References: <200607070033.k670XaAg008677@ccure.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 4/19] UML - timer initialization cleanup
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike <jdike@addtoit.com> wrote:
>
> +	err = request_irq(TIMER_IRQ, um_timer, SA_INTERRUPT, "timer", NULL);

SA_INTERRUPT is deprecated - I'll change this to IRQF_DISABLED.

We have a compatibility layer for now, but we need to start getting used to
using INTF_*.

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
