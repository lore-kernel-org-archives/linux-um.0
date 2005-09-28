Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKhwj-0007Ye-Fo	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 12:50:29 -0700
Received: from qproxy.gmail.com ([72.14.204.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EKhwj-0000J0-Cz
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 12:50:29 -0700
Received: by qproxy.gmail.com with SMTP id p26so738840qbb
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 28 Sep 2005 12:50:21 -0700 (PDT)
Message-ID: <3524bf1f0509281225180173ae@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
In-Reply-To: <20050928145009.GA11610@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	 <20050927172812.GA28528@ccure.user-mode-linux.org>
	 <200509281359.48449.blaisorblade@yahoo.it>
	 <3524bf1f05092806477e590930@mail.gmail.com>
	 <20050928145009.GA11610@ccure.user-mode-linux.org>
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
Date: Wed, 28 Sep 2005 15:25:01 -0400
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

hi,

On 9/28/05, Jeff Dike <jdike@addtoit.com> wrote:
> On Wed, Sep 28, 2005 at 09:47:41AM -0400, Young Koh wrote:
> > yes, i think memory can go bad if 1) it cannot be allocated because of
> > filesystem full or similar reasons as Jeff described, or 2) it was
> > allocated once but could have been swapped.
> >
> > in case of 1) it should be more like kernel panic rather than just a
> > system call error, i think? because kernel cannot allocate any more
> > memory, which kernel is supposed to use.
>
> No, just that page is bad.  Another page could have been dirtied and thus
> allocated on the host, and it would be usable.  So, it's not a fatal problem.
>

then, if just that page is bad, shouldn't UML kernel wait until
another page is usable(or force another page to be swapped out) and
allocate the free page? and proceed normal? i may be still confused.

Ok, my thought/idea/suggestion is that what if UML uses a TLB-like
table before it does the address translation? i mean, once there is a
valid mapping, UML inserts the address mapping(or page mapping) into a
software TLB. after that, for that userspace address, UML can search
the software TLB table and use the mapping without calling sigsetjmp()
and walking through page tables. it seems that sigsetjmp() has
relatively large overhead, we could reduce some overhead by not
calling it. but surely the problem is the mapping can go corrupted.
for that, UML may invalidate a TLB entry if the corresponding page is
swapped out or any change is made. what do you think?

thank you,


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
