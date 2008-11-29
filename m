Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <balbir@linux.vnet.ibm.com>) id 1L6RHi-0001HY-Te
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Nov 2008 14:59:02 +0000
Received: from e23smtp01.au.ibm.com ([202.81.18.162])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L6RHe-0003um-SM
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Nov 2008 14:59:02 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id mATEwsjm027822
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 30 Nov 2008 01:58:54 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mATExIrr4104316 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 30 Nov 2008 01:59:18 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mATEwsdx008449 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 30 Nov 2008 01:58:55 +1100
Date: Sat, 29 Nov 2008 17:50:39 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
Message-ID: <20081129122039.GA31635@balbir.in.ibm.com>
References: <20081129100830.GA24128@balbir.in.ibm.com>
	<84144f020811290221g947f836n4fe3435676425ee@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <84144f020811290221g947f836n4fe3435676425ee@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH][UML] Boot broken due to buffer overrun
Reply-To: balbir@linux.vnet.ibm.com
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
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

* Pekka Enberg <penberg@cs.helsinki.fi> [2008-11-29 12:21:46]:

> Hi Balbir,
> 
> On Sat, Nov 29, 2008 at 12:08 PM, Balbir Singh
> <balbir@linux.vnet.ibm.com> wrote:
> > mconsole_init() passed 256 bytes as length in os_create_unix_socket, while
> > the sizeof UNIX_PATH_MAX is 108. This patch fixes that problem and avoids
> > a big overrun bug reported on UML bootup.
> 
> Maybe mention that ->sun_path in struct sockaddr_un is UNIX_PATH_MAX
> long which causes the problem?
>

Yes, the changelog can definitely add that to the changelog, I'll
resend the patch if Jeff asks for it.

 
> > Reported-by: Vikas K Managutte <vikki.km@gmail.com>
> > Reported-by: Sarvesh Kumar Lal Das <skldas@gmail.com>
> > Signed-off-by: Balbir Singh <balbir@linux.vnet.ibm.com>
> 
> Reviewed-by: Pekka Enberg <penberg@cs.helsinki.fi>

Thanks!

-- 
	Balbir

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
