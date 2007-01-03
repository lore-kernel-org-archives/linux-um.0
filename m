Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H2f1Q-000575-9h for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Jan 2007 18:41:32 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H2f1O-0001EA-Op
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Jan 2007 18:41:32 -0800
Date: Wed, 3 Jan 2007 14:22:59 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070103192259.GA5348@ccure.user-mode-linux.org>
References: <200612292341.kBTNfR3s005529@ccure.user-mode-linux.org>
	<200701031607.34683.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200701031607.34683.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 1/6] UML - Console locking fixes
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Jan 03, 2007 at 04:07:34PM +0100, Blaisorblade wrote:
> > +	spin_lock(&line->count_lock);
> > +	if(!line->valid)
> > +		goto out_unlock;
> > +
> > +	err = 0;
> > +	if(tty->count > 1)
> > +		goto out_unlock;
> >
> > -	/* The IRQ which takes this lock is not yet enabled and won't be run
> > -	 * before the end, so we don't need to use spin_lock_irq.*/
> > -	spin_lock(&line->lock);
> > +	mutex_lock(&line->open_mutex);
> > +	spin_unlock(&line->count_lock);
> 
> This is an obnoxious thing to do unless you specifically prove otherwise. 

Didn't I?  
The proof goes like this:
	we only take the semaphore if tty->count == 1, in which case
we are opening the device for the first time and there can't be anyone
else looking at it, so the mutex_lock won't sleep.

However, now that you're making me think about it again, I'm wondering
about the sanity of introducing a mutex which is guaranteed not to
sleep.

This is starting to make sense, with (tty->count > 1) being the
OPENING flag:

> In the first solution, you can create a OPENING flag (via a state variable), 
> and add the rule that (unlike the count) nobody but the original setter is 
> allowed to change it, and that who finds it set (say a concurrent open) must 
> return without touching it.

Then, I think the mutex can just be thrown away.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
