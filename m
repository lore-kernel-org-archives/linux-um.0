Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQ6k9-0007m1-GD for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 13:33:25 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQ6k7-0004KL-Sf
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 13:33:25 -0700
Date: Mon, 4 Aug 2008 16:33:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080804203319.GA14732@c2.user-mode-linux.org>
References: <48970AEC.6020503@meduna.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48970AEC.6020503@meduna.org>
Subject: Re: [uml-devel] sysconf(_SC_NPROCESSORS_CONF) returning zero
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

On Mon, Aug 04, 2008 at 03:58:04PM +0200, Stanislav Meduna wrote:
> Hi,
> 
> the following program
> 
> ===
> #include <unistd.h>
> #include <stdio.h>
> 
> main()
> {
>    printf("Number of processors: %d\n", sysconf(_SC_NPROCESSORS_CONF));
> }
> ===
> 
> produces
> 
>    Number of processors: 0
> 
> on my system.

Works here...

[root@uml-test ~]# cc -o ncpus ncpus.c 
[root@uml-test ~]# ./ncpus 
Number of processors: 1

sysconf seems to be looking at /proc/stat, which looks like this here:

	cpu  80 0 157 12771 984 0 0 0 0
	cpu0 80 0 157 12771 984 0 0 0 0
	intr 15259 12519 0 75 0 2590 0 0 0 0 0 0 74 0 0 1
	ctxt 8081
	btime 1217881784
	processes 1144
	procs_running 3
	procs_blocked 0

I'd guess it's looking at the cpu0 (and cpu<n>) lines.

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
