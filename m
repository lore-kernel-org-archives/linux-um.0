Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ujJw-0000il-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 18:54:00 -0700
Received: from nks-mail-02.nks.net ([66.152.21.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19ujJv-0007ex-Ut
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 18:54:00 -0700
Message-ID: <3F569B0D.4060803@nks.net>
From: James Neal <jneal@nks.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] uml_utilities_20030903
References: <200309032033.h83KXM6b013752@ccure.karaya.com>
In-Reply-To: <200309032033.h83KXM6b013752@ccure.karaya.com>
Content-Type: multipart/mixed;
 boundary="------------020407020209020304050702"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 03 Sep 2003 21:53:17 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------020407020209020304050702
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jeff Dike wrote:
> The main addition in this update is COW V3 support in uml_moo.  uml_mkcow
> is also here, although I wouldn't get too attached to it since I'm thinking
> about moving it into uml_moo and making that the Swiss Army knife of COW file
> manipulation.

Here's the uml_moo.c patch which allows the user to provide the path to
the backing store, overriding the path listed in the COW file.  Useful
when manipulating a COW file created in a chrooted jail.

Updated for uml_utilities_20030903.

Anything you'd like done to it to would make it merge in easier?

-James

--------------020407020209020304050702
Content-Type: text/plain;
 name="uml_moo.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uml_moo.c.patch"

--- uml_moo.c.orig	Wed Sep  3 12:38:48 2003
+++ uml_moo.c	Wed Sep  3 21:17:55 2003
@@ -38,7 +38,7 @@ static inline void ubd_set_bit(int bit, 
 	data[n] |= (1 << off);
 }
 
-int create_backing_file(char *in, char *out)
+int create_backing_file(char *in, char *out, char *old)
 {
 	int cow_fd, back_fd, in_fd, out_fd;
 	struct stat buf;
@@ -65,10 +65,15 @@ int create_backing_file(char *in, char *
 		exit(1);
 	}
 
+	if(old != NULL) {
+		backing_file = old;
+	}
+
 	if(stat(backing_file, &buf) < 0) {
 		perror("Stating backing file");
 		exit(1);
 	}
+
 	if(buf.st_size != size){
 		fprintf(stderr,"Size mismatch (%ld vs %ld) of COW header "
 			"vs backing file \"%s\"\n", (long int) size, 
@@ -192,13 +197,15 @@ int create_backing_file(char *in, char *
 
 int Usage(char *prog) {
 	fprintf(stderr, "%s usage:\n", prog);
-	fprintf(stderr, "\t%s <COW file> <new backing file>\n", prog);
-	fprintf(stderr, "\t%s -d <COW file>\n", prog);
+	fprintf(stderr, "\t%s [ -O <old backing file> ] <COW file> <new backing file>\n", prog);
+	fprintf(stderr, "\t%s [ -O <old backing file> ] -d <COW file>\n", prog);
 	fprintf(stderr, "Creates a new filesystem image from the COW file "
 		"and its backing file.\n");
 	fprintf(stderr, "Specifying -d will cause a destructive, in-place "
 		"merge of the COW file into\n");
 	fprintf(stderr, "its current backing file\n");
+	fprintf(stderr, "Specifying -O <old backing file> overrides the backing_file\n");
+	fprintf(stderr, "field specified in the COW file.\n");
 	fprintf(stderr, "%s supports version 1 and 2 COW files.\n", prog);
 	exit(1);
 }
@@ -206,6 +213,7 @@ int Usage(char *prog) {
 int main(int argc, char **argv)
 {
 	char *prog = argv[0];
+	char *real_backing_file = NULL;
 	int in_place = 0;
 
 	argv++;
@@ -220,13 +228,23 @@ int main(int argc, char **argv)
 		argc--;
 	}
 
+	if(!strcmp(argv[0], "-O")){
+		real_backing_file = argv[1];
+		argv++;
+		argc--;
+
+		argv++;
+		argc--;
+
+	}
+
 	if(in_place){
 		if(argc != 1) Usage(prog);
-		create_backing_file(argv[0], NULL);
+		create_backing_file(argv[0], NULL, real_backing_file);
 	}
 	else {
 		if(argc != 2) Usage(prog);
-		create_backing_file(argv[0], argv[1]);
+		create_backing_file(argv[0], argv[1], real_backing_file);
 	}
 	return 0;
 }

--------------020407020209020304050702--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
