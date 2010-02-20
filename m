Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jdike@addtoit.com>) id 1Nixbw-0002mz-Tv
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Feb 2010 22:15:40 +0000
Received: from saraswathi.solana.com ([198.99.130.12])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nixbv-00038I-DP
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Feb 2010 22:15:40 +0000
Date: Sat, 20 Feb 2010 14:10:51 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20100220191051.GA19560@localhost.localdomain>
References: <20100220143359.GD3000@hack>
	<20100220150936.GP30031@ZenIV.linux.org.uk>
	<20100220151605.GQ30031@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100220151605.GQ30031@ZenIV.linux.org.uk>
Subject: Re: [uml-devel] [Patch] um: tell git to ignore generated files
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
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: xiyou.wangcong@gmail.com, Andrew Morton <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net

On Sat, Feb 20, 2010 at 03:16:05PM +0000, Al Viro wrote:
> On Sat, Feb 20, 2010 at 03:09:36PM +0000, Al Viro wrote:
> > On Sat, Feb 20, 2010 at 10:33:59PM +0800, Am??rico Wang wrote:
> > > 
> > > git should ignore these files, since they are generated.
> > 
> > > +include/shared/kern_constants.h
> > > +include/shared/user_constants.h
> > 
> > I have patches taking that to include/generated, actually
> 
> BTW, what's the status of skas4?  I have a series of patches leading towards
> resurrection of uml/powerpc (skas0), but I'd rather avoid breaking skas4
> in process...  Where does the recent version of that thing live?

TBH, I haven't done any real work in UML in the last year or so.  The
world has pretty much passed UML by, and it's beyond my capabilities
and time to catch up and keep up.

So, to answer the question, I'd say that skas4 is in the same boat.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

