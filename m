Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <42D3778A.20703@acousta.at>
From: Bernhard Schauer <schauer@acousta.at>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: Problems about fork-not-clone
References: <1119527920.4679.15.camel@FC3-bernhard-1.acousta.local>
	<20050707115908.GA6043@ccure.user-mode-linux.org>
	<1121068129.4682.15.camel@FC3-bernhard-1.acousta.local>
	<200507112321.20457.blaisorblade@yahoo.it>
In-Reply-To: <200507112321.20457.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Tue, 12 Jul 2005 09:55:54 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, user-mode-linux-user@lists.sourceforge.net

Blaisorblade wrote:
> There's a bit of misunderstanding: SKAS0 is a patch for UML only, not an host 
> patch. It's numbered "0" because it has "0" dependencies, or because it does 
> not depend on host SKAS patch (nor SKAS1, nor SKAS2, nor SKAS3).

Sorry for that, I should have read about it - especially before writing.

_IMO:_

In any case it should be in the kernel mainline, or in other words:
A mainline kernel should run without any patches required whether SKAS0 
nor reverted fork-not-clone.
If this specific failure is caught by reverted fork-not-clone patch this 
is THE correction and should also be in mainline kernel.
If SKAS0 is better than TT mode, TT mode could be replaced with 2.6.14.



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
