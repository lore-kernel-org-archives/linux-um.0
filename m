Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AbO92-00034B-Ll
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 30 Dec 2003 09:59:04 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AbO91-0000DF-O7
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 30 Dec 2003 09:59:03 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Repost [uml-devel] [PATCH] fix for: Host panic when UML reads host /dev/shm
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312301200.59090.blaisorblade_spam@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 30 Dec 2003 12:02:07 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Chua <jchua@fedex.com>


Ok here are the two patches one each for 2.4.23
and 2.6.0-test11
Linus has accepted the test11 patch into bk so
the next 2.6 kernel should have the fix
I have also been testing a 2.4.23 patch
They no longer oopes with any of my test programs
Since you were having problems here they are

Enjoy, James McMechan


diff -Nur linux-2.4.23/fs/readdir.c build-2.4.23-skas/fs/readdir.c
--- linux-2.4.23/fs/readdir.c   2002-08-02 17:39:45.000000000 -0700
+++ build-2.4.23-skas/fs/readdir.c      2003-12-10 06:01:05.000000000
-0800
@@ -69,6 +69,7 @@
                        loff_t n = file->f_pos - 2;

                        spin_lock(&dcache_lock);
+                       list_del(&cursor->d_child);
                        p = file->f_dentry->d_subdirs.next;
                        while (n && p != &file->f_dentry->d_subdirs) {
                                struct dentry *next;
@@ -77,7 +78,6 @@
                                        n--;
                                p = p->next;
                        }
-                       list_del(&cursor->d_child);
                        list_add_tail(&cursor->d_child, p);
                        spin_unlock(&dcache_lock);
                }

________________________________________________________________

-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
