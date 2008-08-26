Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KY2cV-0002m4-IX for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 10:46:19 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KY2cT-0005I7-NK
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 10:46:19 -0700
Date: Tue, 26 Aug 2008 13:46:00 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080826174600.GA24342@c2.user-mode-linux.org>
References: <4898AC10.3010602@meduna.org>
	<7B4268E5ACB878429B58D4BE5B780E8301A303A5@NWS-EXCH2.nws.oregonstate.edu>
	<48995D1A.6030203@meduna.org> <489AC525.3060305@meduna.org>
	<489AE6DD.2000200@meduna.org> <489C3D9B.7070605@meduna.org>
	<20080825215124.GB12626@c2.user-mode-linux.org>
	<48B3AED8.5040904@meduna.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48B3AED8.5040904@meduna.org>
Subject: Re: [uml-devel] FP registers corruption
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
To: Stanislav Meduna <stano@meduna.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Aug 26, 2008 at 09:20:56AM +0200, Stanislav Meduna wrote:
> I tried to isolate the exact version, but I was not able
> to compile/run all the UML versions in my test environment
> (current Ubuntu) - obviously the UML is quite sensitive
> to the host kernel as well.

It's not.  Any 2.6 UML should run on a any 2.6 host.  If you are
having problems that look like version skew problems, say what they
are.

> So the only thing I can say is that I cannot reproduce
> it with neither 2.6.24.7 nor 2.6.26.2 guest in my environment.
> The only instance I am seeing it is the 2.6.26 guest on
> 2.6.23.17 host at my provider :(

In an earlier email, you provide a nice test case.  However, I'm
running that here, and getting page after page of successful key
generation.

Is there anything else that might be relevant to reproducing this?

   	 	       	   Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
