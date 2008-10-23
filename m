Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jdike@addtoit.com>) id 1Kt5jv-0007TA-Em
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Oct 2008 19:20:59 +0000
Received: from saraswathi.solana.com ([198.99.130.12])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Kt5ju-0006fu-8a
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Oct 2008 19:20:59 +0000
Date: Thu, 23 Oct 2008 15:20:50 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20081023192050.GC13198@c2.user-mode-linux.org>
References: <200810221335.00063.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200810221335.00063.rusty@rustcorp.com.au>
Subject: Re: [uml-devel] Strange code in smp_prepare_cpus?
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Oct 22, 2008 at 01:34:59PM +1100, Rusty Russell wrote:
> ...
> 	cpu_clear(me, cpu_online_map);
> 	cpu_set(me, cpu_online_map);
> 
> Something subtle here?

I'd like to be able to claim so, but no.  Looks like a botched merge to me.

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
