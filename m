Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhUDk-0001Ez-U0 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 10:27:01 -0700
Received: from pasmtpa.tele.dk ([80.160.77.114])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HhUDj-0006Y8-FD
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 10:27:00 -0700
Date: Fri, 27 Apr 2007 19:27:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20070427172748.GC1046@uranus.ravnborg.org>
References: <E1HhT90-0001dW-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1HhT90-0001dW-00@dorka.pomaz.szeredi.hu>
Subject: Re: [uml-devel] [patch] uml: fix cmpxchg warnings in -mm
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: 8bit
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Apr 27, 2007 at 06:18:02PM +0200, Miklos Szeredi wrote:
> 
> From: Miklos Szeredi <mszeredi@suse.cz>
> 
> I get lot's of these on i386:
> 
> In file included from include/asm/atomic.h:10,
>                  from include/linux/file.h:9,
>                  from mm/fadvise.c:12:
> include/asm/arch/atomic.h: In function ‘atomic_add_unless’:
> include/asm/arch/atomic.h:240: warning: implicit declaration of function ‘cmpxchg’
> [...]
> 
> The problem seems to be that <asm-i386/atomic.h> assumes that
> <asm/processor.h> pulls in <asm/system.h>.

Then atomic.h should include system.h and not rely on someone else doing it.
Yes - then system.h may be included twice but that's ok.

	Sam

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
