Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FSeIe-0001Fc-Nx for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Apr 2006 11:06:12 -0700
Received: from 213-140-2-72.ip.fastwebnet.it ([213.140.2.72]
	helo=aa005msg.fastwebnet.it)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FSeIc-0007ht-J7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Apr 2006 11:06:12 -0700
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20060409180709.GA20099@inferi.kami.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
Subject: [uml-devel] uml_utilities-20060323 fails to build on alpha
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
Date: Sun, 9 Apr 2006 20:07:09 +0200
To: UML-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I hear you say "who cares?" :)
Well, such failure uncovers a small bug on 64bit arches with __u64 not
defined as unsigned long long (oh, that "who cares" again :)).

cow.c: At top level:
cow.c:271: error: conflicting types for 'read_cow_header'
cow.h:25: error: previous declaration of 'read_cow_header' was here

the attached patch fixes it.

Thanks
-- 
mattia
:wq!

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="fix_moo_conflicting_types_for_read_cow_header.diff"

--- tools-20060323/moo/cow.c~clean	2006-04-09 19:10:15.324384228 +0200
+++ tools-20060323/moo/cow.c	2006-04-09 19:10:27.433140978 +0200
@@ -265,7 +265,7 @@
 
 int read_cow_header(int (*reader)(__u64, char *, int, void *), void *arg,
 		    __u32 *version_out, char **backing_file_out,
-		    time_t *mtime_out, unsigned long long *size_out,
+		    time_t *mtime_out, __u64 *size_out,
 		    int *sectorsize_out, __u32 *align_out,
 		    int *bitmap_offset_out)
 {

--k+w/mQv8wyuph6w0--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
