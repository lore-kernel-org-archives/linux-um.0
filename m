Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IkLvt-0000wT-QL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 08:44:41 -0700
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IkLvt-0004gN-Am
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 08:44:41 -0700
Date: Tue, 23 Oct 2007 17:44:17 +0200
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20071023154417.GA24016@elte.hu>
References: <471D2ECC.6090209@goop.org> <20071022231927.GA30814@elte.hu>
	<471D389E.40609@goop.org> <20071023084546.GA17007@elte.hu>
	<p73wste7zy5.fsf@bingen.suse.de> <20071023131009.GA32298@elte.hu>
	<p73sl427wvu.fsf@bingen.suse.de> <20071023142006.GA9961@elte.hu>
	<20071023144852.GA27956@one.firstfloor.org>
	<20071023151309.GA14998@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071023151309.GA14998@elte.hu>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, Al Viro <viro@ftp.linux.org.uk>, WANG Cong <xiyou.wangcong@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sam Ravnborg <sam@ravnborg.org>


* Ingo Molnar <mingo@elte.hu> wrote:

> > [...] -pg should in theory work with -mregparms.
> 
> last i checked it didnt work - i'll re-check that.

earlier gcc versions had problems with -mregparm and with -pg. I just 
did a quick test with latest gcc and at a quick glance it seems to work 
better - i'll propagate that throught he whole latency tracer to see 
whether it's indeed working throughout. Anyway, this means that there's 
no urgent need for this patch and we've dropped it from the x86 queue 
for now. As long as it only affects older gcc's it's probably not worth 
force-keeping the annotations for that purpose alone.

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
