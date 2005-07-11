Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ds64U-0007xj-BE	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 14:44:14 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.44)
	id 1Ds64S-0000GT-St	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 14:44:14 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Please test 2.6.13-rc2 in TT mode! Big problem with
	syscall parameters clobbering
References: <200507072031.43862.blaisorblade@yahoo.it>
In-Reply-To: <200507072031.43862.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200507112351.25230.blaisorblade@yahoo.it>
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
Date: Mon, 11 Jul 2005 23:51:24 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

On Thursday 07 July 2005 20:31, Blaisorblade wrote:
> For this kernel (and for -rc1), I've been getting almost no reports (except
> a problem with GCC 2.95 I now solved) in TT mode, so I'd like some more
> testing, especially for users which have the latest SKAS patch installed.
> At least positive / negative reports.

[...]
> But on my system the comparison fails, because the compiler keeps "to"
> inside EBX and after the syscall return the content of EBX is altered!

> So, this seems a kernel bug, but it does not happen in the previous form of
> the code (which didn't use a direct syscall but rather the glibc version)!

> And my system works pretty well, I think;
>
> * I get only some crashes from some KDE components, but I consider them
> normal,
> * and a lot of problems with GDB and debugging (still looking for the
> cause).

Ok, I found the problem, it was due indeed to a SKAS3 bug. I could verify it 
in patch releases as old as 2.6.9-v7 by testing, and I didn't went testing 
further back. In all kernels I tested, CONFIG_REGPARM was enabled, and this 
is related with the problem.

The solution is to upgrade to -V8.2.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
