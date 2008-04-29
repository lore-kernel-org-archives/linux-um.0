Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JqsUU-00063G-Qv for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 09:15:39 -0700
Received: from an-out-0708.google.com ([209.85.132.243])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JqsUO-0006uW-PA
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 09:15:38 -0700
Received: by an-out-0708.google.com with SMTP id c10so1571ana.71
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 29 Apr 2008 09:15:27 -0700 (PDT)
Message-ID: <804dabb00804290915gcd3ca3oa7043a32b530ac68@mail.gmail.com>
Date: Wed, 30 Apr 2008 00:15:26 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
In-Reply-To: <20080429153746.GB9143@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <804dabb00804280853ld50a9f3o333f0f8d46f2a2ea@mail.gmail.com>
	<20080428185505.GA11160@c2.user-mode-linux.org>
	<804dabb00804290502m771fe2cfm21f7be4534d56b65@mail.gmail.com>
	<20080429153746.GB9143@c2.user-mode-linux.org>
Subject: Re: [uml-devel] arch/um/Makefile:100: *** missing separator. Stop.
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
Cc: user-mode-linux-devel@lists.sourceforge.net

On 4/29/08, Jeff Dike <jdike@addtoit.com> wrote:
> On Tue, Apr 29, 2008 at 08:02:06PM +0800, Peter Teoh wrote:
>  > Erh....I don't understand, is there something specifically called
>  > "UML" with a version to it?
>
>
> What I meant was the kernel version.
>
>
>  > /mnt/hd0/download/linux-2.6-latest>cat include/config/kernel.release
>  > 2.6.25
>  >
>  > Is this the correct procedure?   I suspect something is wrong, as i
>  > did a few times in all other different git tree all similar results.
>
>
> Looks right to me.
>
>  I'm suspecting that Makefile is mangled somehow.  Does git-diff show
>  it as being changed?  The md5sum I have here is
>
>    md5sum arch/um/Makefile
>    9088cdab1c0b725568e8f269636dc6df  arch/um/Makefile
>
>

I think I saw from the webpage that 2.6.18 and higher up are not
supported, right?

http://www.user-mode-linux.org/~blaisorblade/listpatches.html

(first few lines)
-- 
Regards,
Peter Teoh

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
