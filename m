Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsSDn-0001J5-TU
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 11:46:31 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AsSAj-0002i4-NB
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 11:43:21 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: 2.6.3-rc2 failure - was: Re: [uml-devel] Kernel idles in loop after loading IPv4
References: <1bf401c3f3eb$c35704f0$2000000a@schlepptopp>
In-Reply-To: <1bf401c3f3eb$c35704f0$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402152045.17138.blaisorblade_spam@yahoo.it>
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
Date: Sun, 15 Feb 2004 20:45:17 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: roland <for_spam@gmx.de>

Alle 18:47, domenica 15 febbraio 2004, roland ha scritto:
> hi !
> concerning the uml "hang" after  "NET: Registered protocol family 2":
>
> after some investigation i found, that the problem seems to have been
> introduced with uml-patch-2.6.0-1 (at
> http://prdownloads.sourceforge.net/user-mode-linux/uml-patch-2.6.0-1.bz2)
>
> uml-patch-2.6.0-test9-1 (at
> http://prdownloads.sourceforge.net/user-mode-linux/uml-patch-2.6.0-test9-1.
>bz2?download), in conjunction with minor compile-fix
> http://people.0x63.nu/~andersg/uml-minor-fixes.diff works nicely for me.

On what guest kernel do you apply the patch? uml-patch-2.6.0-1 gave strange 
problems with 2.6.1 vanilla kernel.

> seems there has been a major change (lots of merges?) in uml-patch-2.6.0-1
> because it`s much more bigger (around 2x) than uml-patch-2.6.0-test9-1
>
> btw:
> i use Bryan O'Sullivan`s skas patch on my host kernel. see:
> http://sourceforge.net/mailarchive/message.php?msg_id=5840691 since this
> patch isn`t based on steven james patch (which stephen williams patch is
> based of), it isn`t a skas issue, but a compiler or host-fs issue !? i`m on
> suse9 host.
You should try using, as skas patch, 
http://www.user-mode-linux.org/~blaisorblade/patches/2.6.2-v1-host-skas2/00-2.6.2-v1-host-SKAS2.patch.bz2, 
which comes from the latest one from Ingo Molnar. I have not been very 
careful, but when I gave a look to the Bryan's patch, it seemed likely to 
have similar problems as the other one. At least, both do only this change to 
write_ldt (i.e. don't use current->mm but let the caller specify which mm 
use):

-static int write_ldt(void __user * ptr, unsigned long bytecount, int oldmode)
+static int write_ldt(struct task_struct *task, void __user * ptr, unsigned 
long bytecount, int oldmode)
 {
-       struct mm_struct * mm = current->mm;
+       struct mm_struct * mm = task->mm;
        __u32 entry_1, entry_2, *lp;
        int error;
        struct user_desc ldt_info;

While Ingo Molnar's one does also this:

@@ -195,7 +197,7 @@

        down(&mm->context.sem);
        if (ldt_info.entry_number >= mm->context.size) {
-               error = alloc_ldt(&current->mm->context, 
ldt_info.entry_number+1, 1);
+               error = alloc_ldt(&mm->context, ldt_info.entry_number+1, 1);
                if (error < 0)
                        goto out_unlock;
        }

This second change is *needed*, whichever patch do you use: without it part of 
write_ldt uses current->mm instead of mm. That also means that alloc_ldt is 
not called on mm->context, so that probably it remains null and so we get 
Oopses.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
