Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JqkjN-0000At-LH for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 00:58:29 -0700
Received: from hu-out-0506.google.com ([72.14.214.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JqkjN-0007LI-73
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 00:58:29 -0700
Received: by hu-out-0506.google.com with SMTP id 28so1694963hub.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 29 Apr 2008 00:58:27 -0700 (PDT)
Date: Tue, 29 Apr 2008 15:57:24 +0800 (CST)
In-Reply-To: <20080428154524.GE7334@c2.user-mode-linux.org>
Message-ID: <alpine.LFD.1.00.0804291556550.2548@localhost.localdomain>
References: <20080425175606.GA11174@c2.user-mode-linux.org>
	<20080426.180112.184545994.xiyou.wangcong@gmail.com>
	<20080428154524.GE7334@c2.user-mode-linux.org>
MIME-Version: 1.0
From: WANG Cong <xiyou.wangcong@gmail.com>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, WANG Cong <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, 28 Apr 2008, Jeff Dike wrote:

> On Sat, Apr 26, 2008 at 06:01:12PM +0800, WANG Cong wrote:
>> > +	/*
>> > +	 * When the stub stops, we find the following values on the
>> > +	 * beginning of the stack:
>> > +	 * (long) return_value
>> > +	 * (long) offset to failed sycall data (0 if no error)
>> > +	 */
>> > +	ret = *((unsigned long *) stack);
>> 
>> 
>> I am afraid the value will be truncated on 64bit machine, since
>> 'ret' is 'int' while 'stack' points to an 'unsigned long'.
>> 
>> Is this expected?
>
> That's dubious, but I don't think it breaks anything.  On LE, *(int *)
> and *(long *) will give you the same answer, and the value here is an
> error code, which fits into 32 bits.

So it's safe here.

OK. Thanks!

--
Hi, I'm a .signature virus, please copy/paste me to help me spread
all over the world.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
