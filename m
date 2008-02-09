Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JNdXh-0005LC-8i for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Feb 2008 16:26:05 -0800
Received: from smtp6.pp.htv.fi ([213.243.153.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JNdXf-00022m-Q2
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Feb 2008 16:26:05 -0800
Date: Sat, 9 Feb 2008 02:25:32 +0200
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20080209002532.GG6505@cs181133002.pp.htv.fi>
References: <20080208223228.GD6505@cs181133002.pp.htv.fi>
	<Pine.LNX.4.64.0802090102590.30873@twin.jikos.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0802090102590.30873@twin.jikos.cz>
Subject: Re: [uml-devel] uml compile error
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
To: Jiri Kosina <jkosina@suse.cz>
Cc: Adrian Bunk <bunk@kernel.org>, Miklos Szeredi <mszeredi@suse.cz>, user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Sat, Feb 09, 2008 at 01:05:15AM +0100, Jiri Kosina wrote:
> On Sat, 9 Feb 2008, Adrian Bunk wrote:
> 
> > Commit dd2cc4dff3b08ab54c4c177a080046bcc84ac41d broke uml:
> > <-- snip  -->
> > ...
> >   CC      fs/hostfs/hostfs_kern.o
> > /home/bunk/linux/kernel-2.6/git/linux-2.6/fs/hostfs/hostfs_kern.c: In function 'hostfs_show_options':
> > /home/bunk/linux/kernel-2.6/git/linux-2.6/fs/hostfs/hostfs_kern.c:328: error: dereferencing pointer to incomplete type
> > make[3]: *** [fs/hostfs/hostfs_kern.o] Error 1
> 
> I guess we need this one?
> 
> 
> 
> From: Jiri Kosina <jkosina@suse.cz>
> 
> UML: fix hostfs build
>...

Thanks that fixed it.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
