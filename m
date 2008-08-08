Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KRH0I-0001Ix-HI for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 18:42:54 -0700
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KRH0H-0004lE-4B
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 18:42:54 -0700
From: Rob Landley <rob@landley.net>
Date: Thu, 7 Aug 2008 20:42:47 -0500
References: <1214488251-20927-1-git-send-email-bhalevy@panasas.com>
	<48673A9B.8050907@panasas.com>
	<20080630162201.GC6643@c2.user-mode-linux.org>
In-Reply-To: <20080630162201.GC6643@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200808072042.48182.rob@landley.net>
Subject: Re: [uml-devel] [PATCH] fix extern inline errors with gcc 4.3.0
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Benny Halevy <bhalevy@panasas.com>, linux-kernel@vger.kernel.org

> On Monday 30 June 2008 11:22:01 Jeff Dike wrote:
> > 	Uli reported a crash on x86_64 with gcc 4.1.2 with unit-at-a-time
>
> ...
>
> > If that crash does come back, I'd say we should just debug it.  It's
> > likely UML implicitly relying on some gcc behavior anyway.
>
> Well, I'm seeing the crash in stock 2.6.26.  For the moment I'm reverting
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdi
>ff;h=4f81c5350b44bcc501ab6f8a089b16d064b4d2f6
>
> And then it runs fine.  (With gcc 4.1.2, on x86-64.)

Nevermind, fixed in 2.6.26.2 already.  Sorry for the noise...

Rob
-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
