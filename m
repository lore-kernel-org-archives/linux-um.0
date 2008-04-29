Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JqoXo-00030K-17 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 05:02:51 -0700
Received: from wx-out-0506.google.com ([66.249.82.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JqoXh-0006jj-6t
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 05:02:42 -0700
Received: by wx-out-0506.google.com with SMTP id h31so4415816wxd.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 29 Apr 2008 05:02:40 -0700 (PDT)
Message-ID: <804dabb00804290502m771fe2cfm21f7be4534d56b65@mail.gmail.com>
Date: Tue, 29 Apr 2008 20:02:06 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
In-Reply-To: <20080428185505.GA11160@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <804dabb00804280853ld50a9f3o333f0f8d46f2a2ea@mail.gmail.com>
	<20080428185505.GA11160@c2.user-mode-linux.org>
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

On Tue, Apr 29, 2008 at 2:55 AM, Jeff Dike <jdike@addtoit.com> wrote:
> On Mon, Apr 28, 2008 at 11:53:48PM +0800, Peter Teoh wrote:
>  > What is the following errors:
>  >
>  > make defconfig ARCH=um
>  > /sda4/download/linux_linus/linux-2.6/arch/um/Makefile:100: *** missing
>  > separator.  Stop.
>
>  What version of UML?
>

Erh....I don't understand, is there something specifically called
"UML" with a version to it?

What I did was this:

a.   Followed the steps here:
http://user-mode-linux.sourceforge.net/source.html, except that the
linux kernel is from linus's git tree (from the .git/config file):

[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

b.   and then I just did a make defconfig ARCH=um.

c.   the version of the kernel is this:

/mnt/hd0/download/linux-2.6-latest>cat include/config/kernel.release
2.6.25

Is this the correct procedure?   I suspect something is wrong, as i
did a few times in all other different git tree all similar results.

>              Jeff
>
>  --
>  Work email - jdike at linux dot intel dot com
>



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
