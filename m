Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <4113EA18.3040506@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
References: <410E5994.4060606@enterasys.com> <410E5CFA.5000504@enterasys.com>
In-Reply-To: <410E5CFA.5000504@enterasys.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6FA9E98DE9B0BD9C5AC48961"
Subject: [uml-devel] PATCH -- Was: link error MODE_SKAS and ! MODE_TT in
	2.4.26-2 + uml.sf.net patches
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
Date: Fri, 06 Aug 2004 16:29:12 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6FA9E98DE9B0BD9C5AC48961
Content-Type: multipart/mixed; boundary="------------080204000102010600030608"

This is a multi-part message in MIME format.
--------------080204000102010600030608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

this patch fixes the unresolved link time error
with a conditional around the definition of CAN_KMALLOC

and removes the unnedded -SEARCH_DIR line from dyn_link.ld.in
(this actually gets in the way if using a non- system toolchain
and it's removal should not affect any properly built toolchain).
--
db

D. Bahi wrote:
> sorry about my own follow up - it's a trivial bug:
> 
> rather than wrap CAN_KMALLOC with multiple macro conditionals
> to avoid 'tracing_pid' being referenced i just added the line
> 
>   int tracing_pid = -1
> 
> to arch/um/kern/skas/process.c so that it parallels kern/tt/tracer.c
> this might mask more critical references introduced in the future
> however. so the multiple macro fix would be the proper one i guess...
> 
> 
> D. Bahi wrote:
> 
>> i think this has been like this for some time... as i remember
>> trying to turn of TT completely in earlier releases:
>>
>> CONFIG_MODE_SKAS=y
>> CONFIG_X86_CMPXCHG=y
>> # CONFIG_MODE_TT is not set
>> # CONFIG_STATIC_LINK is not set
>>
>> results in:
>>
>> gcc -Wl,-T,arch/um/dyn_link.ld -Wl,-rpath,/lib  -Wl,--wrap,malloc 
>> -Wl,--wrap,free -Wl,--wrap,calloc \
>>         -o linux arch/um/main.o vmlinux.o -L/usr/lib -lutil
>> arch/um/main.o(.text+0x363): In function `__wrap_malloc':
>> arch/um/main.c:187: undefined reference to `tracing_pid'
>> arch/um/main.o(.text+0x3e2): In function `__wrap_free':
>> arch/um/main.c:231: undefined reference to `tracing_pid'
>> arch/um/main.o(.text+0x425):arch/um/main.c:235: undefined reference to 
>> `tracing_pid'
>> collect2: ld returned 1 exit status
>> make: *** [linux] Error 1
>>
>> arch/um/main.c:187 is in void *__wrap_malloc(int size)
>> ==>    else ret = um_vmalloc(size);
>>
>> arch/um/main.c:231 and :235 are in void __wrap_free(void *ptr)
>> ==>        if(CAN_KMALLOC())
>> ==>        if(CAN_KMALLOC())
>>
> 

--------------080204000102010600030608
Content-Type: text/plain;
 name="skas_no_tt_dynlink"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="skas_no_tt_dynlink"

--- linux-2.4.26_uml-patch-2.4.26-2um.orig/arch/um/dyn_link.ld.in	2004-08-01 07:52:46.000000000 -0400
+++ linux-2.4.26_uml-patch-2.4.26-2um_incrementals/arch/um/dyn_link.ld.in	2004-08-06 15:48:51.000000000 -0400
@@ -1,7 +1,7 @@
 OUTPUT_FORMAT("ELF_FORMAT")
 OUTPUT_ARCH(ELF_ARCH)
 ENTRY(_start)
-SEARCH_DIR("/usr/local/i686-pc-linux-gnu/lib"); SEARCH_DIR("/usr/local/lib"); SEARCH_DIR("/lib"); SEARCH_DIR("/usr/lib");
+
 /* Do we need any of these for elf?
    __DYNAMIC = 0;    */
 SECTIONS

--- linux-2.4.26_uml-patch-2.4.26-2um.orig/arch/um/main.c	2004-08-01 07:52:46.000000000 -0400
+++ linux-2.4.26_uml-patch-2.4.26-2um_incrementals/arch/um/main.c	2004-08-06 15:52:38.000000000 -0400
@@ -171,8 +171,13 @@
 	return(uml_exitcode);
 }
 
+#ifdef UML_CONFIG_MODE_TT
 #define CAN_KMALLOC() \
 	(kmalloc_ok && CHOOSE_MODE((getpid() != tracing_pid), 1))
+#else
+#define CAN_KMALLOC() \
+	(kmalloc_ok)
+#endif
 
 extern void *__real_malloc(int);
 

--------------080204000102010600030608--

--------------enig6FA9E98DE9B0BD9C5AC48961
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBE+oY3XQ4zakZ3z4RAi6IAJ0REAJbvWEJ0tOQGn5qsS4kvJc26gCbBCcR
V6ERMgek3pbm0GgiUa5w7D8=
=as1I
-----END PGP SIGNATURE-----

--------------enig6FA9E98DE9B0BD9C5AC48961--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
