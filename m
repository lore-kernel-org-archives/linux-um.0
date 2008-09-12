Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ke7re-0006XS-Jo for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Sep 2008 05:35:07 -0700
Received: from mtagate6.de.ibm.com ([195.212.29.155])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ke7rc-000335-Ri
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Sep 2008 05:35:06 -0700
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id m8CCYsVr175718
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Sep 2008 12:34:54 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m8CCYnPN3747890
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Sep 2008 14:34:54 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m8CCYjKW026596 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Sep 2008 14:34:46 +0200
Message-ID: <48CA60FC.8050501@linux.vnet.ibm.com>
Date: Fri, 12 Sep 2008 14:30:52 +0200
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <48C51439.7000706@linux.vnet.ibm.com>
	<1221063574.6781.8.camel@nimitz>
In-Reply-To: <1221063574.6781.8.camel@nimitz>
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
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: sameske@linux.vnet.ibm.com, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, gregkh@suse.de, Ingo Molnar <mingo@elte.hu>, Heiko Carstens <heicars2@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Daniel Lezcano <dlezcano@fr.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>, Roland McGrath <roland@redhat.com>

Hi Dave,

Dave Hansen wrote:
> On Mon, 2008-09-08 at 14:02 +0200, Pierre Morel wrote:
>   
>> +       if (is_self_ptracing(regs->gprs[2])) {
>> +               if (!entryexit) {
>> +                       struct siginfo info;
>> +
>> +                       memset(&info, 0, sizeof(struct siginfo));
>> +                       info.si_signo = SIGSYS;
>> +                       info.si_code = SYS_SYSCALL;
>> +                       info.si_errno = regs->gprs[2];
>> +                       info.si_addr = (void *)regs->orig_gpr2;
>> +                       send_sig_info(SIGSYS, &info, current);
>> +                       regs->gprs[2] = -1;
>> +               }
>> +               return;
>> +       }
>>     
>
> I see you didn't like my suggestions for consolidating some of these
> repetitive code bits across all the architectures.  Did you give that a
>   
I have read your suggestion, but the actual ptrace() implementation uses 
explicit reference to the different architecture dependent registers and 
I think that this portion of code is more readable if the patch keeps 
the actual conventions used by Roland.
> a shot?  Would you like me to produce a patch on top of what you have
> here before this gets merged into mm?
>   
No Dave, thank you.

regards,

Pierre

> -- Dave
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>   


-- 
=============
Pierre Morel
RTOS and Embedded Linux


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
