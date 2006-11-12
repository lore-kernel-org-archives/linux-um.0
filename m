Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GjHFt-0001nF-VI for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Nov 2006 07:28:22 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GjHFs-0005bu-DM
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Nov 2006 07:28:21 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 12 Nov 2006 16:28:07 +0100
References: <p0zwERnRDXpq.XPXM1lKY1g1VZeW131q++g@sphinx.mythic-beasts.com>
In-Reply-To: <p0zwERnRDXpq.XPXM1lKY1g1VZeW131q++g@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611121628.08051.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] comments in ubd_kern.c
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
Cc: Chris Lightfoot <chris@ex-parrot.com>

On Tuesday 04 October 2005 16:06, Chris Lightfoot wrote:
> Presently the code in ubd_kern.c carries the following
> comments:
>
>   - for ubd_handler,
>
>     /* Called without ubd_io_lock held */
>
>   - for do_ubd_request,
>
>     /* Called with ubd_io_lock held */
>
> ubd_handler locks ubd_io_lock before calling end_request,
> but it then calls do_ubd_request, after releasing the
> lock. But at the end of ubd_handler, it calls
> do_ubd_request, and doesn't acquire the spinlock before
> doing so. Am I missing something or is this an error?
Just to let you now - 1 year + since this mail, this error has been addressed, 
and when I'll have time I'll redo your patch for write barriers against new 
barrier infrastructure.

If you still want to do it you're welcome obviously, even if you obviously 
turned away to other stuff.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
