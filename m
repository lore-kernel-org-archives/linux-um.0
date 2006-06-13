Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqDWT-000378-3S for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jun 2006 11:21:53 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FqDWS-0005pY-AK
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jun 2006 11:21:53 -0700
Date: Tue, 13 Jun 2006 14:21:29 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060613182129.GA4619@ccure.user-mode-linux.org>
References: <20060514182541.GA4980@gmail.com> <20060613145718.GB9729@gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060613145718.GB9729@gmail.com>
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on
	x86-64
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Alberto Bertogli <albertito@gmail.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, Jun 13, 2006 at 11:57:18AM -0300, Alberto Bertogli wrote:
> I just wanted to report that this went away when trying 2.6.17-rc6 as a
> host. It also works fine as a guest (after I patch it with
> http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17-rc4/patches/jmpbuf
> so that it builds).
> 
> Besides, the random segfault problems I had with previous guests
> versions also seem to be fixed.

These two problems are related, and were both on the host.  Bodo
Stroesser reported a while ago that ptrace, by returning via sysret
rather than iret, could cause register corruption when tracing
sigreturn.

The UML crash seems to have been caused by the fix to that problem.

				Jeff


_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
