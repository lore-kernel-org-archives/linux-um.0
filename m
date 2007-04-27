Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhUOx-0002Pp-VA for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 10:38:36 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HhUOw-000173-GE
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Apr 2007 10:38:35 -0700
Date: Fri, 27 Apr 2007 13:35:11 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070427173511.GA9373@c2.user-mode-linux.org>
References: <E1HhT90-0001dW-00@dorka.pomaz.szeredi.hu>
	<20070427172748.GC1046@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070427172748.GC1046@uranus.ravnborg.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Miklos Szeredi <miklos@szeredi.hu>

On Fri, Apr 27, 2007 at 07:27:48PM +0200, Sam Ravnborg wrote:
> Then atomic.h should include system.h and not rely on someone else doing it.
> Yes - then system.h may be included twice but that's ok.

I tried that - Andi didn't like it.  My current thinking is to pull the
cmpxchg stuff out of system.h into its own header since I don't see
any existing natural place to put it.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
