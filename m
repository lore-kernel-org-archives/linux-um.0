Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI7ng-0001R2-0m	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:50:28 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EI7nf-0004o4-Jn
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:50:28 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050918140951.31461.78736.stgit@zion.home.lan>
	<20050921034649.GX7992@ftp.linux.org.uk>
In-Reply-To: <20050921034649.GX7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211848.59856.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [PATCH 04/12] HPPFS: fix access to ppos and
	file->f_pos
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
Date: Wed, 21 Sep 2005 18:48:59 +0200
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Wednesday 21 September 2005 05:46, Al Viro wrote:
> On Sun, Sep 18, 2005 at 04:09:51PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> >  static ssize_t read_proc(struct file *file, char *buf, ssize_t count,
> >  			 loff_t *ppos, int is_user)
> >  {
> > @@ -228,17 +237,21 @@ static ssize_t read_proc(struct file *fi
> >  	if (read == NULL)
> >  		return -EINVAL;
> >
> > +	WARN_ON(is_user != (ppos != NULL));

> Eww....  Why not pass the right ppos in all cases?
Ok, can be done too. Was a bit in a hurry.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
