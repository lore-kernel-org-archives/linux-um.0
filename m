Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMVMh-0007ev-Mk	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Oct 2005 11:48:43 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EMVMf-0004eo-1b
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Oct 2005 11:48:43 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Clearing kmalloc_ok during shutdown is broken -
	malloc will clear our data.
References: <200509281346.23592.blaisorblade@yahoo.it>
	<200510021231.05260.blaisorblade@yahoo.it> <434134CF.7040108@oracle.com>
In-Reply-To: <434134CF.7040108@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510032048.23868.blaisorblade@yahoo.it>
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
Date: Mon, 3 Oct 2005 20:48:23 +0200
To: Allan Graves <allan.graves@oracle.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Monday 03 October 2005 15:40, Allan Graves wrote:
> I'm not understanding why glibc would break the registers at will.
>  From setjmp:
>     /* NOTE: The machine-dependent definitions of `__sigsetjmp'
>        assume that a `jmp_buf' begins with a `__jmp_buf' and that
>        `__mask_was_saved' follows it.  Do not move these members
>        or add others before it.  */

> Seems to indicate to me that this isn't gonna change,
the comments above are mostly relative to the definitions of __sigsetjmp, i.e. 
to glibc internal code. Also, it's related to the layout of the structure, 
while our main problem is not the structure layout.
> and I'm using the 
> bits/setjmp.h defines, so if they do change, the code should just follow
> along with the change.  Am I missing something?
I didn't even see those constants - I stopped earlier, at __jmp_buf_tag. Given 
that it feels like a Glibc private thing, I worried.

Since those constants are explicitly exported, I guess that's for userspace 
programs as well, so Glibc provides that API as a public one.
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
