Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <balbir@linux.vnet.ibm.com>) id 1L8pyZ-0003PP-UG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Dec 2008 05:45:11 +0000
Received: from e28smtp07.in.ibm.com ([59.145.155.7])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L8pyV-0004xL-Ke
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Dec 2008 05:45:11 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp07.in.ibm.com (8.13.1/8.13.1) with ESMTP id mB65j3RH022544
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 6 Dec 2008 11:15:03 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB65iBL52949354 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 6 Dec 2008 11:14:11 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.13.1/8.13.3) with ESMTP id mB65j2rC018750
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 6 Dec 2008 16:45:02 +1100
Date: Sat, 6 Dec 2008 11:14:59 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
Message-ID: <20081206054459.GB7582@balbir.in.ibm.com>
References: <20081129100830.GA24128@balbir.in.ibm.com>
	<84144f020811290221g947f836n4fe3435676425ee@mail.gmail.com>
	<20081129122039.GA31635@balbir.in.ibm.com>
	<20081202121707.e1623f89.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081202121707.e1623f89.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jdike@addtoit.com, penberg@cs.helsinki.fi, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org

* Andrew Morton <akpm@linux-foundation.org> [2008-12-02 12:17:07]:

> On Sat, 29 Nov 2008 17:50:39 +0530
> Balbir Singh <balbir@linux.vnet.ibm.com> wrote:
> 
> > * Pekka Enberg <penberg@cs.helsinki.fi> [2008-11-29 12:21:46]:
> > 
> > > Hi Balbir,
> > > 
> > > On Sat, Nov 29, 2008 at 12:08 PM, Balbir Singh
> > > <balbir@linux.vnet.ibm.com> wrote:
> > > > mconsole_init() passed 256 bytes as length in os_create_unix_socket, while
> > > > the sizeof UNIX_PATH_MAX is 108. This patch fixes that problem and avoids
> > > > a big overrun bug reported on UML bootup.
> > > 
> > > Maybe mention that ->sun_path in struct sockaddr_un is UNIX_PATH_MAX
> > > long which causes the problem?
> > >
> > 
> > Yes, the changelog can definitely add that to the changelog, I'll
> > resend the patch if Jeff asks for it.
> 
> Jeff's been quiet lately - I'll merge this one.
> 

Thanks!

> I also tagged it for -stable, subject to Jeff's OK.  I'm wondering why
> this wasn't observed in earlier kernels?
> 

I observed it with the newer toolchain that uses __USE_FORTIFY_LEVEL
and __FORTIFY_SOURCE


-- 
	Balbir

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
