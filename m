Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IOays-0004yS-KV for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Aug 2007 08:21:51 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IOayq-0006Xx-51
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Aug 2007 08:21:49 -0700
Date: Fri, 24 Aug 2007 11:21:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070824152127.GA7190@c2.user-mode-linux.org>
References: <20070817194342.GA8759@c2.user-mode-linux.org>
	<alpine.LFD.0.999.0708181924020.29105@enigma.security.iitk.ac.in>
	<200708231655.00034.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200708231655.00034.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 6/6] UML - Fix hostfs style
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, Satyam Sharma <satyam@infradead.org>, Joe Perches <joe@perches.com>

On Thu, Aug 23, 2007 at 04:54:59PM +0200, Blaisorblade wrote:
> > actually. Personally I'd prefer:
> >
> > 	else
> > 		type = OS_TYPE_DIR;
> 
> I strongly agree with this style; beyond style itself, one strong reason is 
> that joining statements hinder singlestepping through function code (it's 
> easy to run gdb on UML, and anyway kgdb exists).

How does that help?  gdb should stop as easily on a "else foo;" line as on 
	else
		foo;
right?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
