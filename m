Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQQKt-0005Xf-Ph for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 10:28:39 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQQKs-00035g-5m
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 10:28:39 -0700
Date: Tue, 5 Aug 2008 13:28:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080805172813.GA9661@c2.user-mode-linux.org>
References: <489870E7.7070000@exasol.com> <489873E0.9030801@panasas.com>
	<489881BE.9070506@exasol.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <489881BE.9070506@exasol.com>
Subject: Re: [uml-devel] kernel module support broken on x86-64?
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
To: juergen.kadidlo@exasol.com
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Aug 05, 2008 at 06:37:18PM +0200, juergen.kadidlo@exasol.com wrote:
> I'm glad to here that the bug has been fixed. Anyway, it does not work  
> with my configuration:
>
> - CentOS 5.1 as host system and UML root fs
> - Kernel 2.6.25.4 (vanilla, but config taken from the CentOS kernel)
> - GCC 4.1.2
> - GLIBC 2.5

I'm not sure that anything was ever broken.

You are building the modules against a UML tree, with ARCH=um on the
make line?  I.e. you're not trying to load a host module into UML?

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
