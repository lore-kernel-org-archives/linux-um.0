Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQ394-0001DY-LI for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 09:42:54 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQ394-0001tI-2O
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 09:42:54 -0700
Date: Mon, 4 Aug 2008 12:42:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080804164246.GA14805@c2.user-mode-linux.org>
References: <4896F8A1.6020203@meduna.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4896F8A1.6020203@meduna.org>
Subject: Re: [uml-devel] /dev/random problems _not_ solved in 2.6.26
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

On Mon, Aug 04, 2008 at 02:40:01PM +0200, Stanislav Meduna wrote:
> this is just to let you know that the /dev/random problems
> are still not solved in the 2.6.26 version. A small dictionary
> attack on sshd (in my case 260 tries over 12 minutes)
> are able to produce
> 
> auth.log.0:Aug  3 05:30:35 dirk sshd[1825]: fatal: Couldn't obtain random bytes (error 
> 604389476)
> 
> and the sshd dies (followed by apache on the first subsequent
> SSL request and so on).

Off the top of my head, you need the following:
    2.6.26 UML, which you do
    rngtools installed in the UML
    sufficient entropy on the host

This last one shouldn't be taken for granted.  I had problems with
this when debugging the random driver changes - on my laptop with me
typing on it, mousing, disk going, and network traffic going in and
out.  It would be worse on a colocated, no-keyboard, no-mouse, server,
which are notorious for this problem.

> Unfortunately I can't help you in tracing the uml process
> or trying patches - this is a virtual server at my provider
> and I don't have any access there. I could try to get
> the .config file.

You could ask them about how their servers get their randomness.

If nothing else works, I suppose a nasty workaround might be to
replace /dev/random with dev/urandom, but that has security
implications.

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
