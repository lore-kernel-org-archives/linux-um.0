Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZDEJ-0005PW-BL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 11:00:03 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CZDEI-0007cy-Dp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 11:00:03 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Merging some of your patches
References: <200411301945.07814.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411301945.07814.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411302003.08104.blaisorblade_spam@yahoo.it>
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
Date: Tue, 30 Nov 2004 20:03:07 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>

On Tuesday 30 November 2004 19:45, Blaisorblade wrote:
> Since you've started sending UML patches, I've remembered to ask you this.
>
> In particular, from a general feeling, you should merge:
>
> uml-fix-umldir-order
>
> uml-fix-export-symbol if not already applied.
>
> uml-raise-tty-limit (maybe something similar could be good for ubd, too? We
> are using half of the 256 minors available).
Forgot some other ones:

uml-core-on-panic - I remember it being a bit controversial.

At least it has been turned to using the notifier_chain... which was problem 
#1. #2 was that you need to skip all the rest of exit cleanup, which Jeff 
didn't like... but as long as it is not a change to the default behaviour, I 
think he might accept it.

uml-general-protection-fault - from the comment, it seems that if that were a 
page fault, it would be fixable, while we always prefer to guess it's a GFP 
and so to die horribly. If this is true, it cannot be merged.

But what about adding a PTRACE_EX_FAULTINFO to SKAS3 and probe for it at 
startup? Jeff Dike wanted to wait for SKAS4 to fix it, but as you see SKAS3 
is still under very active development. Also, we get all the possible 
compatibility we could, this way.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
