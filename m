Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KdTH5-0002EY-GR for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Sep 2008 10:14:39 -0700
Received: from over.ny.us.ibm.com ([32.97.182.150])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KdTH3-0003c3-UV
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Sep 2008 10:14:39 -0700
Received: from e4.ny.us.ibm.com ([192.168.1.104])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m8AGN1lM018102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Sep 2008 12:23:01 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8AGJk73010744
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Sep 2008 12:19:46 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8AGJjQV1581106 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Sep 2008 12:19:45 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8AGJiLr030165 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Sep 2008 10:19:45 -0600
From: Dave Hansen <dave@linux.vnet.ibm.com>
In-Reply-To: <48C51439.7000706@linux.vnet.ibm.com>
References: <48C51439.7000706@linux.vnet.ibm.com>
Date: Wed, 10 Sep 2008 09:19:34 -0700
Message-Id: <1221063574.6781.8.camel@nimitz>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/1] system call notification with self_ptrace
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
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: sameske@linux.vnet.ibm.com, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, gregkh@suse.de, Ingo Molnar <mingo@elte.hu>, Heiko Carstens <heicars2@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Daniel Lezcano <dlezcano@fr.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>, Roland McGrath <roland@redhat.com>

On Mon, 2008-09-08 at 14:02 +0200, Pierre Morel wrote:
> 
> +       if (is_self_ptracing(regs->gprs[2])) {
> +               if (!entryexit) {
> +                       struct siginfo info;
> +
> +                       memset(&info, 0, sizeof(struct siginfo));
> +                       info.si_signo = SIGSYS;
> +                       info.si_code = SYS_SYSCALL;
> +                       info.si_errno = regs->gprs[2];
> +                       info.si_addr = (void *)regs->orig_gpr2;
> +                       send_sig_info(SIGSYS, &info, current);
> +                       regs->gprs[2] = -1;
> +               }
> +               return;
> +       }

I see you didn't like my suggestions for consolidating some of these
repetitive code bits across all the architectures.  Did you give that a
a shot?  Would you like me to produce a patch on top of what you have
here before this gets merged into mm?

-- Dave


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
