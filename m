Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BlYQu-0000i9-FS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jul 2004 12:31:48 -0700
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BlYQu-0007NF-0G for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jul 2004 12:31:48 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
In-Reply-To: <40F82AF4.10600@cyberlot.net>
Message-ID: <Pine.LNX.4.58.0407161525380.16872@sparrow>
References: <40F82AF4.10600@cyberlot.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: UML and smp
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 16 Jul 2004 15:29:21 -0400 (EDT)
To: Richard Thomas <cyberlot@cyberlot.net>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>

Good afternoon, Richard,

On Fri, 16 Jul 2004, Richard Thomas wrote:

> Have you had any luck or even tried to get a SMP uml kernel compiled..
> 
> I am currently using your 2.6.7 kernel but I would like one with SMP 
> support but just can't get it to compile

	The problem is that, to the best of my knowledge, SMP and SKAS do 
not work together.  I personally need skas more than I need SMP so I 
haven't tried SMP in quite a while.
	If you really need SMP, fall back on the 2.4 series and turn on 
just Tracing Thread.  If that works, then try 2.6 with just tracing 
thread.
	(BTW, future discussion on this should probably happen on the 
uml-devel mailing list; I don't personally maintain UML patches, I just 
use the work that Jeff and other real developers have done.)
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "I love deadlines. I love the whooshing sound they make as they
go by."
        -- Douglas Adams
(Courtesy of Nick Tarleton <nickptar@mindspring.com>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
