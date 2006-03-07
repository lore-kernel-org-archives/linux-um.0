Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FGhuF-0002U1-BB for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Mar 2006 11:31:39 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FGhuC-0004Vo-RS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Mar 2006 11:31:39 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_G+dDEutK51HKvGl"
Message-Id: <200603072031.18574.blaisorblade@yahoo.it>
Subject: [uml-devel] Real fix for rejected patch uaccess-warning
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
Date: Tue, 7 Mar 2006 20:31:15 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_G+dDEutK51HKvGl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

About
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.16-rc4/patches/uaccess-warning

I read the patch which was rejected and noticed that you put there style 
changes to get_user. They should be kept while the rest of the patch thrown 
away, obviously, as discussed, but reading that made me wonder at this 
(changes are just whitespace fixups):

-        const __typeof__(ptr) __private_ptr = ptr; \
-        __typeof__(*(__private_ptr)) __private_val; \
[...]
-	if (__copy_from_user(&__private_val, (__private_ptr), \
-	    sizeof(*(__private_ptr))) == 0) {\

Given that __private_ptr is a const pointer, __private_val is a const value, 
where we store something with __copy_from_user.
That's likely why GCC complains.

To fix that, we should remove some excess constness. Try the attached patch (I 
haven't GCC 4.1 installed).

Also, I wonder why all this complicate and extra type-checked calls are 
needed.

The i386 source use typeof only in 1 case, for put_user:
when I put_user((short)b, (unsigned long *) c) I must first cast (i.e. 
zero-extend) b to a long and only after write it to c; writing the 4/8 bytes 
pointed to by &b would be meaningless.

All this IMHO, obviously.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_G+dDEutK51HKvGl
Content-Type: text/x-diff; charset="us-ascii";
	name="uml-fix-const-warns-gcc-4_1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fix-const-warns-gcc-4_1"

Index: linux-2.6.git/include/asm-um/uaccess.h
===================================================================
--- linux-2.6.git.orig/include/asm-um/uaccess.h
+++ linux-2.6.git/include/asm-um/uaccess.h
@@ -42,7 +42,7 @@
 #define __get_user(x, ptr) \
 ({ \
         const __typeof__(ptr) __private_ptr = ptr; \
-        __typeof__(*(__private_ptr)) __private_val; \
+        __typeof__(*(ptr)) __private_val; \
         int __private_ret = -EFAULT; \
         (x) = (__typeof__(*(__private_ptr)))0; \
 	if (__copy_from_user(&__private_val, (__private_ptr), \
@@ -55,7 +55,7 @@
 
 #define get_user(x, ptr) \
 ({ \
-        const __typeof__((*(ptr))) __user *private_ptr = (ptr); \
+        __typeof__((*(ptr))) __user *private_ptr = (ptr); \
         (access_ok(VERIFY_READ, private_ptr, sizeof(*private_ptr)) ? \
 	 __get_user(x, private_ptr) : ((x) = 0, -EFAULT)); \
 })

--Boundary-00=_G+dDEutK51HKvGl--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
