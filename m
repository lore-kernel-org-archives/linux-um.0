Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKJwe-0007yQ-Bi	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 11:12:48 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EKJwb-0004rp-SF
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 11:12:48 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
Message-ID: <20050927172812.GA28528@ccure.user-mode-linux.org>
References: <3524bf1f050927070645b999bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3524bf1f050927070645b999bd@mail.gmail.com>
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
Date: Tue, 27 Sep 2005 13:28:12 -0400
To: Young Koh <young.koh@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Sep 27, 2005 at 10:06:53AM -0400, Young Koh wrote:
> my question is, if so, shouldn't the error be caught when UML kernel
> translates the user space address to the kernel space address? i mean,
> UML kernel must know the valid memory regions and if the address is
> out of the valid regions, then it knows the address is invalid before
> UML tries to access the address. why should it use sigsetjmp() and let
> a segfault occur?

Because the address may be fine, and an access may still cause a segfault.

UML memory is backed by a file on the host.  You can map anything from
the file you want, but if you access it when the host filesystem is full
or you've exceeded your disk quota, the access will segfault.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
