Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKfUW-0007gv-LZ	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 10:13:12 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EKfUR-00085M-76
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 10:13:09 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
Message-ID: <20050928160946.GB12888@ccure.user-mode-linux.org>
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	<20050927172812.GA28528@ccure.user-mode-linux.org>
	<200509281359.48449.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509281359.48449.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 12:09:46 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>

On Wed, Sep 28, 2005 at 01:59:48PM +0200, Blaisorblade wrote:
> That wasn't the original reason - this is fine too, but as I explained in the 
> other mail, cat /dev/kmem will cause a copy_to_user() with invalid kernel 
> ("from") address. I remember because I discussed this with you at length.

Oh yeah.  I was thinking there was a different (and better) reason, but I
couldn't remember what it was.

Also, my reason isn't that good anyway.  I had a different fix a while ago,
but it got lost somewhere.  I added an arch hook to get_free_pages which
touched each allocated page under the cover of a setjmp.  If a page couldn't
be allocated on the host, then it is put on a "bad pages" list, and another
page is allocated instead.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
