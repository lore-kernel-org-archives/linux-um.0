Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jql01-0002Dx-4e for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 01:15:41 -0700
Received: from rv-out-0506.google.com ([209.85.198.226])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jqkzz-0005nw-PB
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 01:15:41 -0700
Received: by rv-out-0506.google.com with SMTP id g37so2640965rvb.22
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 29 Apr 2008 01:15:37 -0700 (PDT)
Date: Tue, 29 Apr 2008 16:14:25 +0800 (CST)
In-Reply-To: <20080428154240.GD7334@c2.user-mode-linux.org>
Message-ID: <alpine.LFD.1.00.0804291613570.2548@localhost.localdomain>
References: <20080425175610.GA11188@c2.user-mode-linux.org>
	<20080426.173538.195417245.xiyou.wangcong@gmail.com>
	<20080428154240.GD7334@c2.user-mode-linux.org>
MIME-Version: 1.0
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: [uml-devel] [PATCH 9/19] UML - Tidy ptrace interface
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

> On Sat, Apr 26, 2008 at 05:35:38PM +0800, WANG Cong wrote:
>> From: Jeff Dike <jdike@addtoit.com>
>> Date: Fri, 25 Apr 2008 13:56:10 -0400
>> > Tidy the ptrace interface code.  Removed a bunch of unused macros.
>> > Started converting register sets from arrays of longs to structures.
>> 
>> Could you please explain a bit why do this? I think long arrary is OK.
>
> It's wrong on x86_64.  There, FRAME_SIZE is 168 -
>     #define FRAME_SIZE 
> and SS is the last register defined -
>    #define SS 160
> but there are a number of registers beyond that in the user_regs_struct:
> 	unsigned long	ss;
> 	unsigned long	fs_base;
> 	unsigned long	gs_base;
> 	unsigned long	ds;
> 	unsigned long	es;
> 	unsigned long	fs;
> 	unsigned long	gs;
>
> The effect of GETREGS into a long[FRAME_SIZE] will be stack corruption.
>

Thanks for teaching this. ;-)

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
