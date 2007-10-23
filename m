Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IkJIK-0005my-9z for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 05:55:40 -0700
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IkJII-0007vl-Qz
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 05:55:40 -0700
From: Andi Kleen <andi@firstfloor.org>
References: <20071022065202.GI2998@hacking>
	<20071022065943.GC10864@uranus.ravnborg.org>
	<20071022074823.GJ2998@hacking>
	<20071022113600.GA8181@ftp.linux.org.uk>
	<20071022122504.GL2998@hacking>
	<20071022124322.GB8181@ftp.linux.org.uk>
	<20071022124551.GA7438@elte.hu> <471D2ECC.6090209@goop.org>
	<20071022231927.GA30814@elte.hu> <471D389E.40609@goop.org>
	<20071023084546.GA17007@elte.hu>
Date: Tue, 23 Oct 2007 14:55:30 +0200
In-Reply-To: <20071023084546.GA17007@elte.hu> (Ingo Molnar's message of "Tue\, 
	23 Oct 2007 10\:45\:46 +0200")
Message-ID: <p73wste7zy5.fsf@bingen.suse.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] User Mode Linux still doesn't build in 2.6.23-final.
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, Al Viro <viro@ftp.linux.org.uk>, WANG Cong <xiyou.wangcong@gmail.com>, Sam Ravnborg <sam@ravnborg.org>

Ingo Molnar <mingo@elte.hu> writes:
>
> the 'fastcall removal' changes to paravirt.c were over-eager: they
> removed fastcall annotations from functions that are (or might be)
> implemented in assembly. So if someone changes the compiler model,
> such as -pg which disables regparm, the kernel breaks in nasty ways.

It would be probably better to just not disable -mregparms. I don't
think the compiler forces this. And e.g. on x86-64 regparms & -pg 
work just fine, why should it not on i386?

> so this patch adds back fastcall annotations. This serves as
> documentation for assembly calling-convention dependencies as
> well.

You should rename it then to "asmcall" or something.

-Andi

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
