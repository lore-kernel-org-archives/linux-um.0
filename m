Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IjwfZ-0003G9-VZ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 05:46:13 -0700
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IjwfY-0006CX-Hl
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 05:46:09 -0700
Date: Mon, 22 Oct 2007 14:45:51 +0200
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20071022124551.GA7438@elte.hu>
References: <20071022043746.GF2998@hacking>
	<20071022052214.GY8181@ftp.linux.org.uk>
	<20071022061245.GG2998@hacking> <87d4v7fy5i.fsf@hades.wkstn.nix>
	<20071022065202.GI2998@hacking>
	<20071022065943.GC10864@uranus.ravnborg.org>
	<20071022074823.GJ2998@hacking>
	<20071022113600.GA8181@ftp.linux.org.uk>
	<20071022122504.GL2998@hacking>
	<20071022124322.GB8181@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071022124322.GB8181@ftp.linux.org.uk>
Subject: Re: [uml-devel] User Mode Linux still doesn't build in	2.6.23-final.
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
To: Al Viro <viro@ftp.linux.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, WANG Cong <xiyou.wangcong@gmail.com>, Sam Ravnborg <sam@ravnborg.org>


* Al Viro <viro@ftp.linux.org.uk> wrote:

> in kernel/sched.c
> 
> FWIW, I would simply kill the damn fastcall thing - right now the only 
> user is uml/i386; everything else either has it #defined to nothing or 
> (as i386 does) passes -mregparm=3 while having fastcall expand to 
> __attribute__((regparm(3))) - i.e. has all functions fastcall.
> 
> Do we really need it on uml/i386 enough to keep bothering with that 
> mess?

we should kill it there too.

the only place where we should _please_ keep those annotations are for 
functions that get called from assembly code. This makes life immensely 
easier for -pg (CONFIG_FUNCTION_TRACING) kernels.

	Ingo

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
