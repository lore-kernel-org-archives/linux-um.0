Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1As7YF-0007iE-Lk
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 14 Feb 2004 13:42:15 -0800
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1As7Vj-00050c-36
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 14 Feb 2004 13:39:39 -0800
Message-ID: <0bdd01c3f343$cf890e10$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <1075236841.15950.10.camel@rocket.innercite.com>
Subject: Re: [uml-devel] Kernel idles in loop after loading IPv4
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 14 Feb 2004 22:45:05 +0100
To: Phil Nadeau <phil@innercite.com>, user-mode-linux-devel@lists.sourceforge.net

hi !
i have the same problem. 
my uml is 2.6.3-rc2 with jeff`s latest uml patch.
host is 2.6.0-test11 with skas patch
with 2.6.0-test11 + uml patch i didn`t have such problem.
any hints?
 
regards
roland


----- Original Message ----- 
From: "Phil Nadeau" <phil@innercite.com>
To: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Tuesday, January 27, 2004 9:54 PM
Subject: [uml-devel] Kernel idles in loop after loading IPv4


> Hello UML developers,
> 
> I'm trying to use UML to set up a simulator for a high-availability
> cluster. I encounter the following unexpected behavior -
> 
> On any kernel that I compile with IPv4 support, the kernel will stop
> intializing drivers after loading IPv4 support. The last message I see
> from the kernel is:
> NET: Registered protocol family 2
> 
> Compiling with debug allows me to single-step through the kernel. I've
> traced execution from inet_init(), to synchronize_net(), to
> synchronize_kernel(), to a call to wait_for_completion(), to
> switch_to_tt(), after which the kernel spends all its time in the idle
> loop. This happens whether I'm using SKAS or TT mode.
> 
> Host kernel is 2.6.1 with Stephen William's 2.6.1 SKAS patch (thanks
> Stephen). Guest kernel is 2.6.1 with the latest patch from Sourceforge
> (January 15th), without modules, and with nearly everything disabled at
> compile except core functionality and IPv4.
> 
> I've tried to find similar cases in the FAQ's and the list archives, but
> I'm not seeing anything. It seems like the kernel is waiting for an
> event related to IPv4 initialization that it never gets, but I'm not
> familiar enough with the kernel proper to know what that might be. Does
> anyone have any ideas?
> 
> Thanks in advance.
> 
> -- 
> Phil Nadeau
> Software Services Manager
> phil.nadeau@innercite.com
> (916)932-3200, (800)921-5513
> 
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
