Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqAKg-0007fL-DI for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jun 2006 07:57:30 -0700
Received: from wr-out-0506.google.com ([64.233.184.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FqAKe-0004pY-Uk
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jun 2006 07:57:30 -0700
Received: by wr-out-0506.google.com with SMTP id i32so1303564wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 13 Jun 2006 07:57:27 -0700 (PDT)
Date: Tue, 13 Jun 2006 11:57:18 -0300
From: Alberto Bertogli <albertito@gmail.com>
Message-ID: <20060613145718.GB9729@gmail.com>
References: <20060514182541.GA4980@gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060514182541.GA4980@gmail.com>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 03:25:41PM -0300, Alberto Bertogli wrote:
> It begins to boot, but panics right after mounting root:
> 
> [42949373.800000] kjournald starting.  Commit interval 5 seconds
> [42949373.800000] EXT3-fs: mounted filesystem with ordered data mode.
> [42949373.800000] VFS: Mounted root (ext3 filesystem) readonly.
> [42949373.800000] Kernel panic - not syncing: handle_trap - failed to wait at end of syscall, errno = 0, status = 2943

I just wanted to report that this went away when trying 2.6.17-rc6 as a
host. It also works fine as a guest (after I patch it with
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17-rc4/patches/jmpbuf
so that it builds).

Besides, the random segfault problems I had with previous guests
versions also seem to be fixed.

Thanks a lot!

		Alberto



_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
