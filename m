Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DZwQ4-0006wd-Cy	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 May 2005 12:47:28 -0700
Received: from rproxy.gmail.com ([64.233.170.194])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DZwQ2-0000TS-9b	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 May 2005 12:47:28 -0700
Received: by rproxy.gmail.com with SMTP id f1so1134762rne
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 22 May 2005 12:47:25 -0700 (PDT)
Message-ID: <4290E1C6.9070709@gmail.com>
From: Eric BEGOT <eric.begot@gmail.com>
Reply-To: eric.begot@gmail.com
MIME-Version: 1.0
References: <200505201436.j4KEZxjh006235@ccure.user-mode-linux.org>
In-Reply-To: <200505201436.j4KEZxjh006235@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [PATCH] UML - 2.6.12-rc4-mm2 Compile error
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
Date: Sun, 22 May 2005 21:47:18 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Here is a patch to correct a compile error on linux 2.6.12-rc4-mm2 for uml.
At the compilation of init/main.c, it complains because it doens't find 
the 2 constants FIXADDR_USER_START and FIXADDR_USER_END


--- linux-2.6.12-rc4-mm2/include/asm/fixmap.h.orig 2005-05-22 
21:37:13.000000000 +0200
+++ linux-2.6.12-rc4-mm2/include/asm/fixmap.h 2005-05-22 
21:38:17.000000000 +0200
@@ -60,7 +60,8 @@ extern unsigned long get_kmem_end(void);

#define FIXADDR_TOP (get_kmem_end() - 0x2000)
#define FIXADDR_SIZE (__end_of_fixed_addresses << PAGE_SHIFT)
-#define FIXADDR_START (FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXADDR_USER_START (FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXADDR_USER_END FIXADDR_TOP

#define __fix_to_virt(x) (FIXADDR_TOP - ((x) << PAGE_SHIFT))
#define __virt_to_fix(x) ((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
@@ -91,7 +92,7 @@ static inline unsigned long fix_to_virt(

static inline unsigned long virt_to_fix(const unsigned long vaddr)
{
- BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
+ BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_USER_START);
return __virt_to_fix(vaddr);
}



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
