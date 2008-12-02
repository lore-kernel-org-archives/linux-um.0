Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1L7bgc-00037a-6O
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Dec 2008 20:17:34 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L7bgZ-0004k2-Ky
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Dec 2008 20:17:34 +0000
Date: Tue, 2 Dec 2008 12:17:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20081202121707.e1623f89.akpm@linux-foundation.org>
In-Reply-To: <20081129122039.GA31635@balbir.in.ibm.com>
References: <20081129100830.GA24128@balbir.in.ibm.com>
	<84144f020811290221g947f836n4fe3435676425ee@mail.gmail.com>
	<20081129122039.GA31635@balbir.in.ibm.com>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH][UML] Boot broken due to buffer overrun
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
To: balbir@linux.vnet.ibm.com
Cc: jdike@addtoit.com, penberg@cs.helsinki.fi, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org

On Sat, 29 Nov 2008 17:50:39 +0530
Balbir Singh <balbir@linux.vnet.ibm.com> wrote:

> * Pekka Enberg <penberg@cs.helsinki.fi> [2008-11-29 12:21:46]:
> 
> > Hi Balbir,
> > 
> > On Sat, Nov 29, 2008 at 12:08 PM, Balbir Singh
> > <balbir@linux.vnet.ibm.com> wrote:
> > > mconsole_init() passed 256 bytes as length in os_create_unix_socket, while
> > > the sizeof UNIX_PATH_MAX is 108. This patch fixes that problem and avoids
> > > a big overrun bug reported on UML bootup.
> > 
> > Maybe mention that ->sun_path in struct sockaddr_un is UNIX_PATH_MAX
> > long which causes the problem?
> >
> 
> Yes, the changelog can definitely add that to the changelog, I'll
> resend the patch if Jeff asks for it.

Jeff's been quiet lately - I'll merge this one.

I also tagged it for -stable, subject to Jeff's OK.  I'm wondering why
this wasn't observed in earlier kernels?


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
