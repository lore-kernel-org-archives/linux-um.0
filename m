Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AfhBy-0000UN-Re for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 07:07:54 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AfhBy-0005rD-7o for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 07:07:54 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip0x400e51a4
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<200401072025.02885.blaisorblade_spam@yahoo.it>
	<a06020426bc2611122f8b@[192.168.1.10]>
In-Reply-To: <a06020426bc2611122f8b@[192.168.1.10]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401111334.04252.blaisorblade_spam@yahoo.it>
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
Date: Sun, 11 Jan 2004 13:34:04 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Alle 21:33, sabato 10 gennaio 2004, Johannes Formann ha scritto:
> At 20:25 Uhr +0100 07.01.2004, BlaisorBlade wrote:
> >The fix maybe is not perfect but something must go in. Also, if that
> > doesn't work, maybe the error is somewhere else (and triggered by this
> > change, as easily happens).
>
> Has anyone found an workaround to get modules working with 23-1?

Why do you say "modules"? I.e. do you get that problem in a special situation, 
like Jeff Chua that sees it only when he uses LVM? Does your UML uses an 
initrd to load some modules?

> For the Simpel Patch doesn't work, and I think Jeff has change a few
> things more in mem.c between 22-5 and 23-1.

Jeff Chua posted 2 patches. The second was shorter BUT I'm *at all* sure it 
cannot do anything (by having read and understood it). I think you should 
apply his first change, or, as a workaround, disable klogd from inside UML or 
remove /dev/kmem. Your guest will work anyway (and inserting the proper fix 
will require more time). Also, on my systems, inside UML, klogd doesn't use 
/dev/kmem.

--- linux/drivers/char/mem.c    Wed Jan  7 02:58:37 2004
+++ uml/drivers/char/mem.c      Wed Jan  7 03:07:52 2004
@@ -210,3 +210,2 @@
        char * kbuf; /* k-addr because vread() takes vmlist_lock rwlock */

-       p = (unsigned long) __va(p);
        if (p < (unsigned long) high_memory) {
@@ -269,3 +269,3 @@
        }
-       *ppos = __pa((void *) p);
+       *ppos = p;
        return virtr + read;

Also, I've posted below (in this thread) a message which explains what is the 
bug (search for "[tracked down]" in the subject). So the debug work should be 
complete. The problem is that properly fixing it is maybe hard.

-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
