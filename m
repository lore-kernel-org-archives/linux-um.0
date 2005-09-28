Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKf3M-0006Q4-Oi	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 09:45:08 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EKf2o-0002Lk-Ox
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 09:45:05 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	<200509281041.15953.blaisorblade@yahoo.it>
	<3524bf1f05092807222f9d0aed@mail.gmail.com>
In-Reply-To: <3524bf1f05092807222f9d0aed@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281843.58875.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 18:43:57 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>

On Wednesday 28 September 2005 16:22, Young Koh wrote:
> so, as my understanding, sigsetjmp() is used for returning an error
> when there is a userspace and/or kernelspace address faulting in both
> skas and tt modes. and i386 implementation works the same way, i
> guess.

> my one quick question is (it could sound stupid, 
Not at all.
> but) that why there 
> may be a kernelspace faulting? kernel must correct and shouldn't
> access bad address, i guess, and if so, shouldn't it be a kernel
> panic?
cat /dev/kmem, as I already said (won't repeat the whole story here). Yes, 
yes, yes, the kmem driver could check manually the address, but (same story 
as the rest):

*) checking by hand is slower
*) not needed, because for i386 works and other archs conform to i386.
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
