Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IkN4k-0001O4-FO for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 09:57:54 -0700
Received: from one.firstfloor.org ([213.235.205.2] ident=nadie)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IkN4j-0006Iy-2e
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 09:57:54 -0700
Date: Tue, 23 Oct 2007 18:57:46 +0200
From: Andi Kleen <andi@firstfloor.org>
Message-ID: <20071023165746.GA28392@one.firstfloor.org>
References: <20071022231927.GA30814@elte.hu> <471D389E.40609@goop.org>
	<20071023084546.GA17007@elte.hu> <p73wste7zy5.fsf@bingen.suse.de>
	<20071023131009.GA32298@elte.hu> <p73sl427wvu.fsf@bingen.suse.de>
	<20071023142006.GA9961@elte.hu>
	<20071023144852.GA27956@one.firstfloor.org>
	<20071023151309.GA14998@elte.hu> <20071023154417.GA24016@elte.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071023154417.GA24016@elte.hu>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Andi Kleen <andi@firstfloor.org>, Rob Landley <rob@landley.net>, Al Viro <viro@ftp.linux.org.uk>, WANG Cong <xiyou.wangcong@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sam Ravnborg <sam@ravnborg.org>

On Tue, Oct 23, 2007 at 05:44:17PM +0200, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > [...] -pg should in theory work with -mregparms.
> > 
> > last i checked it didnt work - i'll re-check that.
> 
> earlier gcc versions had problems with -mregparm and with -pg. I just 

Which version was that? 

> did a quick test with latest gcc and at a quick glance it seems to work 
> better - i'll propagate that throught he whole latency tracer to see 
> whether it's indeed working throughout. Anyway, this means that there's 
> no urgent need for this patch and we've dropped it from the x86 queue 
> for now. As long as it only affects older gcc's it's probably not worth 
> force-keeping the annotations for that purpose alone.

Great.

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
