Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jdike@addtoit.com>) id 1Klz0O-0005k7-Fk
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Oct 2008 04:44:36 +0000
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Klyzm-0002OH-U9
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Oct 2008 04:44:36 +0000
Date: Sat, 4 Oct 2008 00:28:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20081004042815.GA18807@c2.user-mode-linux.org>
References: <48CA7158.5080500@ecp.fr> <48CE23E5.4070308@ecp.fr>
	<48E4CDE3.9090502@ecp.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48E4CDE3.9090502@ecp.fr>
Subject: Re: [uml-devel] parallel I/O
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Nicolas Boullis <nicolas.boullis@ecp.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Oct 02, 2008 at 03:34:27PM +0200, Nicolas Boullis wrote:
> I wrote:
> > 
> > For what it's worth, here is my quick-n-dirty proof-of-concept patch
> > that enables parallel I/O. Note that it is based on 2.6.24.
> > 
> > If people are interested, I can try to make a clean patch out of it.
> 
> For what it's worth, I fixed a few bugs in my patch. Here is the new
> patch. It's still "quick'n'dirty", but it works better, and works for me.

Sorry about the lack of responsiveness.

I've had such a patch for quite a while.  I never stuck it in mainline
because I couldn't find any common use cases where it made a noticable
difference.

Does your patch help noticably with anything reasonable common?

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
