Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JqVY0-0000oP-FM for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Apr 2008 08:45:44 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JqVXp-0001Zz-R2
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Apr 2008 08:45:39 -0700
Date: Mon, 28 Apr 2008 11:45:24 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080428154524.GE7334@c2.user-mode-linux.org>
References: <20080425175606.GA11174@c2.user-mode-linux.org>
	<20080426.180112.184545994.xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080426.180112.184545994.xiyou.wangcong@gmail.com>
Subject: Re: [uml-devel] [PATCH 2/19] UML - Tidy stub management code
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
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Apr 26, 2008 at 06:01:12PM +0800, WANG Cong wrote:
> > +	/*
> > +	 * When the stub stops, we find the following values on the
> > +	 * beginning of the stack:
> > +	 * (long) return_value
> > +	 * (long) offset to failed sycall data (0 if no error)
> > +	 */
> > +	ret = *((unsigned long *) stack);
> 
> 
> I am afraid the value will be truncated on 64bit machine, since
> 'ret' is 'int' while 'stack' points to an 'unsigned long'.
> 
> Is this expected?

That's dubious, but I don't think it breaks anything.  On LE, *(int *)
and *(long *) will give you the same answer, and the value here is an
error code, which fits into 32 bits.

      	    	       Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
