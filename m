Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jqkqe-00011b-47 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 01:06:00 -0700
Received: from rv-out-0506.google.com ([209.85.198.225])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jqkqc-0001ow-Oi
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 01:05:59 -0700
Received: by rv-out-0506.google.com with SMTP id g37so2639110rvb.22
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 29 Apr 2008 01:05:58 -0700 (PDT)
Date: Tue, 29 Apr 2008 16:04:56 +0800 (CST)
In-Reply-To: <20080428152940.GA7465@c2.user-mode-linux.org>
Message-ID: <alpine.LFD.1.00.0804291604380.2548@localhost.localdomain>
References: <20080425175608.GA11182@c2.user-mode-linux.org>
	<20080426.163132.194697674.xiyou.wangcong@gmail.com>
	<20080428152940.GA7465@c2.user-mode-linux.org>
MIME-Version: 1.0
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: [uml-devel] [PATCH 6/19] UML - hppfs fixes
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

> On Sat, Apr 26, 2008 at 04:31:32PM +0800, WANG Cong wrote:
>> > +		rem = copy_to_user(buf, &data->contents[off], count);
>> > +		*ppos += count - rem;
>> > +		if (rem > 0)
>> > +			return -EFAULT;
>> 
>> Could you please explain why check 'rem' after using it here?
>
> Actually, this isn't as wrong as it looks. copy_to_user returns what
> hasn't been copied (rem == remaining).  So, I think the mistake is to
> return -EFAULT here.  Returning the short count would be right, unless
> rem == count, in which case we return -EFAULT.

Yes, thanks.

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
