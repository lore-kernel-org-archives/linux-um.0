Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpBPJ-0005Nu-MF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 12:17:25 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CpBPF-0007z3-HX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 12:17:25 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Breakage of compilation in .11-rc1 -
	"code-tidying" is broken
References: <200501132008.41725.blaisorblade@yahoo.it>
	<200501132205.j0DM5Oha005643@ccure.user-mode-linux.org>
In-Reply-To: <200501132205.j0DM5Oha005643@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501132119.40389.blaisorblade@yahoo.it>
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
Date: Thu, 13 Jan 2005 21:19:40 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Thursday 13 January 2005 23:05, Jeff Dike wrote:
> blaisorblade@yahoo.it said:
> > In fact, including both linux/ptrace.h and sys/ptrace.h is not
> > redundant - it  must also be done in the proper order, so I'm writing
> > a patch with the  appropriate content.

> Wait till I update my patch list before fixing this.  Bodo send me a patch,
> which I am polishing now.

>     Jeff
I'm testing the compilation now - also, I'm commenting out part of the new 
syscalls - the vperfctr ones give problems, I guess they are mm-only for now.
Instead the key managing ones already exist.

So, I've done a patch for both things and I'm posting it - preserve the 
comment I added about those headers in your polished version which you'll 
merge.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
