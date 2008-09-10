Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KdSX6-0005d0-Dr for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Sep 2008 09:27:08 -0700
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KdSW9-0001P6-If
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Sep 2008 09:26:11 -0700
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8AGNTrU005443
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Sep 2008 12:23:29 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8AGNTdF157556 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Sep 2008 12:23:29 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8AGNSIu023432 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 10 Sep 2008 12:23:29 -0400
From: Dave Hansen <dave@linux.vnet.ibm.com>
In-Reply-To: <20080910162008.GA401@tv-sign.ru>
References: <48C51439.7000706@linux.vnet.ibm.com>
	<20080909124302.GA139@tv-sign.ru> <48C7E3A9.3060602@linux.vnet.ibm.com>
	<20080910162008.GA401@tv-sign.ru>
Date: Wed, 10 Sep 2008 09:23:25 -0700
Message-Id: <1221063805.6781.11.camel@nimitz>
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
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: sameske@linux.vnet.ibm.com, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Pierre Morel <pmorel@linux.vnet.ibm.com>, gregkh@suse.de, Heiko Carstens <heicars2@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Daniel Lezcano <dlezcano@fr.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>

On Wed, 2008-09-10 at 20:20 +0400, Oleg Nesterov wrote:
> But... well, I think we need Roland's opinion. I must admit, I am a bit
> sceptical about this patch ;) I mean, I don't really understand why it
> is useful

Yeah, I don't think they're completely coming clean on it, yet.  

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
