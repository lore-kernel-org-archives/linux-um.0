Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EM77u-00071W-Rl	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 09:55:50 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EM77s-0007Mf-FZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 09:55:51 -0700
From: Al Viro <viro@ftp.linux.org.uk>
Message-ID: <20051002165545.GP7992@ftp.linux.org.uk>
References: <200510021213.40191.blaisorblade@yahoo.it>
	<20051002155134.GA3777@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051002155134.GA3777@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: UML/2.6.14-rc3 doesn't work fixes
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 2 Oct 2005 17:55:45 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Alexander Viro <viro@zeniv.linux.org.uk>

On Sun, Oct 02, 2005 at 11:51:34AM -0400, Jeff Dike wrote:
> On Sun, Oct 02, 2005 at 12:13:39PM +0200, Blaisorblade wrote:
> > The patch in Al Viro's:
> > 
> > ecba97d4aacf4e80c56eb73e39af0369cb8539a4
> > 
> > messed up UML (in particular skas0, which doesn't boot any more - or maybe it 
> > boots one out of 10 times).
> > 
> > Btw: did Al CC you on it, at least?
> > 
> > The reason is that he messed up HOST_FRAME_SIZE on i386 (by using 
> > DEFINE_LONGS). I.e. HOST_FRAME_SIZE, which was 17, became 17/sizeof(long). 
> > Uh, nice.
> 
> He did, and I found the same problem and sent him back the fix.  I guess
> he sent in the original patch.

s/original/mismerged/ (note that original had more breakage in the same
file).  AFAICS, s/DEFINE_LONGS/DEFINE/ in that place is all that got lost.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
