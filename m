Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8O9M-0004ly-Hc for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:44:20 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D8O9J-00065k-08 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:44:20 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] uml_moo
References: <3809.83.109.31.19.1105785957.squirrel@83.109.31.19>
In-Reply-To: <3809.83.109.31.19.1105785957.squirrel@83.109.31.19>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Bc1KCEfW/gnrmhN"
Message-Id: <200503062016.17186.blaisorblade@yahoo.it>
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
Date: Sun, 6 Mar 2005 20:16:17 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
Cc: stian@nixia.no, Gigie Lertriniva <gigie_lertriniva@yahoo.com>

--Boundary-00=_Bc1KCEfW/gnrmhN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 15 January 2005 11:45, stian@nixia.no wrote:
> I have one issue with uml_moo.
>
> uml_moo and the kernel cow drivers doesn't seem to use the same method
> when calculating the size of the backing file.
>
> I used /dev/hdc1 which was an block device (147 GB partition)
>
> uml kernel perfectely finds the correct size. uml_moo uses stat on the
> device which gives size 0, og uml_moo fails.
Try the patch.
> Also I see that it is 
> compiled with 64bit file support, but shouldn't you define _GNU_SOURCE as
> well?
Well, it works, and no idea. Did you notice _XOPEN_SOURCE defined in 
moo/uml_moo.c? I'm in a hurry so I'm not checking the exact various 
situations.
> Since off_t didn't need %lld in the printf, but %ld as the 
> source-code now uses which is 32bit on i386 atleast. The last thingy was
> just a question.
Where?
>
> Stian
Somebody also complained about wrong text messages (no version 3 support is 
declared in the help). So I'm working also on the above.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_Bc1KCEfW/gnrmhN
Content-Type: text/x-diff;
  charset="utf-8";
  name="moo-little-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="moo-little-fixes.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 tools-paolo/moo/cow.c     |    2 +-
 tools-paolo/moo/cow_sys.h |    4 ++--
 tools-paolo/moo/uml_moo.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff -puN moo/cow.c~moo-little-fixes moo/cow.c
--- tools/moo/cow.c~moo-little-fixes	2005-03-06 19:42:38.580011064 +0100
+++ tools-paolo/moo/cow.c	2005-03-06 19:43:41.456452392 +0100
@@ -298,7 +298,7 @@ int read_cow_header(int (*reader)(__u64,
 	}
 	else if(version == 3){
 		if(n < sizeof(header->v3)){
-			cow_printf("read_cow_header - failed to read V2 "
+			cow_printf("read_cow_header - failed to read V3 "
 				   "header\n");
 			goto out;
 		}
diff -puN moo/uml_moo.c~moo-little-fixes moo/uml_moo.c
--- tools/moo/uml_moo.c~moo-little-fixes	2005-03-06 19:44:34.553380432 +0100
+++ tools-paolo/moo/uml_moo.c	2005-03-06 19:44:45.431726672 +0100
@@ -203,7 +203,7 @@ static char *usage_string = 
 "its current backing file\n"
 "Specifying -b overrides the backing_file specified in the COW file.  This is\n"
 "needed when dealing with a COW file that was created inside a chroot jail.\n"
-"%s supports version 1 and 2 COW files.\n"
+"%s supports version 1,2 and 3 COW files.\n"
 "";
 
 static int Usage(char *prog) {
diff -puN moo/cow_sys.h~moo-little-fixes moo/cow_sys.h
--- tools/moo/cow_sys.h~moo-little-fixes	2005-03-06 20:08:18.120965264 +0100
+++ tools-paolo/moo/cow_sys.h	2005-03-06 20:08:20.556594992 +0100
@@ -48,9 +48,9 @@ static inline int cow_seek_file(int fd, 
 
 static inline int cow_file_size(char *file, long long *size_out)
 {
-	struct stat buf;
+	struct stat64 buf;
 
-	if(stat(file, &buf) == -1){
+	if (stat64(file, &buf) == -1) {
 		cow_printf("Couldn't stat \"%s\" : errno = %d\n", file, errno);
 		return(-errno);
 	}
_

--Boundary-00=_Bc1KCEfW/gnrmhN--





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
