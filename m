Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKfjB-0008Sv-2g	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 10:28:21 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EKfj8-000481-3G
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 10:28:21 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	<200509281359.48449.blaisorblade@yahoo.it>
	<20050928160946.GB12888@ccure.user-mode-linux.org>
In-Reply-To: <20050928160946.GB12888@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281926.44813.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 19:26:43 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Young Koh <young.koh@gmail.com>

On Wednesday 28 September 2005 18:09, Jeff Dike wrote:
> On Wed, Sep 28, 2005 at 01:59:48PM +0200, Blaisorblade wrote:

> > That wasn't the original reason - this is fine too, but as I explained in
> > the other mail, cat /dev/kmem will cause a copy_to_user() with invalid
> > kernel ("from") address. I remember because I discussed this with you at
> > length.

> Oh yeah.  I was thinking there was a different (and better) reason, but I
> couldn't remember what it was.

> Also, my reason isn't that good anyway.  I had a different fix a while ago,
> but it got lost somewhere.  I added an arch hook to get_free_pages which
> touched each allocated page under the cover of a setjmp.  If a page
> couldn't be allocated on the host, then it is put on a "bad pages" list,
> and another page is allocated instead.
I'm not sure that would help anyway - if the host memory is full, it's full. 
It's just matter of waiting and retrying.

I don't think the host would SIGBUS again on the same page specifically - or 
better, I'm almost sure this is not done.
So, I don't see the reason for that. Catching SIGSEGV/SIGBUS is ok, taking 
another page is bad.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
