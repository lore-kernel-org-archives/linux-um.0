Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BusFD-0001do-2N for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Aug 2004 05:30:15 -0700
Received: from imag.imag.fr ([129.88.30.1])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BusFC-0006HB-Ea
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Aug 2004 05:30:14 -0700
Received: from inrialpes.fr (iseran.inrialpes.fr [194.199.24.100])
	by imag.imag.fr (8.13.0/8.13.0) with ESMTP id i7BCU6NA012479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 11 Aug 2004 14:30:08 +0200 (CEST)
Message-ID: <411A114E.7050303@inrialpes.fr>
From: Aurelien Francillon <aurelien.francillon@inrialpes.fr>
Reply-To: aurelien.francillon@inrialpes.fr
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Subject: [uml-devel] [PATCH] insmod error with module, memcpy
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
Date: Wed, 11 Aug 2004 14:30:06 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

hi,
i am unable to insmod a external module which uses the memcpy function
against a 2.4.26-um2 kernel patched with the last patches from
http://user-mode-linux.sourceforge.net/patches.html
while this works with a 2.4.24 uml kernel.

With the following patch this works again for me,
but i really don't know if this is the right way to do this ?

aur=E9lien


--- linux-2.4.26-clean/arch/um/kernel/user_syms.c    Wed Aug 11 12:21:55=20
2004
+++ linux-2.4.26/arch/um/kernel/user_syms.c    Wed Aug 11 14:07:08 2004
@@ -1,34 +1,28 @@
 #include "linux/types.h"
 #include "linux/module.h"
=20
-/* XXX Deleted a number of symbols because they clashed strangely with=20
headers
- * Add them back later.
- */
-
-#if 0
 /* Some of this are builtin function (some are not but could in the=20
future),
  * so I *must* declare good prototypes for them and then EXPORT them.
  * The kernel code uses the macro defined by include/linux/string.h,
  * so I undef macros; the userspace code does not include that and I
  * add an EXPORT for the glibc one.*/
=20
+
 #undef strlen
+#undef strstr
 #undef memcpy
 #undef memset
=20
-EXPORT_SYMBOL_PROTO(strlen);
-EXPORT_SYMBOL_PROTO(memset);
-EXPORT_SYMBOL_PROTO(memcpy);
-#undef strstr
-
-EXPORT_SYMBOL_PROTO(strstr);
-
 extern size_t strlen(const char *);
 extern void *memcpy(void *, const void *, size_t);
 extern void *memset(void *, int, size_t);
-extern int printf(const char *, ...);
=20
-#endif
+EXPORT_SYMBOL(strlen);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+
+EXPORT_SYMBOL(strstr);
+
=20
 /* Here, instead, I can provide a fake prototype. Yes, someone cares:=20
genksyms.
  * However, the modules will use the CRC defined *here*, no matter if=20
it is




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
