Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AU6e5-0005vY-Of
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 10 Dec 2003 07:53:01 -0800
Received: from m17.lax.untd.com ([64.136.30.80])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AU6e5-0003GX-E2
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 10 Dec 2003 07:53:01 -0800
Message-ID: <20031210.073651.-388765.0.mcmechanjw@juno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: James W McMechan <mcmechanjw@juno.com>
Subject: [uml-devel] [PATCH] fix for: Host panic when UML reads host /dev/shm
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
Date: Wed, 10 Dec 2003 07:36:39 -0800
To: blaisorblade_spam@yahoo.it
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

Ok here are the two patches one each for 2.4.23
and 2.6.0-test11
Linus has accepted the test11 patch into bk so
the next 2.6 kernel should have the fix
I have also been testing a 2.4.23 patch
They no longer oopes with any of my test programs
Since you were having problems here they are

Enjoy, James McMechan

The problem was that the list_del was deleting
the cursor while the p pointer was at the cursor
the list_add_tail then oopes on the poisoned
pointers, since the cursor was to be deleted
anyway and should not be counted as a entry
it could be deleted earlier so p never points
to it, and then list_add_tail doesn't hit the
poisoned pointers in the cursor entry.
Of course the simple solution was after about
six much uglier patches that also fixed the
problem in other ways.

diff -Nur linux-2.6.0-test11/fs/libfs.c build-2.6.0-test11-bug/fs/libfs.c
      
--- linux-2.6.0-test11/fs/libfs.c       2003-11-26 12:42:48.000000000
-0800
+++ build-2.6.0-test11-bug/fs/libfs.c   2003-12-07 13:07:19.000000000
-0800
@@ -79,6 +79,7 @@
                        loff_t n = file->f_pos - 2;
                                                                         
      
                        spin_lock(&dcache_lock);                         
      
+                       list_del(&cursor->d_child);                      
      
                        p = file->f_dentry->d_subdirs.next;
                        while (n && p != &file->f_dentry->d_subdirs) {
                                struct dentry *next;
@@ -87,7 +88,6 @@                                                        
      
                                        n--;                             
      
                                p = p->next;                             
      
                        }                                                
      
-                       list_del(&cursor->d_child);                      
      
                        list_add_tail(&cursor->d_child, p);
                        spin_unlock(&dcache_lock);
                }

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
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
