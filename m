Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ke7jN-0005bo-Sm for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Sep 2008 05:26:34 -0700
Received: from mtagate2.de.ibm.com ([195.212.17.162])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ke7jK-00015r-HB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Sep 2008 05:26:33 -0700
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.1/8.13.1) with ESMTP id m8CCQ14f020559
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Sep 2008 12:26:01 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m8CCQ0XI3514536
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Sep 2008 14:26:00 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m8CCPuxk031649 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Sep 2008 14:25:57 +0200
Message-ID: <48CA5EEB.4090809@linux.vnet.ibm.com>
Date: Fri, 12 Sep 2008 14:22:03 +0200
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <48C51439.7000706@linux.vnet.ibm.com>
	<20080909124302.GA139@tv-sign.ru>
	<48C7E3A9.3060602@linux.vnet.ibm.com>
	<20080910162008.GA401@tv-sign.ru> <1221063805.6781.11.camel@nimitz>
In-Reply-To: <1221063805.6781.11.camel@nimitz>
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

be optimistic, why not?
I bet we will ;)

Pierre

Dave Hansen wrote:
> On Wed, 2008-09-10 at 20:20 +0400, Oleg Nesterov wrote:
>   
>> But... well, I think we need Roland's opinion. I must admit, I am a bit
>> sceptical about this patch ;) I mean, I don't really understand why it
>> is useful
>>     
>
> Yeah, I don't think they're completely coming clean on it, yet.  
>
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
