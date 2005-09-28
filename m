Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKcpg-0007HY-7A	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 07:22:52 -0700
Received: from qproxy.gmail.com ([72.14.204.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EKcpf-0002HZ-2O
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 07:22:51 -0700
Received: by qproxy.gmail.com with SMTP id f10so675164qba
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 28 Sep 2005 07:22:45 -0700 (PDT)
Message-ID: <3524bf1f05092807222f9d0aed@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
In-Reply-To: <200509281041.15953.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	 <200509281041.15953.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 10:22:45 -0400
Content-Transfer-Encoding: 8bit
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

so, as my understanding, sigsetjmp() is used for returning an error
when there is a userspace and/or kernelspace address faulting in both
skas and tt modes. and i386 implementation works the same way, i
guess.

my one quick question is (it could sound stupid, but) that why there
may be a kernelspace faulting? kernel must correct and shouldn't
access bad address, i guess, and if so, shouldn't it be a kernel
panic?

> In fact, what you see doesn't catch user space wrong addresses.
>
> It catches kernelspace faulting addresses - which is legal to happen, because
> i386 implementation catches any fault, and doesn't make a distinction, and
> which happens, when you try to do things like "cat /dev/kmem" - you're trying
> to do copy_to_user(to, offset /* which is 0 */, size).
>
> In fact, that sigsegjmp() was added back in 2.4.24-?um (IIRC) and then around
> ~2.6.7-um after I and Jeff analyzed this.

i'm using 2.4.26 and 2.6.12 and i think both versions include sigsetjmp().

Thank you,

-Young


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
