Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Bernhard Schauer <linux-kernel-list@acousta.at>
Reply-To: schauer@acousta.at
In-Reply-To: <20050707115908.GA6043@ccure.user-mode-linux.org>
References: <1119527920.4679.15.camel@FC3-bernhard-1.acousta.local>
	 <1119614544.4643.9.camel@FC3-bernhard-1.acousta.local>
	 <20050624134118.GA4117@ccure.user-mode-linux.org>
	 <200507041853.13469.blaisorblade@yahoo.it>
	 <20050707115908.GA6043@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1121068129.4682.15.camel@FC3-bernhard-1.acousta.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Problems about fork-not-clone (was: Re: [uml-user]
	UML exits after "tracing thread pid")
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
Date: Mon, 11 Jul 2005 09:48:49 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Thu, 2005-07-07 at 07:59 -0400, Jeff Dike wrote:
> So, I would say that skas0 is more a fix for this problem than
> reverting the fork-not-clone patch is.

No it isn't. Its an other method not a fix for anything. As long as 
skas0 is not in kernel mainline and enabled in main distributions, it
has no relevance for corporate level (at least in my case).

UML gives us the chance to build a compile and debug environment without
a relevance on which distribution it runs. The image used to boot UML is
a copy for each developer and each of them could compile applications
having the same environment as on the target system.



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
