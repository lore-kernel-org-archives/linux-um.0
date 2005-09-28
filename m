Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKacW-00087G-Bh	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 05:01:08 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EKacU-00012U-Cj
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 05:01:08 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	<20050927172812.GA28528@ccure.user-mode-linux.org>
In-Reply-To: <20050927172812.GA28528@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281359.48449.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 13:59:48 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Young Koh <young.koh@gmail.com>

On Tuesday 27 September 2005 19:28, Jeff Dike wrote:
> On Tue, Sep 27, 2005 at 10:06:53AM -0400, Young Koh wrote:
> > my question is, if so, shouldn't the error be caught when UML kernel
> > translates the user space address to the kernel space address? i mean,
> > UML kernel must know the valid memory regions and if the address is
> > out of the valid regions, then it knows the address is invalid before
> > UML tries to access the address. why should it use sigsetjmp() and let
> > a segfault occur?
>
> Because the address may be fine, and an access may still cause a segfault.
>
> UML memory is backed by a file on the host.  You can map anything from
> the file you want, but if you access it when the host filesystem is full
> or you've exceeded your disk quota, the access will segfault.
That wasn't the original reason - this is fine too, but as I explained in the 
other mail, cat /dev/kmem will cause a copy_to_user() with invalid kernel 
("from") address. I remember because I discussed this with you at length.
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
